//
//  ShowDataViewController.m
//  WiFiCamera
//
//  Created by kui on 2021/4/20.
//

#import "ShowDataViewController.h"

@interface ShowDataViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ShowDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = self.textStr;
    
}

 

@end
