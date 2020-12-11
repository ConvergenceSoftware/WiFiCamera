//
//  ViewController.m
//  WiFiCamera
//
//  Created by kui on 2020/12/9.
//

#import "ViewController.h"
#import "CameraBuffer.h"

@interface ViewController ()<CameraBufferDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CameraBuffer shareInstance].delegate = self;
    [[CameraBuffer shareInstance] startWiFiBox];
    
}


- (void)cameraBufferImage:(UIImage *)image {
    
    self.previewImageView.image = image;
    
}

- (void)cameraFPS:(NSInteger)cameraFPS {
        
}

- (void)disconnection {
    NSLog(@"disconnection");
}
 

@end
