//
//  HistoryVc.h
//  PtahInteractive
//
//  Created by ptah on 16/8/11.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FatherVc.h"
@interface HistoryVc : FatherVc

@property(nonatomic,strong)NSString *filename;//图片名称

@property(nonatomic,strong)NSString *displayName;//文件名称

@property(nonatomic,strong)NSString *download;//下载次数

@property(nonatomic,strong)NSString *favorite;//收藏数

@property(nonatomic,strong)NSString *type;//图片or视频

@property(nonatomic,strong)NSString *created;//shijian


@end
