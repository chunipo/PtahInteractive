//
//  VRModel.h
//  PtahInteractive
//
//  Created by ptah on 16/8/8.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VRModel : NSObject


@property(nonatomic,strong)NSNumber *itemid;//类型
@property(nonatomic,strong)NSString *displayName;//显示名称
@property(nonatomic,strong)NSString *filename;//文件名称
@property(nonatomic,strong)NSString *viewed;//观看次数
@property(nonatomic,strong)NSNumber *favorite;//收藏次数
@property(nonatomic,strong)NSNumber *download;//下载次数
@property(nonatomic,strong)NSNumber *type;//类型
@property(nonatomic,strong)NSString *created;//shijian
@property(assign,nonatomic)BOOL selectState;//是否选中状态

@end
