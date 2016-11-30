//
//  SearchCell.m
//  PtahInteractive
//
//  Created by ptah on 16/8/18.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "SearchCell.h"

@interface SearchCell ()
{
    UIImageView        *_pic;
    
    UIImageView        *_rankImg;
    
    UILabel            *_rank;
}
@end

@implementation SearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cellWithtableView:(UITableView *)table{
    static NSString *ID = @"id";
    
    SearchCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.contentView.backgroundColor = GrayColor;
        [cell addSubview];
        
    }
    return cell;
    
}

-(void)addSubview{
    //图片
    _pic = [[UIImageView alloc]init];
    
    [_pic setfram:CGRectMake(10, 0, LFScreenW-20, LFScreenH*6/21-10) image:@"home_project" useinterface:YES];
    
    _rankImg = [[UIImageView alloc]init];
    [_rankImg setfram:CGRectMake(20, 10, 60, 20) image:@"search_project ranking" useinterface:NO];
//    _rankImg.backgroundColor = [UIColor orangeColor];
    
    
    _rank = [[UILabel alloc]init];
    
    [_rank setfram:CGRectMake(5, 5, _rankImg.width-10, 10) text:@"99" color:[UIColor whiteColor] font:12];
    _rank.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_pic];
    [self.contentView addSubview:_rankImg];
    [_rankImg addSubview:_rank];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
