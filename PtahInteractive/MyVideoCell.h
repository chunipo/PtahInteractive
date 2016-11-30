//
//  MyVideoCell.h
//  PtahInteractive
//
//  Created by ptah on 16/8/8.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LocalModel;

@interface MyVideoCell : UITableViewCell

@property(strong,nonatomic)UIButton *isSelectBtn;//是否选中按钮
@property(strong,nonatomic)UIImageView *isSelectImg;//是否选中图片

@property(assign,nonatomic)BOOL selectState;//选中状态

//@property(nonatomic,strong)UIImageView *pic;
//
//@property(nonatomic,strong)UILabel *lab1;

//赋值
-(void)addTheValue:(LocalModel *)goodsModel;

@property(nonatomic,strong)LocalModel *localmodel;

@end
