//
//  RequestManager.m
//  CVGCCamera
//
//  Created by kui on 2021/1/22.
//

#import "RequestManager.h"
 
@implementation RequestManager

+ (RequestManager *)sharedManager {
    
    static RequestManager *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[RequestManager alloc] init];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", @"text/javascript", nil];
    });
    
    return manager;
}

- (void)getApi:(NSString *)path parameters:(id)params completed:(void (^)(id jsonData, NSError *error))completed {
      
    [[RequestManager sharedManager] GET:path parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        
        if (httpResponse.statusCode == 200) { //成功
            if ([responseObject isKindOfClass:[NSData class]]) {
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completed) {
                    completed(responseObject, nil);
                }
 
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completed) {
                    completed(nil, nil);
                }
            });
        }
  
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        if (completed) {
            completed(nil, nil);
        }
    
    }];
    
}
  
/// 设置参数
/// @param idValue 参数id跟值
/// @param completed 回调
- (void)setParameterWithIdValue:(NSString *)idValue completed:(void (^)(BOOL isSuccess))completed {
    
    NSString *url = NSStringFormat(@"%@%@",projectBaseURL,idValue);
    
    [[RequestManager sharedManager] getApi:url parameters:@{} completed:^(id  _Nonnull jsonData, NSError * _Nonnull error) {
 
        NSString *code = (NSString *)[jsonData objectForKey:@"result"];
        if ([code isEqualToString:@"0"]) {
            completed(YES);
        }else {
            completed(NO);
        }
    }];
}

/// 设置分辨率
/// @param tag 分辨率tag
/// @param completed 回调
+ (void)setResolutionWithTag:(NSString *)tag completed:(void (^)(BOOL isSuccess))completed {
    
    NSString *url = NSStringFormat(@"%@0&group=2&value=%@",projectBaseURL,tag);
      
    [[RequestManager sharedManager] getApi:url parameters:@{} completed:^(id  _Nonnull jsonData, NSError * _Nonnull error) {
       
        NSString *code = (NSString *)[jsonData objectForKey:@"result"];
        if ([code isEqualToString:@"0"]) {
            completed(YES);
        }else {
            completed(NO);
        }
    }];
}

/// 设置相机参数
/// @param parameterID 参数id
/// @param value 参数值
/// @param completed 回调
+ (void)setCameraParameterIDWithParameterID:(NSString *)parameterID value:(NSString *)value completed:(void (^)(BOOL isSuccess))completed {
    
    NSString *url = NSStringFormat(@"%@%@&group=1&value=%@",projectBaseURL,parameterID,value);
    
    [[RequestManager sharedManager] getApi:url parameters:@{} completed:^(id  _Nonnull jsonData, NSError * _Nonnull error) {
       
        NSString *code = (NSString *)[jsonData objectForKey:@"result"];
        if ([code isEqualToString:@"0"]) {
            completed(YES);
        }else {
            completed(NO);
        }
    }];
}
 
/// 设置对焦模式
/// @param status （YES手动对焦 NO自动对焦）
/// @param completed 回调
+ (void)setCameraFocusStatus:(BOOL)status completed:(void (^)(BOOL isSuccess))completed {
    
    NSString *url = NSStringFormat(@"%@10094860&group=1&value=%@",projectBaseURL,status == YES ? @"0" : @"1");
    
    [[RequestManager sharedManager] getApi:url parameters:@{} completed:^(id  _Nonnull jsonData, NSError * _Nonnull error) {
       
        NSString *code = (NSString *)[jsonData objectForKey:@"result"];
        if ([code isEqualToString:@"0"]) {
            completed(YES);
        }else {
            completed(NO);
        }
    }];
}

/// 设置对焦值
/// @param value 对焦值("min":"0","max":"255")
/// @param completed 回调
+ (void)setCameraFocusValue:(NSString *)value completed:(void (^)(BOOL isSuccess))completed {
    
    NSString *url = NSStringFormat(@"%@10094858&group=1&value=%@",projectBaseURL,value);
    
    [[RequestManager sharedManager] getApi:url parameters:@{} completed:^(id  _Nonnull jsonData, NSError * _Nonnull error) {
       
        NSString *code = (NSString *)[jsonData objectForKey:@"result"];
        if ([code isEqualToString:@"0"]) {
            completed(YES);
        }else {
            completed(NO);
        }
    }];
    
}
 
/// 设置白平衡状态
/// @param status (YES手动NO自动）
/// @param completed 回调
+ (void)setCameraWhiteBalanceStatus:(BOOL)status completed:(void (^)(BOOL isSuccess))completed {
    
    NSString *url = NSStringFormat(@"%@9963788&group=1&value=%@",projectBaseURL,status == YES ? @"0" : @"1");
    
    [[RequestManager sharedManager] getApi:url parameters:@{} completed:^(id  _Nonnull jsonData, NSError * _Nonnull error) {
       
        NSString *code = (NSString *)[jsonData objectForKey:@"result"];
        if ([code isEqualToString:@"0"]) {
            completed(YES);
        }else {
            completed(NO);
        }
    }];
}

/// 设置白平衡value
/// @param value （min:"2800","max:6500）
/// @param completed  回调
+ (void)setCameraWhiteBalanceValue:(NSString *)value completed:(void (^)(BOOL isSuccess))completed {
    
    NSString *url = NSStringFormat(@"%@9963802&group=1&value=%@",projectBaseURL,value);
    
    [[RequestManager sharedManager] getApi:url parameters:@{} completed:^(id  _Nonnull jsonData, NSError * _Nonnull error) {
       
        NSString *code = (NSString *)[jsonData objectForKey:@"result"];
        if ([code isEqualToString:@"0"]) {
            completed(YES);
        }else {
            completed(NO);
        }
    }];
    
}

/// 设置曝光状态
/// @param status (YES手动NO自动）
/// @param completed 回调
+ (void)setCameraExposureStatus:(BOOL)status completed:(void (^)(BOOL isSuccess))completed {
    
    NSString *url = NSStringFormat(@"%@10094849&group=1&value=%@",projectBaseURL,status == YES ? @"1" : @"3");
    
    [[RequestManager sharedManager] getApi:url parameters:@{} completed:^(id  _Nonnull jsonData, NSError * _Nonnull error) {
       
        NSString *code = (NSString *)[jsonData objectForKey:@"result"];
        if ([code isEqualToString:@"0"]) {
            completed(YES);
        }else {
            completed(NO);
        }
    }];
}

/// 设置曝光值
/// @param value 值
/// @param completed 回调
+ (void)setCameraExposureValue:(NSString *)value completed:(void (^)(BOOL isSuccess))completed {
    
    NSString *url = NSStringFormat(@"%@10094850&group=1&value=%@",projectBaseURL,value);
    
    [[RequestManager sharedManager] getApi:url parameters:@{} completed:^(id  _Nonnull jsonData, NSError * _Nonnull error) {
       
        NSString *code = (NSString *)[jsonData objectForKey:@"result"];
        if ([code isEqualToString:@"0"]) {
            completed(YES);
        }else {
            completed(NO);
        }
    }];
    
}
@end
