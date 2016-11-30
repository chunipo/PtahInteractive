//
//  FatherVc.m
//  PtahInteractive
//
//  Created by ptah on 16/8/9.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "FatherVc.h"
#import "SearchViewController.h"
#import "SignOutVc.h"
#import "enrolVc.h"

@interface FatherVc ()
{
    //1
//    UIView *_TopBackGroud;
    UIButton *_search;
    UIButton *_menu;
    SearchViewController     *_searVc;
    
  
    
    //7
//    UIImageView              *_menuBackView;
//    BOOL                     _isOpen;
//    UIButton                 *_btn1;
//    UIButton                 *_btn2;
//    UIButton                 *_btn3;
//    
//    UIView                   *_btnLine1;
//    UIView                   *_btnLine2;
//    
//    UIView                   *_btnLine3;
//    
//    UIButton                 *_blackbt;
//    
//    UIImageView              *_SignoutImg;
//    UIImageView              *_RegisterImg;
//    
//    BOOL                     _isLogin;
//    
}


@end

@implementation FatherVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = GrayColor;
    
    //[self createTopView];
    //创建右上角菜单栏
   // [self createMenu];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}
-(void)deleteButton{
    if (_search&&_menu) {
        
    
    
        [_search removeFromSuperview];
        [_menu removeFromSuperview];
    }
}

#pragma arc 创建顶层视图
-(void)createTopView{
    _TopBackGroud = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, LFScreenH*1/11)];
    
    _TopBackGroud.backgroundColor = TopBackGroudeColor;
    
    [self.view addSubview:_TopBackGroud];
    
    _menu = [[UIButton alloc]initWithFrame:CGRectMake(LFScreenW-20-picw, _TopBackGroud.frame.size.height-35, picw, pich)];
    
    [_menu setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    
    [_menu addTarget:self action:@selector(menu:) forControlEvents:UIControlEventTouchUpInside];
    
    [_TopBackGroud addSubview:_menu];
    
    
    
    _search = [[UIButton alloc]initWithFrame:CGRectMake(_menu.x-20-picw, _menu.y, picw, pich)];
    [_search addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [_search setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [_TopBackGroud addSubview:_search];
    
    //创建标题。。。。
        self.IndextTtile = [[UILabel alloc]initWithFrame:CGRectMake(LFScreenW/2-(LFScreenW*2/5/2),_menu.y , LFScreenW*2/5, pich)];
        self.IndextTtile.text = @"";
        self.IndextTtile.textAlignment = NSTextAlignmentCenter;
        self.IndextTtile.textColor = [UIColor whiteColor];
        [_TopBackGroud addSubview:self.IndextTtile];

    
    //back
   UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(10, _menu.y, picw+5, pich+5)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_TopBackGroud addSubview:back];
    
    
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    
}

//搜索
-(void)search{
    _searVc = [[SearchViewController alloc]init];
    
    [self presentViewController:_searVc animated:YES completion:nil];
    
}




//-(void)menu:(id)sender{
//    
//    if (!_isOpen) {
//        [UIView animateWithDuration:0.3f animations:^{
//            _menuBackView.frame = CGRectMake(_menu.maxX-130, _menu.maxY+5, 130, 180);
//            
//            _btn1.frame =CGRectMake(10, 10+10, 80, 20);
//            
//            _btn2.frame =CGRectMake(10, 10+10+35, 80, 20);
//            
//            _btn3.frame =CGRectMake(10, 10+10+35*2, 80, 20);
//            
//            
//            _btnLine1.frame = CGRectMake(0, _btn1.maxY+7, _menuBackView.width, 1);
//            _btnLine2.frame = CGRectMake(0, _btn2.maxY+7, _menuBackView.width, 1);
//            
//            _btnLine3.frame = CGRectMake(0, _btn3.maxY+7, _menuBackView.width, 10);
//        }];
//        _isOpen = YES;
//    }else
//    {
//        [UIView animateWithDuration:0.3f animations:^{
//            _menuBackView.frame = CGRectMake(_menu.maxX, _menu.maxY+5, 0, 0) ;
//            
//            _btn1.frame =CGRectMake(0, 0, 0, 0);
//            
//            _btn2.frame =CGRectMake(0, 0, 0, 0);
//            
//            _btn3.frame =CGRectMake(0, 0, 0, 0);
//            
//            _btnLine1.frame = CGRectMake(0,0, 0, 0);
//            _btnLine2.frame = CGRectMake(0,0, 0, 0);
//            
//            _btnLine3.frame = CGRectMake(0, 0, 0, 0);
//        }];
//        _isOpen = NO;
//    }
//    
//    
//}
//
//
//#pragma mark 创建菜单栏－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
//
//-(void)createMenu{
//    _menuBackView = [[UIImageView alloc]init];
//    
//    [_menuBackView setfram:CGRectMake(_menu.maxX, _menu.maxY+5, 0, 0) image:@"other-menu_back" useinterface:YES];
//    
//    [self.view addSubview:_menuBackView];
//    
//    //
//    NSArray *arr = @[@"Setting",@"Help",@"Contact us"];
//    
//    _btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//    
//    [_btn1 setTitle:@"Setting       " forState:UIControlStateNormal];
//    
//    [_btn1 setTitleColor:UIgracolor forState:UIControlStateNormal];
//    
//    [_menuBackView addSubview:_btn1];
//    
//    
//    //
//    _btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//    
//    [_btn2 setTitle:@"Help           " forState:UIControlStateNormal];
//    
//    [_btn2 setTitleColor:UIgracolor forState:UIControlStateNormal];
//    
//    [_menuBackView addSubview:_btn2];
//    
//    //
//    _btn3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//    
//    [_btn3 setTitle:@"Contact us" forState:UIControlStateNormal];
//    
//    [_btn3 setTitleColor:UIgracolor forState:UIControlStateNormal];
//    
//    [_menuBackView addSubview:_btn3];
//    
//    
//    _btn1.titleLabel.font = [UIFont systemFontOfSize:13];
//    _btn2.titleLabel.font = [UIFont systemFontOfSize:13];
//    _btn3.titleLabel.font = [UIFont systemFontOfSize:13];
//    
//    
//    _btnLine1 = [[UIView alloc]initWithFrame:CGRectMake(0,0, 0, 0)];
//    _btnLine1.backgroundColor = GrayColor;
//    [_menuBackView addSubview:_btnLine1];
//    
//    
//    _btnLine2 = [[UIView alloc]initWithFrame:CGRectMake(0,0, 0, 0)];
//    _btnLine2.backgroundColor = GrayColor;
//    [_menuBackView addSubview:_btnLine2];
//    
//    
//    _btnLine3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//    _btnLine3.backgroundColor = GrayColor;
//    [_menuBackView addSubview:_btnLine3];
//    
//    
//    
//    
//}
//
//

#pragma mark 创建菜单栏－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

-(void)createMenu{
    _menuBackView = [[UIImageView alloc]init];
    
    [_menuBackView setfram:CGRectMake(_menu.maxX, _menu.maxY+5, 0, 0) image:@"other-menu_back" useinterface:YES];
    
    [self.view addSubview:_menuBackView];
    
    //
    NSArray *arr = @[@"Setting",@"Help",@"Contact us"];
    
    _btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    [_btn1 setTitle:@"Setting       " forState:UIControlStateNormal];
    
    [_btn1 setTitleColor:UIgracolor forState:UIControlStateNormal];
    
    [_menuBackView addSubview:_btn1];
    
    
    //
    _btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    [_btn2 setTitle:@"Help           " forState:UIControlStateNormal];
    
    [_btn2 setTitleColor:UIgracolor forState:UIControlStateNormal];
    
    [_menuBackView addSubview:_btn2];
    
    //
    _btn3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    [_btn3 setTitle:@"Contact us" forState:UIControlStateNormal];
    
    [_btn3 setTitleColor:UIgracolor forState:UIControlStateNormal];
    
    [_menuBackView addSubview:_btn3];
    
    
    _btn1.titleLabel.font = [UIFont systemFontOfSize:13];
    _btn2.titleLabel.font = [UIFont systemFontOfSize:13];
    _btn3.titleLabel.font = [UIFont systemFontOfSize:13];
    
    
    _btnLine1 = [[UIView alloc]initWithFrame:CGRectMake(0,0, 0, 0)];
    _btnLine1.backgroundColor = GrayColor;
    [_menuBackView addSubview:_btnLine1];
    
    
    _btnLine2 = [[UIView alloc]initWithFrame:CGRectMake(0,0, 0, 0)];
    _btnLine2.backgroundColor = GrayColor;
    [_menuBackView addSubview:_btnLine2];
    
    
    _btnLine3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    _btnLine3.backgroundColor = GrayColor;
    [_menuBackView addSubview:_btnLine3];
    
    
    
    //判断是否登录
    
    
    
    
    
    if (self.appDele.isLogin==YES) {
        _SignoutImg = [[UIImageView alloc]init];
        
        [_SignoutImg setfram:CGRectMake(0, 0, 0, 0) image:@"signout" useinterface:YES];
        
        [_menuBackView addSubview:_SignoutImg];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SignOut:)];
        
        [_SignoutImg addGestureRecognizer:tap];
        _SignoutImg.tag=700;
    }
    else  {
        _RegisterImg = [[UIImageView alloc]init];
        
        [_RegisterImg setfram:CGRectMake(0, 0, 0, 0) image:@"register" useinterface:YES];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SignOut:)];
        
        [_RegisterImg addGestureRecognizer:tap];
        _RegisterImg.tag=701;
        
        [_menuBackView addSubview:_RegisterImg];
        
    }
    
    
}

-(void)SignOut:(UITapGestureRecognizer *)tap{
    if (tap.view.tag==700) {
        SignOutVc *signVc = [[SignOutVc alloc]init];
        
        [self presentViewController:signVc animated:YES completion:nil];
    }
    else if(tap.view.tag==701){
        enrolVc *enrol = [[enrolVc alloc]init];
        [self presentViewController:enrol animated:YES completion:nil];
        
    }
}

-(void)menu:(id)sender{
            
            
            
            if (!_isOpen) {
                _blackbt.frame = CGRectMake(0, 0, LFScreenW, LFScreenH);
                [UIView animateWithDuration:0.3f animations:^{
                    _menuBackView.frame = CGRectMake(_menu.maxX-130, _menu.maxY+5, 130, 180);
                    
                    _btn1.frame =CGRectMake(10, 10+10, 80, 20);
                    
                    _btn2.frame =CGRectMake(10, 10+10+35, 80, 20);
                    
                    _btn3.frame =CGRectMake(10, 10+10+35*2, 80, 20);
                    
                    
                    _btnLine1.frame = CGRectMake(0, _btn1.maxY+7, _menuBackView.width, 1);
                    _btnLine2.frame = CGRectMake(0, _btn2.maxY+7, _menuBackView.width, 1);
                    
                    _btnLine3.frame = CGRectMake(0, _btn3.maxY+7, _menuBackView.width, 10);
                    
                    _SignoutImg.frame = CGRectMake(25, _btnLine3.maxY+15, 80, 25);
                    _RegisterImg.frame = CGRectMake(25, _btnLine3.maxY+10, 80, 30);
                    
                    
                }];
                _isOpen = YES;
            }else
            {
                [UIView animateWithDuration:0.3f animations:^{
                    _menuBackView.frame = CGRectMake(_menu.maxX, _menu.maxY+5, 0, 0) ;
                    
                    _btn1.frame =CGRectMake(0, 0, 0, 0);
                    
                    _btn2.frame =CGRectMake(0, 0, 0, 0);
                    
                    _btn3.frame =CGRectMake(0, 0, 0, 0);
                    
                    _btnLine1.frame = CGRectMake(0,0, 0, 0);
                    _btnLine2.frame = CGRectMake(0,0, 0, 0);
                    
                    _btnLine3.frame = CGRectMake(0, 0, 0, 0);
                    
                    _SignoutImg.frame = CGRectMake(0, 0, 0, 0);
                    _RegisterImg.frame = CGRectMake(0, 0, 0, 0);
                }];
                _isOpen = NO;
            }
            
            
        }
        
        -(void)blackHeimu{
            _blackbt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
            
            [_blackbt setImage:[UIImage imageNamed:@"blackview"] forState:UIControlStateNormal];
            _blackbt.clipsToBounds = YES;
            
            [_blackbt addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_blackbt];
            
        }
        -(void)close{
            _blackbt.frame = CGRectMake(0, 0, 0, 0);
            
            [UIView animateWithDuration:0.3f animations:^{
                _menuBackView.frame = CGRectMake(_menu.maxX, _menu.maxY+5, 0, 0) ;
                
                _btn1.frame =CGRectMake(0, 0, 0, 0);
                
                _btn2.frame =CGRectMake(0, 0, 0, 0);
                
                _btn3.frame =CGRectMake(0, 0, 0, 0);
                
                _btnLine1.frame = CGRectMake(0,0, 0, 0);
                _btnLine2.frame = CGRectMake(0,0, 0, 0);
                
                _btnLine3.frame = CGRectMake(0, 0, 0, 0);
                
                _RegisterImg.frame = CGRectMake(0, 0, 0, 0);
                _SignoutImg.frame = CGRectMake(0, 0, 0, 0);
            }];
            _isOpen = NO;
            
        }
        

@end
