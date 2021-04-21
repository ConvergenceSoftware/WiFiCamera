//
//  RequestManager.h
//  CVGCCamera
//
//  Created by kui on 2021/1/22.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface RequestManager : AFHTTPSessionManager

+ (RequestManager *)sharedManager;

- (void)getApi:(NSString *)path parameters:(id)params completed:(void (^)(id jsonData, NSError *error))completed;
  
/// Set lens parameters
/// @param idValue 参数id跟值
/// @param completed 回调
- (void)setParameterWithIdValue:(NSString *)idValue completed:(void (^)(BOOL isSuccess))completed;


/// 设置分辨率
/// @param tag 分辨率tag
/// @param completed 回调
+ (void)setResolutionWithTag:(NSString *)tag completed:(void (^)(BOOL isSuccess))completed;
 
/// 设置相机参数
/// @param parameterID 参数id
/// @param value 参数值
/// @param completed 回调
+ (void)setCameraParameterIDWithParameterID:(NSString *)parameterID value:(NSString *)value completed:(void (^)(BOOL isSuccess))completed;

/// 设置对焦类型(Set focus type)
/// @param status （YES手动对焦 (Manual focus) NO自动对焦(auto focus)）
/// @param completed 回调
+ (void)setCameraFocusStatus:(BOOL)status completed:(void (^)(BOOL isSuccess))completed;

/// 设置对焦值
/// @param value 对焦值
/// @param completed 回调
+ (void)setCameraFocusValue:(NSString *)value completed:(void (^)(BOOL isSuccess))completed;

/// 设置白平衡状态
/// @param status (YES手动NO自动）
/// @param completed  回调
+ (void)setCameraWhiteBalanceStatus:(BOOL)status completed:(void (^)(BOOL isSuccess))completed;

/// 设置白平衡值
/// @param value （min:"2800","max:6500）
/// @param completed  回调
+ (void)setCameraWhiteBalanceValue:(NSString *)value completed:(void (^)(BOOL isSuccess))completed;

/// 设置曝光状态
/// @param status (YES手动NO自动）
/// @param completed 回调
+ (void)setCameraExposureStatus:(BOOL)status completed:(void (^)(BOOL isSuccess))completed;
 
/// 设置曝光值
/// @param value 值
/// @param completed 回调
+ (void)setCameraExposureValue:(NSString *)value completed:(void (^)(BOOL isSuccess))completed;

@end

NS_ASSUME_NONNULL_END
