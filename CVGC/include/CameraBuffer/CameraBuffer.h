//
//  CameraBuffer.h
//  CameraBuffer
//
//  Created by kui on 2020/12/9.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CameraBufferDelegate <NSObject>
 
/// 相机FPS (cameraFPS)
/// @param cameraFPS FPS
- (void)cameraFPS:(NSInteger)cameraFPS;

/// 每帧图片流(Picture per frame)
/// @param image image
- (void)cameraBufferImage:(UIImage *)image;

/// 中断(disconnection)
- (void)disconnection;
  
@end

@interface CameraBuffer : NSObject

+ (instancetype)shareInstance;

/// 释放单例
+ (void)releaseSharedInstance;

/// 开始任务
- (void)startWiFiBox;

/// 停止任务
- (void)stopTaskWiFiBox;
   
@property (nonatomic, weak) id<CameraBufferDelegate> delegate;

@end
