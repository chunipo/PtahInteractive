//
//  SetVc.m
//  PtahInteractive
//
//  Created by ptah on 16/8/9.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "SetVc.h"
#import "UserNameVc.h"
#import "SignOutVc.h"
#import "AppDelegate.h"
#import "HomeViewCtroller.h"
#import "MainNavigationControllerViewController.h"
#import "SZKCleanCache.h"

@interface SetVc ()<UIGestureRecognizerDelegate,UserNameDelegate>
{
    //1
//    UIView *_TopBackGroud;
    UIButton *_search;
//    UIButton *_menu;
    
    //
    UILabel             *_userLab;
    
    UILabel             *_cache;

}

@property(nonatomic,strong)NSString *userName;

@property(nonatomic,strong)AppDelegate *appDele;

@end

@implementation SetVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, TopH, LFScreenW, LFScreenH-TopH)];
    view.backgroundColor =UIgracolor;
    view.alpha = 0.1;
    [self.view addSubview:view];
    
//    [self createappDele];
//    
//    [self createTopView];
    
    [self createUI];
    
    
    
}

//-(void)createappDele{
//    self.appDele = [[UIApplication sharedApplication]delegate];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}
//#pragma arc 创建顶层视图
//-(void)createTopView{
//    _TopBackGroud = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, TopH)];
//    
//    _TopBackGroud.backgroundColor = TopBackGroudeColor;
//    
//    [self.view addSubview:_TopBackGroud];
//    
//    _menu = [[UIButton alloc]initWithFrame:CGRectMake(LFScreenW-20-picw, _TopBackGroud.frame.size.height-35, picw, pich)];
//    
//    [_menu setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
//    
//    [_TopBackGroud addSubview:_menu];
//    
//    
//    
//    _search = [[UIButton alloc]initWithFrame:CGRectMake(_menu.x-20-picw, _menu.y, picw, pich)];
//    
//    [_search setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
//    [_TopBackGroud addSubview:_search];
//    
////    //创建标题。。。。
////    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(LFScreenW/2-(LFScreenW*2/5/2),_menu.y , LFScreenW*2/5, pich)];
////    lab.text = @"Hot VR";
////    lab.textAlignment = NSTextAlignmentCenter;
////    lab.textColor = [UIColor whiteColor];
////    [_TopBackGroud addSubview:lab];
//    
//    
//    //back
//    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(10, _menu.y, picw+5, pich+5)];    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    [_TopBackGroud addSubview:back];
//    
//    
//    
//}
//
//-(void)back{
//    [self.navigationController popViewControllerAnimated:YES];
//    
//}

#pragma mark  UI----------------------------------------------------------------------------------------------------------

-(void)createUI{
    NSArray *arr = @[@"Setting",@"User Name",@"Download only with WIFI",@"Clean the cache memory",@"Update",@"Sign out"];
    for (int i =0; i<arr.count; i++) {
        UIImageView *viewBack = [[UIImageView alloc]initWithFrame:CGRectMake(0,i*LFScreenH/12+TopH , LFScreenW, LFScreenH/12)];
        [self.view addSubview:viewBack];
        viewBack.backgroundColor = [UIColor whiteColor];
        viewBack.userInteractionEnabled = YES;
        UILabel *lab = [[UILabel alloc]init];
        
        [lab setfram:CGRectMake(20, 10, LFScreenW*2/3, 20) text:arr[i] color:UIgracolor font:17];
        if (i==0) {
            viewBack.frame = CGRectMake(0,i*LFScreenH/12+TopH , LFScreenW, LFScreenH/12-10);
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, viewBack.height-1, LFScreenW, 1)];
            line.backgroundColor = UIgracolor;
            line.alpha = 0.1;
            [viewBack addSubview:line];
        }
        else if (i==1){
            
            
            viewBack.userInteractionEnabled = YES;
            viewBack.frame = CGRectMake(0,LFScreenH/12-10+TopH , LFScreenW, LFScreenH/12+10);
            lab.frame = CGRectMake(80, 20, LFScreenW/2, 20);
            _userLab = lab;
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, viewBack.height-1, LFScreenW, 1)];
            line.backgroundColor = UIgracolor;
            line.alpha = 0.2;
            [viewBack addSubview:line];
            
            //用户头像
            UIImageView *img = [[UIImageView alloc]init];
            [img setfram:CGRectMake(20, 8, 50, 50) image:@"setting_user" useinterface:NO];
            [viewBack addSubview:img];
            
            //编辑
            UIButton *editBtn = [[UIButton alloc]initWithFrame:CGRectMake(LFScreenW-40, 25, 20, 20)];
            [editBtn setImage:[UIImage imageNamed:@"setting_edit name"] forState:UIControlStateNormal];
            [editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
            [viewBack addSubview:editBtn];
            
        }
        else if (i==2){
            viewBack.frame =CGRectMake(0,2*LFScreenH/12+TopH+10, LFScreenW, LFScreenH/12);
            
            lab.frame = CGRectMake(20, 20, LFScreenW*2/3, 20);
            //wifi开关
            
            
            UIButton *switc = [[UIButton alloc]initWithFrame:CGRectMake(LFScreenW-70, 20, 50, 20)];
            [switc setImage:[UIImage imageNamed:@"setting_wifi open"] forState:UIControlStateNormal];
            [switc setImage:[UIImage imageNamed:@"setting_wifi close"] forState:UIControlStateSelected];
            [switc addTarget:self action:@selector(isOpenwifi:) forControlEvents:UIControlEventTouchUpInside];
            [viewBack addSubview:switc];
            
            NSDictionary* defaults = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
            if([defaults[@"onlyWifi"] isEqualToString:@"YES"]){
                switc.selected=NO;
            }else{
               switc.selected=YES;
            }
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, viewBack.height-1, LFScreenW, 1)];
            line.backgroundColor = UIgracolor;
            line.alpha = 0.4;
            [viewBack addSubview:line];
            
//            UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, -10, LFScreenW, 10)];
//            line2.backgroundColor = UIgracolor;
//            line2.alpha = 0.5;
//            [viewBack addSubview:line2];


        }
        else if (i==3){
            viewBack.frame =CGRectMake(0,3*LFScreenH/12+TopH+10, LFScreenW, LFScreenH/12);
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, viewBack.height-1, LFScreenW, 1)];
            line.backgroundColor = UIgracolor;
            line.alpha = 0.3;
            [viewBack addSubview:line];
            
            lab.frame = CGRectMake(20, 20, LFScreenW*2/3, 20);
            //右边清理
            UIImageView *jiantou = [[UIImageView alloc]init];
            [jiantou setfram:CGRectMake(LFScreenW-55, 8, 35, 35) image:@"other-menu_clean" useinterface:YES];
            [viewBack addSubview:jiantou];
            //右边显示缓存
            _cache = [[UILabel alloc]init];
            NSString *str  = [NSString stringWithFormat:@"%.2fM",[SZKCleanCache folderSizeAtPath]];
            [_cache setfram:CGRectMake(jiantou.x-55, lab.y+10, 50, 10) text:str color:UIgracolor font:12];
            _cache.textAlignment = NSTextAlignmentCenter;
            [viewBack addSubview:_cache];
            
             UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cleanCache)];
            [jiantou addGestureRecognizer:tapG];

        }
        else if (i==4){
            viewBack.frame =CGRectMake(0,4*LFScreenH/12+TopH+10, LFScreenW, LFScreenH/12);
            UILabel *lab2 = [[UILabel alloc]init];
            [lab2 setfram:CGRectMake(LFScreenW-40, 30, 30, 10) text:@"v1.5" color:UIgracolor font:12];
            [viewBack addSubview:lab2];
            
            lab.frame = CGRectMake(20, 20, LFScreenW/2, 20);

        }
        else if (i==5){
             viewBack.frame =CGRectMake(0,5*LFScreenH/12+TopH+10, LFScreenW, LFScreenH/12+10);
            lab.frame = CGRectMake(20, 30, LFScreenW/2, 20);
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, 10)];
            line.backgroundColor = UIgracolor;
            line.alpha = 0.1;
            [viewBack addSubview:line];
            
            UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, viewBack.height-1, LFScreenW, 1)];
            line2.backgroundColor = UIgracolor;
            line2.alpha = 0.5;
            [viewBack addSubview:line2];
            
            //手势
            UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapG:)];
            [viewBack addGestureRecognizer:tapG];
        }
        
        [viewBack addSubview:lab];
    }
    
    
    [self createTopView];
    [self deleteButton];
    
    [self HomeImg];
    //创建右上角菜单栏
//    [self blackHeimu];
//    [self createMenu];
    

}
-(void)HomeImg{
    UIButton *home = [[UIButton alloc]initWithFrame:CGRectMake(LFScreenW-20-picw, self.TopBackGroud.frame.size.height-35, picw, pich)];
    
    [home setImage:[UIImage imageNamed:@"edit-user-name_back to home"] forState:UIControlStateNormal];
    
    [home addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    
    [self.TopBackGroud addSubview:home];

}

-(void)home{
    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:[[MainNavigationControllerViewController alloc]initWithRootViewController:[[HomeViewCtroller alloc]init]]];

}

#pragma mark 修改用户名－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
-(void)edit{
    UserNameVc *userName = [[UserNameVc alloc]init];
    userName.delegate = self;
    
    
    userName.userName = self.userName;
    [self presentViewController:userName animated:YES completion:nil];
    
}
#pragma mark wifi打开／关闭
-(void)isOpenwifi:(UIButton *)btn{
    if (btn.selected==NO) {
        btn.selected =YES;
        [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"onlyWifi"];
        [SVProgressHUD showSuccessWithStatus:@"Set up"];


    }else{
        btn.selected=NO;
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"onlyWifi"];
          [SVProgressHUD showSuccessWithStatus:@"Set up"];
    }

}
#pragma mark 清理缓存
-(void)cleanCache{
    [SZKCleanCache cleanCache:^{
        _cache.text = @"0M";
        [SVProgressHUD showSuccessWithStatus:@"Cleared"];
    }];
}


#pragma mark 注销用户
-(void)tapG:(UITapGestureRecognizer *)tap{
//    if (self.appDele.isLogin==YES) {
    
    
    SignOutVc *signOut = [[SignOutVc alloc]init];
    
    [self presentViewController:signOut animated:YES completion:nil];
//    }
    
}

-(void)ChangeUserName:(NSString *)useName{
    self.userName = useName;
    _userLab.text = useName;
}



@end
