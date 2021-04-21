//
//  CameraBuffer.m
//  CameraBuffer
//
//  Created by kui on 2020/12/9.
//

#import "CameraBuffer.h"

@interface CameraBuffer ()<NSURLSessionDelegate>

@property (nonatomic, strong) NSMutableData *responseData;

@property (nonatomic, strong) NSTimer *FPSTimer;

@property (nonatomic, strong) NSURLSession *cameraBufferSession;

@property (nonatomic, strong) NSURLSessionDataTask *cameraBufferDataTask;
 

@end

@implementation CameraBuffer
{
    int FPSNum;
    NSUInteger dataRang;
}
static CameraBuffer *manager = nil;
static dispatch_once_t onceToken;

+ (instancetype)shareInstance {

    if (!manager) {
        dispatch_once(&onceToken, ^{
            manager = [[CameraBuffer alloc]init];
            manager.FPSTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:manager selector:@selector(resetFPSData) userInfo:nil repeats:YES]; 
        });
    }
    return manager;
}
  
+ (void)releaseSharedInstance {
    
    [manager.FPSTimer invalidate];
    manager.FPSTimer = nil;
    [manager.cameraBufferSession invalidateAndCancel];
    [manager.cameraBufferDataTask suspend];
    manager = nil;
    onceToken = 0l;
}
  
#pragma mark--开始任务
- (void)startWiFiBox {
    
    [manager.cameraBufferSession invalidateAndCancel];
    [manager.cameraBufferDataTask suspend];
    [manager startWiFiBoxV2];
    
}
   
- (void)startWiFiBoxV2  {
 
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:@"http://192.168.8.10:8080/?action=stream"];
 
    //2.创建请求对象
    //请求对象内部默认已经包含了请求头和请求方法（GET） 
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //3.获得会话对象,并设置代理
    /*
     第一个参数：会话对象的配置信息defaultSessionConfiguration 表示默认配置
     第二个参数：谁成为代理，此处为控制器本身即manager
     第三个参数：队列，该队列决定代理方法在哪个线程中调用，可以传主队列|非主队列
     [NSOperationQueue mainQueue]   主队列：   代理方法在主线程中调用
     [[NSOperationQueue alloc]init] 非主队列： 代理方法在子线程中调用
     */
    manager.cameraBufferSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:manager delegateQueue:[NSOperationQueue mainQueue]];
    
 
    //4.根据会话对象创建一个Task(发送请求）
    manager.cameraBufferDataTask = [manager.cameraBufferSession dataTaskWithRequest:request];
    
    
    [manager clearData];
    dataRang = 0;
    manager.responseData = [NSMutableData data];
    //5.执行任务
    [manager.cameraBufferDataTask resume];
   
}
 
//1.接收到服务器响应的时候调用该方法
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    //在该方法中可以得到响应头信息，即response
    //NSLog(@"didReceiveResponse--%@",[NSThread currentThread]);
  
    //NSLog(@"response expect length:%lld", [(NSHTTPURLResponse *)response expectedContentLength]);
    dataRang = (NSInteger)[(NSHTTPURLResponse *)response expectedContentLength];
    //注意：需要使用completionHandler回调告诉系统应该如何处理服务器返回的数据
    //默认是取消的
    /*
     NSURLSessionResponseCancel = 0,        默认的处理方式，取消
     NSURLSessionResponseAllow = 1,         接收服务器返回的数据
     NSURLSessionResponseBecomeDownload = 2,变成一个下载请求
     NSURLSessionResponseBecomeStream        变成一个流
     */
    
    completionHandler(NSURLSessionResponseAllow);
}
 
//2.接收到服务器返回数据的时候会调用该方法，如果数据较大那么该方法可能会调用多次
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
 
    if (!manager) {
        return;
    }
    [manager.responseData appendData:data];
 
    Byte *bytes = (Byte *)data.bytes;
    if (bytes == NULL) {
        return;
    }
    
    if (manager.responseData.length == dataRang) {
        FPSNum++;  // 记录刷新次数
        UIImage *image = [UIImage imageWithData:manager.responseData];

        if (manager.delegate && [manager.delegate respondsToSelector:@selector(cameraBufferImage:)]) {
            [manager.delegate cameraBufferImage:image];
        }
        
        [manager clearData];
        
    }else if ((bytes[data.length - 2] == 0xff && bytes[data.length - 1] == 0xd9)) {
        [manager clearData];
    }
}

- (void)clearData {
    [manager.responseData resetBytesInRange:NSMakeRange(0, manager.responseData.length)];
    [manager.responseData setLength:0];
}

//3.当请求完成(成功|失败)的时候会调用该方法，如果请求失败，则error有值
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error  {
    
    if (manager.delegate && [manager.delegate respondsToSelector:@selector(disconnection)]) {
        [manager.delegate disconnection];
    }
       
}

#pragma mark--停止任务
- (void)stopTaskWiFiBox {
     
    [manager.cameraBufferSession invalidateAndCancel];
    [manager.cameraBufferDataTask suspend];
}
  
#pragma mark --FPS
- (void)resetFPSData {
 
    if (manager.delegate && [manager.delegate respondsToSelector:@selector(cameraFPS:)]) {
        [manager.delegate cameraFPS:FPSNum];
    }
    
    FPSNum = 0;
}
  
@end
