//
//  HotVRViewController.m
//  PtahInteractive
//
//  Created by ptah on 16/8/4.
//  Copyright © 2016年 Ptah. All rights reserved.
//




#import "HotVRViewController.h"
#import "BaoScroView.h"

@interface HotVRViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
   
    
    //5
    UIImageView                   *_load;
    
    
    UICollectionView              *_collectionview;
    
    UICollectionReusableView      * _header;
    
    UIPageControl                 *_pageControl;
    
    NSTimer                       *_XBtimer;

}

@property (nonatomic,strong) BaoScroView *scroView;


@end

@implementation HotVRViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = GrayColor;
    
    [self crteaTitle];
    
    [self createui];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}
-(void)crteaTitle{
    
    //创建标题。。。。
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(LFScreenW/2-(LFScreenW*2/5/2),TopH-35 , LFScreenW*2/5, pich)];
    lab.text = self.title;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    [self.view addSubview:lab];

}

#pragma mark collectionview------------------------------------------------------
-(void)createui{
    UICollectionViewFlowLayout *latyout = [[UICollectionViewFlowLayout alloc]init];
    
    _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0,TopH, LFScreenW, LFScreenH-TopH
                                                                        ) collectionViewLayout:latyout];
    
    
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    
    _collectionview.showsHorizontalScrollIndicator = NO;
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.shouldGroupAccessibilityChildren = YES;
    //注册
    [_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ID"];
    
//    [_collectionview  registerClass:[UICollectionReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeaderwithReuseIdentifier:@"header"];
//    
//    
//    [_collectionview reg]
    [_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];

    
    _collectionview.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_collectionview];

    
    [self createTopView];
    self.IndextTtile.text = @"Hot VR";
    //创建右上角菜单栏
    [self blackHeimu];
    [self createMenu];

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return 20;
}




- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(LFScreenW,LFScreenH*5/8+45);
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    
    //
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    //}
    
    cell.backgroundColor = [UIColor redColor];
    cell.contentView.backgroundColor = [UIColor redColor];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW/2-10,LFScreenH/5-30)];
    
    img.image = [UIImage imageNamed:@"project-small"];
    
    [cell.contentView addSubview:img];
    
    UIView *whiteback = [[UIView alloc]initWithFrame:CGRectMake(0, img.maxY, LFScreenW/2-10, 30)];
    whiteback.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:whiteback];
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, img.maxY, (LFScreenW/2-10)*3/5, 30)];
    lab.text = @"Pool House Refurb";
    [cell.contentView addSubview:lab];
    lab.font = [UIFont systemFontOfSize:12];
    
    
//    UIImageView *love = [[UIImageView alloc]initWithFrame:CGRectMake(LFScreenW/2-10-35, 10, 10, 10)];
//    love.image = [UIImage imageNamed:@"love"];
//    [whiteback addSubview:love];
//    
//    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(love.maxX, 10, 20, 10)];
//    lab2.text = @"251";
//    lab2.textColor = [UIColor grayColor];
//    [whiteback addSubview:lab2];
//    lab2.font = [UIFont systemFontOfSize:10];
    

    
    
    return cell;
    
}

#pragma MARK 设置collectionview的大小以及每一个cell的间距
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CGSizeMake(LFScreenW/2-10,LFScreenH/5);
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5,5,5);
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

    self.scroView = [[BaoScroView alloc]init];
    [self.scroView setfram:CGRectMake(0, 0, LFScreenW, headH/3) color:[UIColor whiteColor] contentSize:CGSizeMake(4*LFScreenW, 0) pagingEnabled:YES other:NO];
    self.scroView.delegate = self;
    
    [_header addSubview:self.scroView];
    
    for (int i = 0; i<4; i++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i*LFScreenW, 0, LFScreenW, self.scroView.height)];
        img.userInteractionEnabled = YES;
        img.tag=100+i;
        img.image = [UIImage imageNamed:@"hot_top"];
        //img.backgroundColor = [UIColor greenColor];
        [self.scroView addSubview:img];
        
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapG:)];
        
        [img addGestureRecognizer:tapG];
        
    }
    
    //创建pageControl
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    
    pageControl.center = CGPointMake(LFScreenW/2,_scroView.maxY-10 );
    
    pageControl.numberOfPages = 4;
    
    pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    _pageControl = pageControl;
    [_header addSubview:_pageControl];
    
    _XBtimer = [NSTimer timerWithTimeInterval: 2.0f target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_XBtimer forMode:NSRunLoopCommonModes];
    
    
    //创建第二,三层图片
    NSArray *arr = @[@"hot_02",@"hot_03"];
    for (int i = 0 ; i<arr.count; i++) {
        UIImageView *img = [[UIImageView alloc]init];
        img.frame = CGRectMake(0, (i+1)*headH/3, LFScreenW, headH/3);
        img.image = [UIImage imageNamed:arr[i]];
        
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapG:)];
        [_header addSubview:img];
        
    }
    
    _load = [[UIImageView alloc]initWithFrame:CGRectMake(low, headH+10, 30, 25)];
    _load.image = [UIImage imageNamed:@"home_whats new(1)"];

    [_header addSubview:_load];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_load.maxX+5, headH+10, 100, 25)];
    lab.text = @"What's New";
    [_header addSubview:lab];
    

    
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


#pragma mark 点击滑动图片进入
-(void)tapG:(UITapGestureRecognizer *)tap{
    
    
}

#pragma mark 已经滑动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = _scroView.contentOffset.x/(LFScreenW);
    //NSLog(@"%@11111111",NSStringFromCGPoint(_scrollView.contentOffset));
    
    if(index >=5){
        index = 1;
        
        _pageControl.currentPage = index;
    }else
        
        
        _pageControl.currentPage = index;
    
}
#pragma mark 定时器
-(void)scroll{
    
    if(_scroView.contentOffset.x==3*(LFScreenW)){
        
        _scroView.contentOffset = CGPointMake(0, 0);
        
        _scroView.contentOffset =CGPointMake(_scroView.contentOffset.x,0);
        
    }else
        
        _scroView.contentOffset =CGPointMake(_scroView.contentOffset.x+LFScreenW,0);
    
}

//#pragma mark 创建菜单栏－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
//
//-(void)createMenu{
//    self.menuBackView = [[UIImageView alloc]init];
//    
//    [self.menuBackView setfram:CGRectMake(_menu.maxX, _menu.maxY+5, 0, 0) image:@"other-menu_back" useinterface:YES];
//    
//    [self.view addSubview:self.menuBackView];
//    
//    //
//    NSArray *arr = @[@"Setting",@"Help",@"Contact us"];
//    
//   self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//    
//    [self.btn1 setTitle:@"Setting       " forState:UIControlStateNormal];
//    
//    [self.btn1 setTitleColor:UIgracolor forState:UIControlStateNormal];
//    
//    [self.menuBackView addSubview:self.btn1];
//    
//    
//    //
//    self.btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//    
//    [self.btn2 setTitle:@"Help           " forState:UIControlStateNormal];
//    
//    [self.btn2 setTitleColor:UIgracolor forState:UIControlStateNormal];
//    
//    [self.menuBackView addSubview:self.btn2];
//    
//    //
//    self.btn3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//    
//    [self.btn3 setTitle:@"Contact us" forState:UIControlStateNormal];
//    
//    [self.btn3 setTitleColor:UIgracolor forState:UIControlStateNormal];
//    
//    [self.menuBackView addSubview:self.btn3];
//    
//    
//    self.btn1.titleLabel.font = [UIFont systemFontOfSize:13];
//    self.btn2.titleLabel.font = [UIFont systemFontOfSize:13];
//    self.btn3.titleLabel.font = [UIFont systemFontOfSize:13];
//    
//    
//   self.btnLine1 = [[UIView alloc]initWithFrame:CGRectMake(0,0, 0, 0)];
//    self.btnLine1.backgroundColor = GrayColor;
//    [self.menuBackView addSubview:self.btnLine1];
//    
//    
//    self.btnLine2 = [[UIView alloc]initWithFrame:CGRectMake(0,0, 0, 0)];
//    self.btnLine2.backgroundColor = GrayColor;
//    [self.menuBackView addSubview:self.btnLine2];
//    
//    
//    self.btnLine3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//    self.btnLine3.backgroundColor = GrayColor;
//    [self.menuBackView addSubview:self.btnLine3];
//    
//    
//    
//    //判断是否登录
//    
//    
//    
//    
//    
//    if (self.appDele.isLogin==YES) {
//       self.SignoutImg = [[UIImageView alloc]init];
//        
//        [self.SignoutImg setfram:CGRectMake(0, 0, 0, 0) image:@"signout" useinterface:YES];
//        
//        [self.menuBackView addSubview:self.SignoutImg];
//        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SignOut:)];
//        
//        [self.SignoutImg addGestureRecognizer:tap];
//        self.SignoutImg.tag=700;
//    }
//    else  {
//        self.RegisterImg = [[UIImageView alloc]init];
//        
//        [self.RegisterImg setfram:CGRectMake(0, 0, 0, 0) image:@"register" useinterface:YES];
//        
//        [_menuBackView addSubview:_RegisterImg];
//        
//    }
//    
//    
//}
//
//-(void)SignOut:(UITapGestureRecognizer *)tap{
//    if (tap.view.tag==700) {
//        SignOutVc *signVc = [[SignOutVc alloc]init];
//        
//        [self presentViewController:signVc animated:YES completion:nil];
//        
//    }}
//-(void)menu:(id)sender{
//    
//    
//    
//    if (!_isOpen) {
//        _blackbt.frame = CGRectMake(0, 0, LFScreenW, LFScreenH);
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
//            
//            _SignoutImg.frame = CGRectMake(25, _btnLine3.maxY+15, 80, 25);
//            _RegisterImg.frame = CGRectMake(25, _btnLine3.maxY+10, 80, 30);
//            
//            
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
//            
//            _SignoutImg.frame = CGRectMake(0, 0, 0, 0);
//            _RegisterImg.frame = CGRectMake(0, 0, 0, 0);
//        }];
//        _isOpen = NO;
//    }
//    
//    
//}
//
//-(void)blackHeimu{
//    _blackbt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//    
//    [_blackbt setImage:[UIImage imageNamed:@"blackview"] forState:UIControlStateNormal];
//    _blackbt.clipsToBounds = YES;
//    
//    [_blackbt addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_blackbt];
//    
//}
//-(void)close{
//    _blackbt.frame = CGRectMake(0, 0, 0, 0);
//    
//    [UIView animateWithDuration:0.3f animations:^{
//        _menuBackView.frame = CGRectMake(_menu.maxX, _menu.maxY+5, 0, 0) ;
//        
//        _btn1.frame =CGRectMake(0, 0, 0, 0);
//        
//        _btn2.frame =CGRectMake(0, 0, 0, 0);
//        
//        _btn3.frame =CGRectMake(0, 0, 0, 0);
//        
//        _btnLine1.frame = CGRectMake(0,0, 0, 0);
//        _btnLine2.frame = CGRectMake(0,0, 0, 0);
//        
//        _btnLine3.frame = CGRectMake(0, 0, 0, 0);
//        
//        _RegisterImg.frame = CGRectMake(0, 0, 0, 0);
//        _SignoutImg.frame = CGRectMake(0, 0, 0, 0);
//    }];
//    _isOpen = NO;
//    
//}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
