//
//  HistoryCell.h
//  PtahInteractive
//
//  Created by ptah on 16/8/11.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import <UIKit/UIKit.h>

@class History;
@interface HistoryCell : UITableViewCell
+(instancetype)cellWithtableView:(UITableView *)table;
@property(nonatomic,strong)History *model;
@property (nonatomic,copy) void (^btnClickedBlock)();
@property(nonatomic,strong)    UIButton      *Download;//下载
@end
