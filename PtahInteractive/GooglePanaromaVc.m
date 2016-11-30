//
//  GooglePanaromaVc.m
//  PtahInteractive
//
//  Created by ptah on 16/8/31.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "GooglePanaromaVc.h"
#import "GVRPanoramaView.h"
@interface GooglePanaromaVc ()<GVRWidgetViewDelegate>
{
    UIView  *view;
     BOOL    _isPaused;
}

@property (strong, nonatomic)GVRPanoramaView *PanoramaView;
@end

@implementation GooglePanaromaVc


-(void)viewDidLoad{
    [super viewDidLoad];
    self.PanoramaView = [[GVRPanoramaView alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    _PanoramaView.delegate = self;
    
    _PanoramaView.enableCardboardButton = YES;
    _PanoramaView.enableFullscreenButton = YES;
    
    
    
   // [_PanoramaView loadImage:[UIImage imageNamed:@"pano1.jpg"]];
    if (self.type==0) {
        
    
   // UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.filename]]];
        
        //UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://love.doghouse.com.tw/image/wallpaper/011102/bf1554.jpg"]]];

//        UIImageView *i = [[UIImageView alloc]init];
//        
//        [i sd_setImageWithURL:[NSURL URLWithString:@"http://love.doghouse.com.tw/image/wallpaper/011102/bf1554.jpg"]];
        //异步加载
       // self.filename = @"http://love.doghouse.com.tw/image/wallpaper/011102/bf1554.jpg";
        UIImage *imagenn = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:self.filename];
        if (!imagenn) {
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:self.filename] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                NSLog(@"receivedSize=%li,expectedSize=%li",receivedSize,expectedSize);
            } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                [[SDImageCache sharedImageCache]storeImage:image forKey:self.filename toDisk:YES];
                [_PanoramaView loadImage:image];
                
            }];
        }else{
            [_PanoramaView loadImage:imagenn];
        }
        
//    [_PanoramaView loadImage:image];
        
        
    }
    else if(self.type==1){
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:self.filename]];
        
        
        [_PanoramaView loadImage:image];

    }else if (self.type==2){
        [_PanoramaView loadImage:self.image];
    }
    
    [self.view addSubview:_PanoramaView];
    
    [_PanoramaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
    }];
    
    
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
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(20, 15, 45, 45)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:back];
    
    for (UIView *view5 in self.PanoramaView.subviews) {
        if ([view5 isKindOfClass:[UIButton class]]) {
            view5.alpha = 0;
        }
    }
    //VR 按钮
    UIButton *vrBtn = [[UIButton alloc]init];
    [vrBtn setTitle:@"VR" forState:UIControlStateNormal];
    [vrBtn addTarget:self action:@selector(didTapCardboardButton:) forControlEvents:UIControlEventTouchUpInside];
    [vrBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view addSubview:vrBtn];
    [vrBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.right.offset(-30);
        
        make.height.width.equalTo(@50);
    }];


    
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
   // [self.navigationController popViewControllerAnimated:YES];
}

//点击carbBoard方法调用
-(void)didTapCardboardButton:(UIButton *)button{
    UIButton *cardboardButton = self.PanoramaView.subviews[2];
    [cardboardButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}


- (void)widgetViewDidTap:(GVRWidgetView *)widgetView{
    if (_isPaused==NO) {
        view.alpha = 0;
        _isPaused=YES;
    }else{
        _isPaused=NO;
        view.alpha = 0.3;
    }
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
