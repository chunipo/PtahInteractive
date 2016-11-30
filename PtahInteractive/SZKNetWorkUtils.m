//
//  NetWorkUtils.m
//  NetWorkReachability
//
//  Created by sunzhaokai on 16/5/17.
//  Copyright © 2016年 孙赵凯. All rights reserved.
//

#import "SZKNetWorkUtils.h"
#import "AFNetworkReachabilityManager.h"

@implementation SZKNetWorkUtils


#pragma mark----网络检测
+(void)netWorkState:(netStateBlock)block;
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    // 提示：要监控网络连接状态，必须要先调用单例的startMonitoring方法
    [manager startMonitoring];
    //检测的结果
    __block typeof(self) bself = self;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status==0||status==-1) {
            //弹出提示框
            [bself showWarningView];
            //将netState值传入block中
            block(status);
        }else{
            //将netState值传入block中
            block(status);
        }
    }];
}
#pragma mark---网络断开时弹出提示框
+(void)showWarningView
{
    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"Prompt" message:@"Network disconnection,please check the network Settings" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"To set up", nil];
    [alter show];
}
+(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        NSLog(@"取消");
    }else{
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

+(void)showNowifiView
{
    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"Prompt" message:@"You can only use WIFI ti download" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    

    [alter show];
}

@end
