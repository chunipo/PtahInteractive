//
//  gvrVc.m
//  PtahInteractive
//
//  Created by ptah on 16/8/24.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "gvrVc.h"
#import "GVRVideoView.h"


@interface gvrVc ()<GVRWidgetViewDelegate>
{
        BOOL    _isPaused;
        UIView  *view;
         UIView *_toolView;
    
       UIButton *_playOrPauseBtn;
    
       UISlider *_progressSlider;
    UILabel *_timeLabel;
}


@property (strong, nonatomic)GVRVideoView *VRPlayerView;


@property (weak, nonatomic) UIImageView *imageView;
//@property (strong, nonatomic)  UIView *toolView;
//@property (weak, nonatomic)  UIButton *playOrPauseBtn;
//@property (weak, nonatomic)  UISlider *progressSlider;
//@property (weak, nonatomic)  UILabel *timeLabel;
@end

@implementation gvrVc

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.VRPlayerView resume];
    self.VRPlayerView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    [UIApplication sharedApplication].statusBarHidden=YES;
    __weak typeof(self) weakSelf = self;
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
//    监听处理中，就可以针对具体的手机方向，来旋转Controller的View了，首先是旋转，然后是frame跟当前屏幕的适应。
    }




-(void)createUI{
    
    self.VRPlayerView= [[GVRVideoView alloc]init];
    
    _VRPlayerView.delegate = self;
    
    _VRPlayerView.enableCardboardButton = YES;
    _VRPlayerView.enableFullscreenButton = YES;
    _isPaused = NO;
    [self.view addSubview:_VRPlayerView];
    
    [_VRPlayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
    }];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"03_1.mp4" ofType:nil];
    //    NSLog(@"=======%@=======,",path);
    NSURL *url = [NSURL fileURLWithPath:path];
    [_VRPlayerView loadFromUrl :url ofType :kGVRVideoTypeStereoOverUnder];
    
    //[_VRPlayerView loadFromUrl:[NSURL   URLWithString:@"http://120.25.246.21/vrMobile/travelVideo/zhejiang_xuanchuanpian.mp4" ] ofType:kGVRVideoTypeMono];
    
    view = [UIView new];
    view.backgroundColor = [UIColor grayColor];
    view.alpha = 0.3;
    [self.view addSubview: view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.height.equalTo(@60);
    }];
    
    
    //back
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(20, 25, 45, 45)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:back];
    
    for (UIView *view5 in self.VRPlayerView.subviews) {
        if ([view5 isKindOfClass:[UIButton class]]) {
            view5.alpha = 0;
        }
    }
    //VR 按钮
    UIButton *vrBtn = [[UIButton alloc]init];
    [vrBtn setTitle:@"VR" forState:UIControlStateNormal];
    [vrBtn addTarget:self action:@selector(didTapCardboardButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:vrBtn];
    [vrBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.right.offset(-30);

        make.height.width.equalTo(@50);
    }];
    //进度条背景
    _toolView = [[UIView alloc]init];
    _toolView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_toolView];
    [_toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.right.offset(0);
        make.height.equalTo(@60);
        
    }];
    
    //进度条
    _progressSlider = [UISlider new];
    [_progressSlider setValue:0 animated:YES];
    
    [_toolView addSubview:_progressSlider];
    [_progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(80);
        make.right.offset(-30);
        make.top.offset(10);
        make.bottom.offset(20);
    }];
    
    
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
}

//点击carbBoard方法调用
-(void)didTapCardboardButton:(UIButton *)button{
    UIButton *cardboardButton = self.VRPlayerView.subviews[2];
    [cardboardButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

-(void)widgetViewDidTap:(GVRWidgetView  *)widgetView{
    if (_isPaused) {
        //[_VRPlayerView resume];
        view.alpha = 0;
        _toolView.alpha = 0;
    }else{
        //[_VRPlayerView pause];
        view.alpha=0.3;
        _toolView.alpha = 1;
    }
    _isPaused = !_isPaused;
}


//视频播放到某个位置时触发事件
//-(void)videoView:(GVRWidgetView  *)videoView didUpdatePosition:(NSTimeInterval)position{
//    if (position == videoView.duration) {
//        [_VRPlayerView seekTo:0];
//        [_VRPlayerView resume];
//    }
//}

//视频播放失败
-(void)widgetView:(GVRWidgetView  *)widgetView didFailToLoadContent:(id)content withErrorMessage:(NSString *)errorMessage{
    NSLog(@"播放错误");
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
