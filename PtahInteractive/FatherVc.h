//
//  FatherVc.h
//  PtahInteractive
//
//  Created by ptah on 16/8/9.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface FatherVc : UIViewController
-(void)createTopView;
-(void)createMenu;
-(void)blackHeimu;

@property(nonatomic,strong)AppDelegate *appDele;

@property(nonatomic,strong)UIImageView              *menuBackView;

@property(nonatomic,assign)BOOL                     isOpen;
@property(nonatomic,strong) UIButton                 *btn1;
@property(nonatomic,strong) UIButton                 *btn2;
@property(nonatomic,strong) UIButton                 *btn3;
@property(nonatomic,strong)UIView                   *btnLine1;
@property(nonatomic,strong)UIView                   *btnLine2;
@property(nonatomic,strong)UIView                   *btnLine3;

@property(nonatomic,strong) UIButton                 *blackbt;
@property(nonatomic,strong)UIImageView              *SignoutImg;

@property(nonatomic,strong) UIImageView              *RegisterImg;


@property(nonatomic,assign) BOOL                     isLogin;

@property(nonatomic,strong)UIView *TopBackGroud;
@property(nonatomic,strong)UILabel *IndextTtile;

//删除搜索
-(void)deleteButton;

@end
