//
//  ViewController.m
//  WiFiCamera
//
//  Created by kui on 2020/12/9.
//

#import "ViewController.h"
#import "CameraBuffer.h"

#import "ShowDataViewController.h"

@interface ViewController ()<CameraBufferDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;

@property (weak, nonatomic) IBOutlet UILabel *fpsLab;
  
@property (weak, nonatomic) IBOutlet UIButton *reconnectBtn;

@property (weak, nonatomic) IBOutlet UIButton *exposureStatusBtn;

@property (weak, nonatomic) IBOutlet UIButton *whiteBalanceStatusBtn;

@property (weak, nonatomic) IBOutlet UIButton *focusStatusBtn;

@property (nonatomic, strong) NSTimer *timeTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CameraBuffer shareInstance].delegate = self;
}

- (void)cameraBufferImage:(UIImage *)image {
    
    self.previewImageView.image = image;
}

- (void)cameraFPS:(NSInteger)cameraFPS {
    
    self.fpsLab.text = NSStringFormat(@"FPS:%zd",cameraFPS);
}

- (IBAction)clickReconnectBtn:(UIButton *)sender {
     
    if (sender.selected) {
        [[CameraBuffer shareInstance] stopTaskWiFiBox];
    }else {
        [[CameraBuffer shareInstance] startWiFiBox];
    }
    
    sender.selected =! sender.selected;
    
}

- (void)disconnection {
    self.previewImageView.image = [UIImage imageNamed:@"WiFiCamera_Error"];
    self.reconnectBtn.selected = NO;
}
 
/// 点击获取镜头参数(Click to get lens parameters)
- (IBAction)clickLensParameterBtn:(id)sender {
    
    [[RequestManager manager] getApi:@"http://192.168.8.10:8080/input.json" parameters:@{} completed:^(id  _Nonnull jsonData, NSError * _Nonnull error) {
     
        if (jsonData) {
            ShowDataViewController *vc = [[ShowDataViewController alloc]init];
            NSString *str = NSStringFormat(@"%@",[NSObject dictionaryToJson:jsonData]);
            vc.textStr = str;
            [self presentViewController:vc animated:YES completion:^{
                
            }];
        }
    }];
    
}
 
- (IBAction)sliderExposure:(UISlider *)sender {
    
    if (!self.exposureStatusBtn.selected) {
        
        [self clickStatusBtnSwitch:self.exposureStatusBtn];
        
    }else {
        NSLog(@"%f",sender.value);
        [RequestManager setCameraExposureValue:NSStringFormat(@"%f",sender.value) completed:^(BOOL isSuccess) {
                    
        }];
    }
}

- (IBAction)sliderWhiteBalance:(UISlider *)sender {
    
    if (!self.whiteBalanceStatusBtn.selected) {
        
        [self clickStatusBtnSwitch:self.whiteBalanceStatusBtn];
        
    }else {
        NSLog(@"%f",sender.value);
        [RequestManager setCameraWhiteBalanceValue:NSStringFormat(@"%f",sender.value) completed:^(BOOL isSuccess) {
                    
        }];
    }
    
}

- (IBAction)sliderFocus:(UISlider *)sender {
    
    if (!self.focusStatusBtn.selected) {
        
        [self clickStatusBtnSwitch:self.focusStatusBtn];
        
    }else {
        NSLog(@"%f",sender.value);
        [RequestManager setCameraFocusValue:NSStringFormat(@"%f",sender.value) completed:^(BOOL isSuccess) {
                    
        }];
    }
    
}

- (IBAction)clickStatusBtnSwitch:(UIButton *)sender {
  
    sender.selected =! sender.selected;
    
    if (sender.tag == 0) {
        [RequestManager setCameraExposureStatus:sender.selected completed:^(BOOL isSuccess) {
            
        }];
    }else if (sender.tag == 1) {
        [RequestManager setCameraWhiteBalanceStatus:sender.selected completed:^(BOOL isSuccess) {
            
        }];
    }else {
        [RequestManager setCameraFocusStatus:sender.selected completed:^(BOOL isSuccess) {
            
        }];
    }
}

#pragma mark--点击减
- (IBAction)clickMinusBtnTouchDown:(UIButton *)sender {
    
    _timeTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(longTouch:) userInfo:@{@"type" : @"15"} repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:_timeTimer forMode:NSDefaultRunLoopMode];
    
}


- (IBAction)clickMinusBtn:(UIButton *)sender {
    
    
       [self timeTimerRelease];
       
       [self sendCameraFocusWithForward:NO];
    
}

#pragma mark--点击加
- (IBAction)clickPlusBtnTouchDown:(UIButton *)sender {
    
    _timeTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(longTouch:) userInfo:@{@"type" : @"85"} repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:_timeTimer forMode:NSDefaultRunLoopMode];
}

- (IBAction)clickPlusBtn:(UIButton *)sender {
    
    [self timeTimerRelease];
    
    [self sendCameraFocusWithForward:YES];
}

/// 发送对焦指令
/// @param forward YES前 NO后
- (void)sendCameraFocusWithForward:(BOOL)forward {
    
    NSString *startStr = forward == YES ? @"90" : @"20";
    NSString *stopStr = forward == YES ? @"80" : @"10";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_semaphore_t sem = dispatch_semaphore_create(0);
        for (NSInteger i = 0; i < 3; i++) {
            [RequestManager setCameraFocusValue:startStr completed:^(BOOL isSuccess) {

                dispatch_semaphore_signal(sem);
            }];
            dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);

            [RequestManager setCameraFocusValue:stopStr completed:^(BOOL isSuccess) {

                dispatch_semaphore_signal(sem);
            }];
            dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
             
        }
    });
}

- (void)longTouch:(NSTimer *)timer {
    
    NSLog(@"长按");
    NSString *valueStr = [[timer userInfo] objectForKey:@"type"];
 
    [RequestManager setCameraFocusValue:valueStr completed:^(BOOL isSuccess) {

    }];
    
}

- (void)timeTimerRelease {
    
    [RequestManager setCameraFocusStatus:YES completed:^(BOOL isSuccess) {

    }];
    
    if (_timeTimer.isValid) {
        [_timeTimer invalidate];
        _timeTimer = nil;
    }
}

@end
