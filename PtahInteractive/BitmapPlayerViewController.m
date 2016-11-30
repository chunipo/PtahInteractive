//
//  BitmapPlayerViewController.m
//  MD360Player4iOS
//
//  Created by ashqal on 16/5/21.
//  Copyright © 2016年 ashqal. All rights reserved.
//

#import "BitmapPlayerViewController.h"

@interface BitmapPlayerViewController ()<IMDImageProvider>

@end

@implementation BitmapPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initPlayer{
    
    /////////////////////////////////////////////////////// MDVRLibrary
    MDVRConfiguration* config = [MDVRLibrary createConfig];
    //是否vr
    [config displayMode:MDModeDisplayGlass];
    //默认陀螺仪是否打开
    [config interactiveMode:MDModeInteractiveMotion];
    //默认的视角模式
    [config projectionMode:MDModeProjectionDome180];
    [config asImage:self];
    
    [config setContainer:self view:self.view];
    [config pinchEnabled:true];
    
    self.vrLibrary = [config build];
    /////////////////////////////////////////////////////// MDVRLibrary
   
}

-(void) onProvideImage:(id<TextureCallback>)callback {
    //
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:self.mURL options:0
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                NSLog(@"progress:%ld/%ld",receivedSize,expectedSize);
                                // progression tracking code
                            }
                           completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                               if ( image && finished) {
                                   // do something with image
                                   if ([callback respondsToSelector:@selector(texture:)]) {
                                       
                                        [callback texture:image];
                    
                                       
                                   }
                               }
                           }];
    
    
}

// 锁死横屏
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

-(BOOL)shouldAutorotate{
    return NO;
}


@end
