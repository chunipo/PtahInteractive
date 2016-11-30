//
//  DownloadCell.h
//  PtahInteractive
//
//  Created by ptah on 16/8/29.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadCell : UITableViewCell
+(instancetype)cellWithtableView:(UITableView *)table;

@property(nonatomic,strong)UIImageView *pic;//图片

@property(nonatomic,strong)UIImageView *pic2;//类型

@property(nonatomic,strong)UILabel *name;//图片名

@property(nonatomic,strong)  UILabel       *size;//文件大小

@property(nonatomic,strong)    UIButton      *Download;//下载

@property(nonatomic,strong)UIProgressView *progressView;

@property(nonatomic,strong)UIView *viewBlack;//类型


@property (nonatomic,copy) void (^btnClickedBlock)();

@end
