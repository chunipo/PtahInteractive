//
//  DownloadCell.m
//  PtahInteractive
//
//  Created by ptah on 16/8/29.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "DownloadCell.h"
@interface DownloadCell()
{
//    UIImageView  *_pic;//图片
//    
//    UILabel      *_name;//图片名
//    
//    UIImageView  *_pic2;//类型
    UIImageView  *_pic3;//分辨率
    
//    UILabel       *_size;//文件大小
    
    
//    UIButton      *_Download;//下载
    
    
}
@end


@implementation DownloadCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(LFScreenW, 0, LFScreenW, LFScreenH/9)];
        
        view.backgroundColor = UIgracolor;
        
        [self.contentView addSubview:view];
        
        UIImageView *pic = [[UIImageView alloc]init];
        [pic setfram:CGRectMake(27.5, view.height/2-20, 30, 40) image:@"local-video_top delete" useinterface:NO];
        [view addSubview:pic];
    }
    return self;
}

+(instancetype)cellWithtableView:(UITableView *)table{
    static NSString *ID = @"id";
    
    DownloadCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[DownloadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        [cell addSubview];
    }
    return cell;
    
}

-(void)addSubview{
    //图片
    _pic = [[UIImageView alloc]init];
    
    [_pic setfram:CGRectMake(0, 0, LFScreenW/3, LFScreenH/9) image:@"project-small" useinterface:YES];
    
    //图片名
    _name = [[UILabel alloc]init];
    [_name setfram:CGRectMake(_pic.maxX+10, 10, 200, _pic.height/4) text:@"BMW" color:[UIColor blackColor] font:15];
    
    //类型
    _pic2 = [[UIImageView alloc]init];
    [_pic2 setfram:CGRectMake(_name.x, _name.maxY+5, 30, 30) image:@"animation-s" useinterface:NO];
    //_pic2.backgroundColor = [UIColor blueColor];
    
    //分辨率
    _pic3 = [[UIImageView alloc]init];
    [_pic3 setfram:CGRectMake(_pic2.maxX+5, _name.maxY+15, 45, 15) image:Highdy useinterface:NO];
    
    //文件大小
    _size = [[UILabel alloc]init];
    [_size setfram:CGRectMake(_pic3.maxX+5, _name.maxY+12, 100, 20) text:@"53.76M" color:UIgracolor font:9];
    //下载
    _Download = [[UIButton alloc]initWithFrame:CGRectMake(LFScreenW-60, 25, 35, 35)];
    
    [_Download setImage:[UIImage imageNamed:@"download-download"] forState:UIControlStateNormal];
    
    [_Download addTarget:self action:@selector(btbClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //竖线
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(LFScreenW-5, 0, 5, LFScreenH/9)];
    line.backgroundColor = longStringColor;
    
    [self.contentView addSubview:line];
    [self.contentView addSubview:_Download];
    [self.contentView addSubview:_size];
    [self.contentView addSubview:_pic3];
    [self.contentView addSubview:_pic2];
    [self.contentView addSubview:_pic];
    [self.contentView addSubview:_name];
    
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, LFScreenH/9, LFScreenW-5, 0)];
    _progressView.progress = 0;
    
    
    _viewBlack = [[UIView alloc]init];
   // _viewBlack.frame = CGRectMake(0, 0, LFScreenW/3, LFScreenH/9);
    _viewBlack.backgroundColor = [UIColor blackColor];
    _viewBlack.alpha = 0.5;
    //[self.contentView addSubview:_viewBlack];
     [self.contentView addSubview:_progressView];

}


- (void)btbClicked:(UIButton *)sender {
    if (self.btnClickedBlock) {
        self.btnClickedBlock();
        
    }
    
}


@end
