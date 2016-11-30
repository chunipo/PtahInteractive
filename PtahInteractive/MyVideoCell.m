//
//  MyVideoCell.m
//  PtahInteractive
//
//  Created by ptah on 16/8/8.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "MyVideoCell.h"
#import "LocalModel.h"

@interface MyVideoCell ()
{
    UIImageView   *_pic;
    
    UILabel       *_lab1;
}
@end

@implementation MyVideoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
      
        [self addSubviews];
        
        
    }
    return self;
}

-(void)addSubviews{

    //是否选中图片
    
    
    
    _isSelectImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, LFScreenH*3/24/2-11, 22, 22)];
    [self.contentView addSubview:_isSelectImg];
    
    _pic = [[UIImageView alloc]initWithFrame:CGRectMake(_isSelectImg.maxX+10, 10, LFScreenW*3/9, LFScreenH*3/24-20)];
    _pic.backgroundColor = [UIColor cyanColor];
    _pic.image = [ UIImage imageNamed:@"project-small"];
    [self.contentView addSubview:_pic];
    
    _lab1 = [[UILabel alloc]init];
    [_lab1 setfram:CGRectMake(_pic.maxX+20, LFScreenH*3/24/2-20, LFScreenW*4/9, 20) text:@"20160102_489846" color:[UIColor blackColor] font:15];
    [self.contentView addSubview:_lab1];
    
    UILabel *lab2 = [[UILabel alloc]init];
    [lab2 setfram:CGRectMake(_lab1.x, _lab1.maxY, _lab1.width, 20) text:@"00:00:00 / 00:00:56" color:UIgracolor font:12];
    //[self.contentView addSubview:lab2];
    

}

-(void)setLocalmodel:(LocalModel *)localmodel{
    _localmodel = localmodel;
    
    _pic.image = [UIImage imageWithData:localmodel.miniImg];
    
    _lab1.text = localmodel.imgName;
    
   
    


}

/**
 *  给单元格赋值
 *
 *  @param goodsModel 里面存放各个控件需要的数值
 */
-(void)addTheValue:(LocalModel *)goodsModel
{

    
    if (goodsModel.selectState)
    {
        _selectState = YES;
        _isSelectImg.image = [UIImage imageNamed:@"local-video_select2"];
    }else{
        _selectState = NO;
        _isSelectImg.image = [UIImage imageNamed:@"local-video_select1"];
    }
    
}


#pragma mark - 绘制Cell分割线 
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext(); CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor); CGContextFillRect(context, rect);
    //上分割线，
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1].CGColor); CGContextStrokeRect(context, CGRectMake(0, 0, rect.size.width, 1));

}

@end
