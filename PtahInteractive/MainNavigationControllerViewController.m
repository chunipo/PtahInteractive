//
//  MainNavigationControllerViewController.m
//  PtahInteractive
//
//  Created by ptah on 16/8/4.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "MainNavigationControllerViewController.h"

@interface MainNavigationControllerViewController ()

@end

@implementation MainNavigationControllerViewController

//-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
//    self = [super initWithRootViewController:rootViewController];
//    
//    if (self) {
//        self.interfaceOrientation = UIInterfaceOrientationPortrait;
//        
//        self.interfaceOrientationMask = UIInterfaceOrientationMaskPortrait;
//    }
//
//    return self;
//}
//
//-(BOOL)shouldAutorotate{
//    return NO;
//}
//
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return self.interfaceOrientationMask;
//}
//
//-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return self.interfaceOrientation;
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.hidden = YES;
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    //self.navigationBar.barTintColor = UIColorFromRGB(9341);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
