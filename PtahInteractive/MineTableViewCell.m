//
//  MineTableViewCell.m
//  PtahInteractive
//
//  Created by ptah on 16/8/9.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell


#pragma mark - 绘制Cell分割线
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext(); CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor); CGContextFillRect(context, rect);
    //上分割线，
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:0.5].CGColor); CGContextStrokeRect(context, CGRectMake(0, 0, rect.size.width, 1));
    
}


@end
