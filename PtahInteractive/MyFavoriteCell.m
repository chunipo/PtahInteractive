//
//  MyFavoriteCell.m
//  PtahInteractive
//
//  Created by ptah on 16/8/10.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "MyFavoriteCell.h"

#import "Collect.h"

@interface MyFavoriteCell ()
{
    UIImageView  *_pic;//图片
    
    UILabel      *_name;//图片名
    
    UIImageView  *_pic2;//类型
    UIImageView  *_pic3;//分辨率
    
    UILabel       *_size;//文件大小
    UILabel       *_collect;//收藏数
    
    UIImageView   *_collectImg;//灰色小爱心
    
    UIImageView   *_BigLove;//红色大爱心
    
    
}
@end


@implementation MyFavoriteCell


+(instancetype)cellWithtableView:(UITableView *)table{
    static NSString *ID = @"id";
    
    MyFavoriteCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[MyFavoriteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        [cell addSubview];
    }
    return cell;
    
}

-(void)addSubview{
    //图片
    _pic = [[UIImageView alloc]init];
    
    [_pic setfram:CGRectMake(0, 0, LFScreenW/3, LFScreenH/9) image:@"project-small" useinterface:NO];
    
    //图片名
    _name = [[UILabel alloc]init];
    [_name setfram:CGRectMake(_pic.maxX+10, 10, 200, _pic.height/4) text:@"BMW" color:[UIColor blackColor] font:15];
    
    //类型(视频或图片)
    _pic2 = [[UIImageView alloc]init];
    [_pic2 setfram:CGRectMake(_name.x, _name.maxY+5, 30, 30) image:@"animation-s" useinterface:NO];
    //_pic2.backgroundColor = [UIColor blueColor];
    
    //分辨率
    _pic3 = [[UIImageView alloc]init];
    [_pic3 setfram:CGRectMake(_pic2.maxX+5, _name.maxY+15, 45, 15) image:cqdy useinterface:NO];
    
    //文件大小
    _size = [[UILabel alloc]init];
    [_size setfram:CGRectMake(_pic3.maxX+5, _name.maxY+12, 40, 20) text:@"53.76M" color:UIgracolor font:11];
    
    //收藏数
    _collect = [[UILabel alloc]init];
    [_collect setfram:CGRectMake(_size.maxX+10, _size.y, 30, 20) text:@"309" color:UIgracolor font:12];
    _collect.textAlignment = NSTextAlignmentCenter;
    //灰色小爱心
    _collectImg = [[UIImageView alloc]init];
    [_collectImg setfram:CGRectMake(_collect.maxX, _size.y+5, 10, 10) image:@"favorite-other peole favorite" useinterface:NO];
    //红色大爱心
    _BigLove = [[UIImageView alloc]init];
    [_BigLove setfram:CGRectMake(LFScreenW-50, 25, 25, 25) image:@"favorite-my favorite" useinterface:NO];
    [self.contentView addSubview:_BigLove];
    [self.contentView addSubview:_collectImg];
    [self.contentView addSubview:_collect];
    [self.contentView addSubview:_size];
    [self.contentView addSubview:_pic3];
    [self.contentView addSubview:_pic2];
    [self.contentView addSubview:_pic];
    [self.contentView addSubview:_name];
}

-(void)setModel:(Collect *)model{
    _model = model;

    
    _name.text = model.displayName;
    _collect.text = model.favorite;
    [_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:ThumbnailImg,model.fileName]]];
    if (model.type==0) {
        _pic2.image = [UIImage imageNamed:@"panorama-s"];
    }
  
}

@end
