//
//  PlayVideoViewController.m
//  VRVideoDemo
//
//  Created by ptah on 16/8/25.
//  Copyright © 2016年 Ptah. All rights reserved.
//



#import "PlayVideoViewController.h"
#import "VideoPlayView.h"
#import "FullViewController.h"


@interface PlayVideoViewController ()<VideoPlayViewDelegate>

/** 你需要个PlayerView用来播放 */
@property (nonatomic,strong) VideoPlayView *playView;
/** 全屏视图 */
@property (nonatomic,strong) FullViewController *fullVc;

@end

@implementation PlayVideoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    self.view.transform = CGAffineTransformMakeRotation(M_PI*0.5);
//    self.view.frame = CGRectMake(0, 0, LFScreenW, LFScreenH);
    [UIApplication sharedApplication].statusBarHidden=YES;

    // 创建playView，设置其代理
    self.playView  = [VideoPlayView videoPlayView];
    self.playView.delegate = self;
    self.fullVc = [[FullViewController alloc] init];
    
    //传入视频地址
    NSString *path = [[NSBundle mainBundle] pathForResource:@"03_1.mp4" ofType:nil];
    
    self.playView.path = path;
    
    // 设置frame添加到View上
//    self.playView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width*9/16);
    [self.view addSubview:self.playView];
    
    [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(back) name:@"back" object:nil];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
      [UIApplication sharedApplication].statusBarHidden=NO;
}

- (void)orientChange:(NSNotification *)noti {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    switch (orientation)
    {
        case UIDeviceOrientationPortrait: {
            [UIView animateWithDuration:0.25 animations:^{
                self.view.transform = CGAffineTransformMakeRotation(0);
                self.view.frame = CGRectMake(0, 0, LFScreenW, LFScreenH);
            }];
        }
            break;
        case UIDeviceOrientationLandscapeLeft: {
            [UIView animateWithDuration:0.25 animations:^{
                self.view.transform = CGAffineTransformMakeRotation(M_PI*0.5);
                self.view.frame = CGRectMake(0, 0, LFScreenW, LFScreenH);
            }];
        }
            break;
        case UIDeviceOrientationLandscapeRight: {
            [UIView animateWithDuration:0.25 animations:^{
                self.view.transform = CGAffineTransformMakeRotation(-M_PI*0.5);
                self.view.frame = CGRectMake(0, 0, LFScreenW, LFScreenH);
            }];
        }
            break;
        default:
            break;
    }
}



#pragma mark - playView代理，实现全屏
-(void)videoplayViewSwitchOrientation:(BOOL)isFull
{
    
    if (isFull) {
        [self presentViewController:self.fullVc animated:YES completion:^{
            self.playView.frame = self.fullVc.view.bounds;
            [self.fullVc.view addSubview:self.playView];
        }];
    } else {
        [self.fullVc dismissViewControllerAnimated:YES completion:^{
            [self.view addSubview:self.playView];
            // 这里设置返回时的frame
            self.playView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width*9/16);
        }];
    }
}






@end
