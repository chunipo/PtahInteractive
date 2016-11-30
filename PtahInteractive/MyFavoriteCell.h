//
//  MyFavoriteCell.h
//  PtahInteractive
//
//  Created by ptah on 16/8/10.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Collect;

@interface MyFavoriteCell : UITableViewCell

+(instancetype)cellWithtableView:(UITableView *)table;


@property(nonatomic,strong)Collect *model;

@end
