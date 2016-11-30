//
//  HomeViewCtroller.m
//  VRapp
//
//  Created by ptah on 16/8/3.
//  Copyright © 2016年 ptah. All rights reserved.
//



#import "Masonry.h"


#import "HomeViewCtroller.h"
#import "HotVRViewController.h"
#import "AnimationViewController.h"
#import "LocalVideoViewController.h"
#import "SearchViewController.h"
#import "LoadAnimationVc.h"
#import "MineTableViewCell.h"
#import "MineModel.h"
#import "SetVc.h"
#import "MyFavoriteVc.h"
#import "YCXMenu.h"
#import "HistoryVc.h"
#import "TeriManerger.h"
#import "AppDelegate.h"
#import "InRegister.h"
#import "SignOutVc.h"
#import "enrolVc.h"

#import "NetWork.h"
#import "VRModel.h"
#import "DownloadVc.h"

#import "SZKNetWorkUtils.h"


@interface HomeViewCtroller ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>

{
    //1
    UIView                   *_TopBackGroud;
    UIButton                  *_search;
    UIButton                 *_menu;
    SearchViewController     *_searVc;
    
    //2
    UIView                   *_MidBackGroud;
    UIView                   *_huad;
    HotVRViewController      *_hotvr;
    AnimationViewController  *_animaC;
    LocalVideoViewController *_local;
    LoadAnimationVc          *_LoadAnitVc;
    NSInteger                _i;
    UIButton                 *_bt;
    
    UILabel                  *_texttitlt;
    UILabel                  *_text1;
    UILabel                  *_text2;
    UILabel                  *_text3;
    UILabel                  *_text4;

    
    //mine
    UIView                   *_MineView;
    UIImageView              *_userBack;
    UITableView              *_tableView;
    UICollectionViewFlowLayout *_latyout;
    NSMutableArray           *_arrTable;
    SetVc                    *_setVc;
    MyFavoriteVc             *_MyfavoVc;
    BOOL                     _isMine;
    HistoryVc                *_historyVc;
    DownloadVc               *_downLoadVc;
    
   
    

    //3
    
    
    
    //4
    UICollectionReusableView *_header;
    UIScrollView             *_topScro;
    UIPageControl            *_pageControl;
    NSTimer                  *_XBtimer;
    
    
    //5
    UIImageView              *_load;
    
    
    //6
    UICollectionView         *_collectionview;
    NSMutableArray           *_arr;
    
    //7
    UIImageView              *_menuBackView;
    BOOL                     _isOpen;
    UIButton                 *_btn1;
    UIButton                 *_btn2;
    UIButton                 *_btn3;
    
    UIView                   *_btnLine1;
    UIView                   *_btnLine2;

    UIView                   *_btnLine3;
    
    UIButton                 *_blackbt;
    
    UIImageView              *_SignoutImg;
    UIImageView              *_RegisterImg;
    
    BOOL                     _isLogin;
    
    
    
    UIView                   *_bacccview;

    
    

}

@property (nonatomic , strong) NSMutableArray *items;

@property(nonatomic,strong)AppDelegate *appDele;


@end


@implementation HomeViewCtroller
@synthesize items = _items;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setting];
    
    //将滚动视图显示第一张（有bug）
    _topScro.contentOffset = CGPointMake(0, 0);
    
    //销毁mine视图
    if (!_isMine) {
        _texttitlt.textColor = [UIColor whiteColor];
        _text1.textColor = scroline;
        _texttitlt = _text1;
        
        _bt.selected = NO;
        _huad.frame = CGRectMake(0, _MidBackGroud.height-2, LFScreenW/4, 2);
        for (UIButton *btn in [_MidBackGroud subviews]) {
            if (btn.tag==100) {
                btn.selected=YES;
                _bt = btn;
            }
        }
        [_MineView removeFromSuperview];
    }
    //改变选定的按钮
    else{
        _texttitlt.textColor = [UIColor whiteColor];
        _text4.textColor = scroline;
        _texttitlt = _text4;
        
        
        _bt.selected = NO;
        _huad.frame = CGRectMake(LFScreenW*3/4, _MidBackGroud.height-2, LFScreenW/4, 2);
        for (UIButton *btn in [_MidBackGroud subviews]) {
            if (btn.tag==103) {
                btn.selected=YES;
                _bt = btn;
            }
        }

    }

}

-(void)setting{
    //默认只可以wifi
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"onlyWifi"]) {
        
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"onlyWifi"];
    }
    
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    //self.navigationBar.hidden = YES;
    
    self.view.backgroundColor = GrayColor;
    _bacccview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, LFScreenH)];
    _bacccview.backgroundColor = GrayColor;
    [self.view addSubview:_bacccview];
    
    _bt = [[UIButton alloc]init];
    
    //创建代理
    [self createAppdele];
   //创建导航栏上滴搜索
//    [self createItem];
    
   [self createTopView];
    
    [self createMidView];
    
    //创建第二层视图下的两个剩余按钮
    [self createLeftImg];
    
    //创建滑动试图
   // [self createscroview];
    
    //创建标题党
    //[self createTitle];
    
    //创建tableview
    //[self createTableView];
    [self sendWork];
    
    
    //
    
    //
    
    //
    
   
    

}

-(void)createAppdele{
    self.appDele = [UIApplication sharedApplication].delegate;
}



#pragma mark 创建第二层视图---------------------------------------------------------------------------

-(void)createMidView{
   

    
    
    _MidBackGroud = [[UIView alloc]initWithFrame:CGRectMake(0,TopH, LFScreenW, LFScreenH*3/22)];
    
    _MidBackGroud.backgroundColor = TopBackGroudeColor;
    [self.view addSubview:_MidBackGroud];
    
    NSArray *arr1 = @[@"Home",@"Hot",@"Local",@"Mine"];
    
    NSArray *arr2 = @[@"home_home-1",@"home_hot-1",@"home_local-1",@"home_mine-1"];
    
    NSArray *arr3 = @[HomeSelected,HotSelected,LocalVideoSelected,MineSelected];
    
    float midKw = (LFScreenW-arr1.count*btnW-2*kid)/3;
    for (int i =0; i<arr1.count; i++) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(kid+i*midKw +i*btnW, 10, btnW, btnH)];
        
        [btn setImage:[UIImage imageNamed:arr2[i] ]forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:arr3[i] ]forState:UIControlStateSelected];
        //[btn setShowsTouchWhenHighlighted:YES];
        
        btn.tag = 100+i;
        
        [_MidBackGroud addSubview:btn];
        
        [btn addTarget:self action:@selector(sliding:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(i*LFScreenW/4+9, btn.maxY-10, LFScreenW/5, 50)];
        
        lab.text = arr1[i];
        lab.tag=400+i;
        lab.textColor = [UIColor whiteColor];
        if (btn.tag==100) {
            btn.selected = YES;
            _bt = btn;
            
            lab.textColor = scroline;
            _text1=lab;
            _texttitlt=_text1;
        }
        
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:12];
        if (i==3) {
            lab.frame =CGRectMake(i*LFScreenW/4+9+5, btn.maxY-10, LFScreenW/5, 50);
            _text4 = lab;
        }
        if (i==1) {
            _text2 = lab;
        }
        if (i==2) {
            _text3 = lab;
        }
        
        if (LFScreenW==414) {
            if (i==0) {
                lab.frame =CGRectMake(i*LFScreenW/4+4, btn.maxY-10, LFScreenW/5, 50);

            }else if (i==2){
             lab.frame =CGRectMake(i*LFScreenW/4+9+5+3, btn.maxY-10, LFScreenW/5, 50);
            }else if (i==3){
                lab.frame =CGRectMake(i*LFScreenW/4+9+5+3, btn.maxY-10, LFScreenW/5, 50);
            }
        }
        
        [_MidBackGroud addSubview:lab];
    }
    //创建滑动条
    _huad = [[UIView alloc]initWithFrame:CGRectMake(0, _MidBackGroud.height-2, LFScreenW/4, 2)];
    _huad.backgroundColor = scroline;
    [_MidBackGroud addSubview:_huad];


}

-(void)sliding:(UIButton*)btn{
    _texttitlt.textColor = [UIColor whiteColor];
    _bt.selected = NO;
    btn.selected = YES;
    _bt = btn;
    [UIView animateWithDuration:0.2 animations:^{
        
        _huad.frame = CGRectMake(LFScreenW/4*(btn.tag-100),_MidBackGroud.height-2, LFScreenW/4, 2);
       
    }];
    
//    for (UILabel *lab in _MidBackGroud.subviews) {
//        if (lab.tag==(btn.tag+300)) {
//            lab.textColor = [UIColor orangeColor];
//            [_MidBackGroud addSubview:lab];
//        }else{
//            lab.textColor = [UIColor whiteColor];
//            [_MidBackGroud addSubview:lab];
//        }
//    }
    
    //hot
    if(btn.tag==101){
      _hotvr = [[HotVRViewController alloc]init];
       
        _hotvr.title = @"Hot VR";
   
       [self.navigationController pushViewController:_hotvr animated:YES];
        //[self.navigationController presentViewController:_hotvr animated:YES completion:nil];
        _text2.textColor = scroline;
        _texttitlt = _text2;
    
    }
    //local video
    else if(btn.tag==102){
        _local = [[LocalVideoViewController alloc]init];
        _local.title = @"Local Video";
        [self.navigationController pushViewController:_local animated:YES];
        
        _text3.textColor = scroline;
        _texttitlt = _text3;
    }
    //mine
    else if (btn.tag==103){
        
        _text4.textColor = scroline;
        _texttitlt = _text4;
        
        [self MineView];
        _isMine = YES;
        //菜单
        [self blackHeimu];
        //
        [self createMenu];
        
    }
    //home
    else if (btn.tag==100){
         _isMine = NO;
        [_MineView removeFromSuperview];
        
        _text1.textColor = scroline;
        _texttitlt = _text1;
    }
   
   
    
    

}
#pragma mark创建我的 视图－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
-(void)MineView{
    if(_MineView){
        [_MineView removeFromSuperview];
    }
    _MineView = [[UIView alloc]initWithFrame:CGRectMake(0, _MidBackGroud.maxY, LFScreenW, LFScreenH-_MidBackGroud.height)];
    
    _MineView.backgroundColor = [UIColor whiteColor];
    
    UIView *grayBlackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, _MineView.height)];
//    grayBlackView.backgroundColor = UIgracolor;
//    grayBlackView.alpha = 0.1;
    [_MineView addSubview:grayBlackView];
    
    [self.view addSubview:_MineView];
    
    
    
    //创建下部分tableview视图
    [self createLowView];
}

-(void)createLowView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, LFScreenW, LFScreenH-_MidBackGroud.maxY) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = LFScreenH/14;
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"graycolor"]];
    
    
    _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = [self headview];
    
    _tableView.tableFooterView = [self footview];
    [_MineView addSubview:_tableView];
    
    _arrTable = [NSMutableArray arrayWithCapacity:0];
    NSArray *arr = @[@"Setting",@"Favorites",@"History",@"Download"];
    for (int i =0;i<arr.count;i++){
        
        
        MineModel *model = [[MineModel alloc ]init];
        
        model.str = arr[i];
        [_arrTable addObject:model];
    }
    
    
    //制作上部分用户界面
    _userBack = [[UIImageView alloc]init];
    [_userBack setfram:CGRectMake(0, 0, LFScreenW, LFScreenH/4) image:MineBackView useinterface:YES];
    _userBack.backgroundColor = [UIColor blueColor];
    [_MineView addSubview:_userBack];
    
    //用户头像
    UIImageView *icon = [[UIImageView alloc]init];
    [icon setfram:CGRectMake(LFScreenW/2-45, 20, 90, 90) image:@"mine_user" useinterface:YES];
    icon.layer.cornerRadius = 45;
    icon.clipsToBounds = YES;
    icon.backgroundColor = [UIColor clearColor];
    [_userBack addSubview:icon];

    
    //登录/注销
    UIButton *signbt = [[UIButton alloc]initWithFrame:CGRectMake(LFScreenW/2-135/2, icon.maxY+15, 80, 20)];
    [signbt setTitle:@"sign in／" forState:UIControlStateNormal];
    [_userBack addSubview:signbt];
    
    //注销
    UIButton *registbt = [[UIButton alloc]initWithFrame:CGRectMake(signbt.maxX-25, signbt.y, 100, 20)];
    [registbt setTitle:@"register" forState:UIControlStateNormal];
    [_userBack addSubview:registbt];
    
    
}

-(UIView *)headview{
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW,LFScreenH/4)];
    
    return head;

}

-(UIView *)footview{
    UIView *foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, LFScreenH/14+5)];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, 5)];
    line.backgroundColor = UIgracolor;
    line.alpha = 0.1;
    [foot addSubview:line];
    foot.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab = [[UILabel alloc]init];
    [lab setfram:CGRectMake(60, 20, 100, 20) text:@"About us" color:UIgracolor font:15];
    [foot addSubview:lab];
    
    return foot;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrTable.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell) {
        cell = [[MineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        
        UILabel *lab = [[UILabel alloc]init];
        
        [lab setfram:CGRectMake(60, 15, 100, 20) text:[_arrTable[indexPath.row] str] color:UIgracolor font:15];
        [cell.contentView addSubview:lab];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        //图片
        CSAnimationView *animationView = [[CSAnimationView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
        
        animationView.backgroundColor = [UIColor whiteColor];
        
        animationView.duration = 0.5;
        animationView.delay    = 0;
        animationView.type     =CSAnimationTypePopDown;
        
        [cell.contentView addSubview:animationView];
        
        // Add your subviews into animationView
        // [animationView addSubview:<#(UIView *)#>]
        
        // Kick start the animation immediately
        [animationView startCanvasAnimation];
        
        UIImageView *pic = [[UIImageView alloc]init];
        [pic setfram:CGRectMake(0, 0, 30, 30) image:[_arrTable[indexPath.row] str] useinterface:NO];
        [animationView addSubview:pic];
//        cell.backgroundColor = [UIColor whiteColor];
//        cell.contentView.backgroundColor = [UIColor whiteColor];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    _isMine = YES;
    //setting
    if (indexPath.row==0) {
        _setVc = [[SetVc alloc]init];
        
    
        [self.navigationController pushViewController:_setVc animated:YES];
        
    }
    //myfavorite
    else if (indexPath.row==1){
        _MyfavoVc = [[MyFavoriteVc alloc]init];
        
        [self.navigationController pushViewController:_MyfavoVc animated:YES];
    }
    
    //history
    else if (indexPath.row==2){
        _historyVc = [[HistoryVc alloc]init];
        
        [self.navigationController pushViewController:_historyVc animated:YES];
    }
    
    //download
    else if (indexPath.row==3){
        _downLoadVc = [[DownloadVc alloc]init];
        
        [self.navigationController pushViewController:_downLoadVc animated:YES];
    
    }
}

#pragma mark leftIMG-------------------------------------------------------------------
-(void)createLeftImg{
    NSArray *arr = @[@"home_animation(1)",@"home_0010_panorama"];
    for (int i =0; i<arr.count; i++) {
        UIImageView *vie = [[UIImageView alloc]initWithFrame:CGRectMake(low*(i+1)+(LFScreenW/4+5)*i, _MidBackGroud.maxY+10, LFScreenW/4, 30)];
        vie.image = [UIImage imageNamed:arr[i]];
        vie.userInteractionEnabled = YES;
        //vie.backgroundColor = [UIColor grayColor];
        
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapG:)];
        vie.tag = 200+i;
        [vie addGestureRecognizer:tapG];
        
        [self.view addSubview:vie];
    }

}

#pragma mark 滑动视图------------------------------------------------------------------------
-(void)createscroview{
    _topScro = [[UIScrollView alloc]initWithFrame:CGRectMake(low, _MidBackGroud.maxY+50, LFScreenW-2*low, LFScreenH/4)];
    
    _topScro.contentSize = CGSizeMake(4*LFScreenW-2*low*4, 0);
    
    _topScro.pagingEnabled = YES;
    
    //_scrollView.userInteractionEnabled = YES;
    
    //_topScro.contentOffset = CGPointMake(0, 0);
    
    _topScro.alwaysBounceHorizontal = NO;
    
    _topScro.alwaysBounceVertical = NO;
    
    _topScro.showsVerticalScrollIndicator = NO;
    
    _topScro.showsHorizontalScrollIndicator = NO;
    
    _topScro.delegate = self;
    _topScro.backgroundColor = GrayColor;
    [self.view addSubview:_topScro];
    
    for (int i = 0; i<4; i++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i*(LFScreenW-2*low), 0, LFScreenW-2*low, LFScreenH/4)];
        img.userInteractionEnabled = YES;
        img.image = [UIImage imageNamed: @"banner"];
        img.backgroundColor = [UIColor greenColor];
        img.tag=50+i;
        [_topScro addSubview:img];
        
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapG:)];
        
        [img addGestureRecognizer:tapG];

    }
    
    //创建pageControl
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    
    pageControl.center = CGPointMake(LFScreenW/2, _topScro.maxY-10);
    
    pageControl.numberOfPages = 4;
    
    pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    _pageControl = pageControl;
    [self.view addSubview:_pageControl];
    
    if (_XBtimer==nil) {
        
    
    _XBtimer = [NSTimer timerWithTimeInterval: 2.0f target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_XBtimer forMode:NSRunLoopCommonModes];
    }
    
    

}
#pragma mark 点击滑动图片进入loadanimation
-(void)tapG:(UITapGestureRecognizer *)tap{
    NSLog(@"---------%li",tap.view.tag);
    if (tap.view.tag==200) {
        _animaC = [[AnimationViewController alloc]init];
        [self.navigationController pushViewController:_animaC animated:YES];
    }
    else {
       
       
        _LoadAnitVc = [[LoadAnimationVc alloc]init];
        
        
        [self.navigationController pushViewController:_LoadAnitVc animated:YES];
    }

}

#pragma mark 已经滑动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = _topScro.contentOffset.x/(LFScreenW-2*low);
    //NSLog(@"%@11111111",NSStringFromCGPoint(_scrollView.contentOffset));
    
    if(index >=5){
        index = 1;
        
        _pageControl.currentPage = index;
    }else
        
        
        _pageControl.currentPage = index;
    
    
    //
    if (_tableView.contentOffset.y<0) {
        _userBack.frame = CGRectMake(0, 0, LFScreenW, LFScreenH/4-_tableView.contentOffset.y);
    }
    else if (_tableView.contentOffset.y>0||_tableView.contentOffset.y==0){
        _tableView.contentOffset = CGPointMake(0, 0);
        NSLog(@"==========%f===",_tableView.contentOffset.y);
    
    }
}

//关闭定时器
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_XBtimer invalidate];
    _XBtimer = nil;

}


#pragma mark 结束拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _XBtimer = [NSTimer timerWithTimeInterval: 2.0f target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_XBtimer forMode:NSRunLoopCommonModes];
   
}
#pragma mark 定时器
-(void)scroll{
    
    if(_topScro.contentOffset.x==3*(LFScreenW-2*low)){
        
        _topScro.contentOffset = CGPointMake(0, 0);
        
        _topScro.contentOffset =CGPointMake(_topScro.contentOffset.x,0);
        
    }else
        
        _topScro.contentOffset =CGPointMake(_topScro.contentOffset.x+LFScreenW-2*low,0);

}

#pragma mark创建标题党--------------------------------------------------------------------------------------------------
-(void)createTitle{
    _load = [[UIImageView alloc]initWithFrame:CGRectMake(low, _topScro.maxY+10, 30, 25)];
    _load.image = [UIImage imageNamed:@"home_whats new(1)"];
    [self.view addSubview:_load];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_load.maxX+5, _topScro.maxY+10, 100, 25)];
    lab.text = @"What's New";
    [self.view addSubview:lab];
}

#pragma mark 创建tableview--------------------------------------------------－－－－－－－－－－－－－－－－－－－－－－－－

-(void)sendWork{
    
   // NSString *str = @"http://52.18.202.69:8080/tetrisvr/service/vritem/favorite";
   // NSString *str = @"http://192.168.2.128:8080/tetrisvr/service/vritem/favorite";
    _arr = [NSMutableArray arrayWithCapacity:0];

    //[self createTableView];
    [NetWork sendGetNetWorkWithUrl:favoriteUrl parameters:nil hudView:_bacccview successBlock:^(id data) {
        NSDictionary *dict;
        
        for (dict in data) {
            VRModel *model = [[VRModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dict];
            [model setValue:dict[@"id"] forKey:@"itemid"];
            [_arr addObject:model];
        }

        
        
        [self createTableView];
        
    } failureBlock:^(NSString *error) {
        
    }];
}

-(void)createTableView{
    _latyout = [[UICollectionViewFlowLayout alloc]init];
    
    
//    for (int i ; i<20; i++) {
//        [_arr addObject:[NSNumber numberWithInt:i]];
//    }
    
    _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _MidBackGroud.maxY+50, LFScreenW, LFScreenH-_MidBackGroud.maxY-50) collectionViewLayout:_latyout];
    
    
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    
    _collectionview.showsHorizontalScrollIndicator = NO;
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.shouldGroupAccessibilityChildren = YES;
    //注册
    [_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"IDD"];
    
    
    
    [_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    
    _collectionview.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:0];
    
    [self.view addSubview:_collectionview];
    
    
    [self blackHeimu];
    [self createMenu];
    

    
}
//头部视图高度
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(LFScreenW,LFScreenH/4+45);
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return _arr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IDD" forIndexPath:indexPath];
    
    if(_arr.count!=0){
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
  
    
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW/2-10,LFScreenH/5-30)];
    
    //img.image = [UIImage imageNamed:@"project-small"];
   [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:ThumbnailImg,[_arr[indexPath.row]filename]]]];
    
    [cell.contentView addSubview:img];
    
    UIView *whiteback = [[UIView alloc]initWithFrame:CGRectMake(0, img.maxY, LFScreenW/2-10, 30)];
    whiteback.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:whiteback];
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, img.maxY, (LFScreenW/2-10)*3/5, 30)];
    lab.text = [_arr[indexPath.row] displayName];
    [cell.contentView addSubview:lab];
    lab.font = [UIFont systemFontOfSize:12];
    
    
    UIImageView *love = [[UIImageView alloc]initWithFrame:CGRectMake(LFScreenW/2-10-35, 10, 10, 10)];
    love.image = [UIImage imageNamed:FavoritesImg];
    [whiteback addSubview:love];
    //collect
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(love.maxX, 10, 20, 10)];
    lab2.text = [NSString stringWithFormat:@"%@",[_arr[indexPath.row]favorite]];
    lab2.textColor = [UIColor grayColor];
    lab2.textAlignment = NSTextAlignmentCenter;
    [whiteback addSubview:lab2];
    lab2.font = [UIFont systemFontOfSize:10];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return CGSizeMake(LFScreenW/2-10,LFScreenH/5);
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5,5,5);
}

//点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    _LoadAnitVc = [[LoadAnimationVc alloc]init];
    _LoadAnitVc.filename = [_arr[indexPath.row]filename];
    _LoadAnitVc.displayName =[_arr[indexPath.row]displayName];
    _LoadAnitVc.download = [NSString stringWithFormat:@"%@",[_arr[indexPath.row]download]];
    _LoadAnitVc.favorite =[NSString stringWithFormat:@"%@",[_arr[indexPath.row]favorite ]];
    VRModel *model = [[VRModel alloc]init];
    model =_arr[indexPath.row];
    _LoadAnitVc.type = [NSString stringWithFormat:@"%@",model.type];
    _LoadAnitVc.itemid = model.itemid;
    _LoadAnitVc.created = model.created;
    [self.navigationController pushViewController:_LoadAnitVc animated:YES];

    
}


-(UICollectionReusableView*)collectionView:(UICollectionView*)collectionView viewForSupplementaryElementOfKind:(NSString*)kind atIndexPath:(NSIndexPath*)indexPath{
    
    //创建UICollectionReusableView视图
    
    if (!_header) {
        
        
        
        if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            
            
            _header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
            //添加头视图内容
        }
        [self createView];
        
        
        _header.backgroundColor = GrayColor;
    }
    
    
    return _header;
}

#pragma mark  头部视图创建－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
-(void)createView{
    CGFloat headH = _header.height-45;
    _topScro = [[UIScrollView alloc]initWithFrame:CGRectMake(low, 0, LFScreenW-2*low, LFScreenH/4)];
    
    _topScro.contentSize = CGSizeMake(4*LFScreenW-2*low*4, 0);
    
    _topScro.pagingEnabled = YES;
    
    //_scrollView.userInteractionEnabled = YES;
    
    //_topScro.contentOffset = CGPointMake(0, 0);
    
    _topScro.alwaysBounceHorizontal = NO;
    
    _topScro.alwaysBounceVertical = NO;
    
    _topScro.showsVerticalScrollIndicator = NO;
    
    _topScro.showsHorizontalScrollIndicator = NO;
    
    _topScro.delegate = self;
    _topScro.backgroundColor = GrayColor;
    [_header addSubview:_topScro];
    
    for (int i = 0; i<4; i++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i*(LFScreenW-2*low), 0, LFScreenW-2*low, LFScreenH/4)];
        img.userInteractionEnabled = YES;
        img.image = [UIImage imageNamed: @"banner"];
        img.backgroundColor = [UIColor greenColor];
        img.tag=50+i;
        [_topScro addSubview:img];
        
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapG:)];
        
        [img addGestureRecognizer:tapG];
        
    }
    
    //创建pageControl
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    
    pageControl.center = CGPointMake(LFScreenW/2, _topScro.maxY-10);
    
    pageControl.numberOfPages = 4;
    
    pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    _pageControl = pageControl;
    [_header addSubview:_pageControl];
    
    if (_XBtimer==nil) {
        
        
        _XBtimer = [NSTimer timerWithTimeInterval: 2.0f target:self selector:@selector(scroll) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_XBtimer forMode:NSRunLoopCommonModes];
    }
    

    _load = [[UIImageView alloc]initWithFrame:CGRectMake(low, _topScro.maxY+10, 30, 25)];
    _load.image = [UIImage imageNamed:@"home_whats new(1)"];
    [_header addSubview:_load];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_load.maxX+5, _topScro.maxY+10, 100, 25)];
    lab.text = @"What's New";
    [_header addSubview:lab];

    
    
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
    
    [_search setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    
    [_search addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [_TopBackGroud addSubview:_search];
    
    
    
    
    
    
    
}


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


//搜索
-(void)search{
    _searVc = [[SearchViewController alloc]init];
    
    [self presentViewController:_searVc animated:YES completion:nil];

}







@end
