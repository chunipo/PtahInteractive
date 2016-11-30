//
//  SignOutVc.m
//  PtahInteractive
//
//  Created by ptah on 16/8/18.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "SignOutVc.h"
#import "PtahDenluVc.h"

@interface SignOutVc ()

@end

@implementation SignOutVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:29./255 green:170./255 blue:243./255 alpha:1];
    [self createUI];
    
    [self LowImg];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createUI{
    UILabel *lb1 = [[UILabel alloc]init];
    [lb1 setfram:CGRectMake(30, LFScreenH*5/18, (LFScreenW-60), 20) text:@"Do you really want to sign out the app?" color:[UIColor whiteColor] font:17];
    lb1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb1];
    
    UILabel *lb2 = [[UILabel alloc]init];
    [lb2 setfram:CGRectMake(40,  lb1.maxY+5, (LFScreenW-80),20) text:@"ps : you can't download the VR project without singin" color:[UIColor whiteColor] font:11];
    lb2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb2];
    
    
    NSArray *arr = @[@"Yes,sign Out",@"No,go back"];
    NSArray *arr2 = @[@"search_frame",@"frame-2"];
    for (int i =0; i<2; i++) {
        UIImageView *backView = [[UIImageView alloc]init];
        [backView setfram:CGRectMake(lb2.x+5, lb2.maxY+20+45*i, lb2.width-10, 30) image:arr2[i] useinterface:NO];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(lb2.x+5, lb2.maxY+20+45*i, lb2.width-10, 30)];
        
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        
        btn.tag = 100+i;
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:backView];
        [self.view addSubview:btn];
        
    }
}

-(void)click:(UIButton *)btn{
    //Sign out
    if (btn.tag==100) {
    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:[[PtahDenluVc alloc]init]];
        
    }
    else if (btn.tag==101){
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}


-(void)LowImg{
    UILabel *lab= [[UILabel alloc]init];
    [lab setfram:CGRectMake(LFScreenW/2-40, LFScreenH-40, 80, 20) text:@"©2016 Tetris" color:[UIColor whiteColor] font:12];
    [self.view addSubview:lab];
       lab.textAlignment = NSTextAlignmentCenter;
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
