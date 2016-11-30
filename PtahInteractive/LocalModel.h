//
//  LocalModel.h
//  PtahInteractive
//
//  Created by ptah on 16/9/1.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Local;


@interface LocalModel : NSObject


@property(nonatomic,strong)NSString *imgName;
@property(nonatomic,strong)NSString *originalpic;
@property(nonatomic,strong)NSData *miniImg;
@property(nonatomic,strong)NSData *originalImg;
@property(nonatomic,assign)BOOL selectState;//是否选中状态
@property(nonatomic,strong)Local *localmodel;
@end
