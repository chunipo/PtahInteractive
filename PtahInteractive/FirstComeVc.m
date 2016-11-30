//
//  FirstComeVc.m
//  PtahInteractive
//
//  Created by ptah on 16/8/24.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "FirstComeVc.h"
#import "enrolVc.h"
#import "AppDelegate.h"

@interface FirstComeVc ()

@end

@implementation FirstComeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    
}

-(void)createUI{
        UIImageView *vi = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, LFScreenH)];
        
        vi.image = [UIImage imageNamed:@"openning-back.jpg"];
        
        vi.userInteractionEnabled = YES;
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(LFScreenW/2-LFScreenW/6, LFScreenH*3/4, LFScreenW/3, 30)];
    
        [btn setImage:[UIImage imageNamed:@"start" ]forState:UIControlStateNormal];

        [btn addTarget:self action:@selector(vvv) forControlEvents:UIControlEventTouchUpInside];
    
        [self.view addSubview:vi];
        [vi addSubview:btn];
    
    
}

-(void)vvv{
    [UIView animateWithDuration:1.0f animations:^{
        self.view.alpha = 0.3;
    } completion:^(BOOL finished) {
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:[[enrolVc alloc]init]];
    }];
    
    
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
