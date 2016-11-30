//
//  Network.m
//  PtahInteractive
//
//  Created by ptah on 16/8/22.
//  Copyright © 2016年 Ptah. All rights reserved.
//
#import "NetWork.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"



@interface NetWork ()
{
    UILabel *_label;
}
@end

@implementation NetWork

+ (void)sendGetNetWorkWithUrl:(NSString *)url parameters:(NSDictionary *)dict hudView:(UIView *)hudView successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:hudView animated:YES];
    //    hud.labelText = @"正在加载数据...";
    
    //创建加载条
//    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    
//    view.center = hudView.center;
//    view.color = [UIColor colorWithRed:arc4random()%11*0.1 green:arc4random()%11*0.1  blue:arc4random()%11*0.1  alpha:0.8];
//    [view startAnimating];
//    view.hidesWhenStopped = YES;
//    [hudView addSubview:view];
    
    
    
    
    //[indicatorView stopAnimating];
    
    
    //
//    FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:CGRectMake(LFScreenW/2-75, LFScreenH/2-40, 150, 80)];
//    [hudView  addSubview:shimmeringView];
//    
//    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:shimmeringView.bounds];
//    loadingLabel.textAlignment = NSTextAlignmentCenter;
//    loadingLabel.textColor = [UIColor whiteColor];
//    loadingLabel.text = NSLocalizedString(@"Loading...", nil);
//    shimmeringView.contentView = loadingLabel;
//    shimmeringView.backgroundColor = TopBackGroudeColor;
//    // Start shimmering.
//    shimmeringView.shimmering = YES;
    
    
    
    //[SVProgressHUD show];
    
    //[SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeGradient];
    
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:hudView animated:YES];
        hud.labelText = @"Loading...";
    [hudView addSubview:hud];
  // let progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
//    progress.startAngle = -90
//    progress.progressThickness = 0.2
//    progress.trackThickness = 0.7
//    progress.clockwise = true
//    progress.center = view.center
//    progress.gradientRotateSpeed = 2
//    progress.roundedCorners = true
//    progress.glowMode = .Forward
//    progress.angle = 300
//    progress.setColors(UIColor.cyanColor() ,UIColor.whiteColor(), UIColor.magentaColor())
//    view.addSubview(progress) 
    
    
   
    AFHTTPSessionManager *manage111 = [AFHTTPSessionManager manager];

 
    manage111.responseSerializer = [AFHTTPResponseSerializer serializer];

    
    NSLog(@"<<url = %@>>", url);
    
   
    
    [manage111 GET:url parameters:dict success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:hudView animated:YES];
       // [view stopAnimating];
        [SVProgressHUD dismiss];
        //[GMDCircleLoader hideFromView:hudView animated:YES];
         // shimmeringView.shimmering = NO;
        id data = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"#########%@##########",data);
        
        
        
        
        successBlock(data);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"error:%@", error.localizedDescription);
        
        failureBlock(error.localizedDescription);
        
        // [GMDCircleLoader hideFromView:hudView animated:YES];
        
         [MBProgressHUD hideAllHUDsForView:hudView animated:YES];
        
    
       // [view stopAnimating];
       //   loadingLabel.text = NSLocalizedString(@"Fail", nil);
//        [SVProgressHUD dismiss];
    }];
}



+ (void)PostNetWorkWithUrl:(NSString *)url parameters:(NSDictionary *)dict hudView:(UIView *)hudView successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //创建加载条
    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    view.center = hudView.center;
    view.color = [UIColor redColor];
    [view startAnimating];
    view.hidesWhenStopped = YES;
    //[hudView addSubview:view];
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    manage.requestSerializer=[AFJSONRequestSerializer serializer];
    [manage.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil]];

    
    NSLog(@"<<url = %@>>", url);
    
 
    
   [manage POST:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        [view stopAnimating];
        
        id data = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"#########%@##########",data);
        
        
        
        
        successBlock(data);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        NSLog(@"error:%@", error.localizedDescription);
        
        failureBlock(error.localizedDescription);
        
        // [MBProgressHUD hideAllHUDsForView:hudView animated:YES];
        [view stopAnimating];
        
    }];
    
    
}

+ (void)PutNetWorkWithUrl:(NSString *)url parameters:(NSDictionary *)dict hudView:(UIView *)hudView successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    manage.requestSerializer=[AFJSONRequestSerializer serializer];
    [manage.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain" ,nil]];
    
    
    NSLog(@"<<url = %@>>", url);
    
    [manage PUT:url parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id data = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"#########%@##########",data);
        
        
        
        
        successBlock(data);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error.localizedDescription);
        
        failureBlock(error.localizedDescription);
        

    }];
    
    


}

//-(void)changgeColor{
//    [UIColor colorWithRed:arc4random()%11*0.1 green:arc4random()%11*0.1  blue:arc4random()%11*0.1  alpha:0.8];
//}
@end
