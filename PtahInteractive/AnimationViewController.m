//
//  AnimationViewController.m
//  PtahInteractive
//
//  Created by ptah on 16/8/4.
//  Copyright © 2016年 Ptah. All rights reserved.
//




#import "AnimationViewController.h"
#import "BaoScroView.h"


@interface AnimationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    //1
    UIView                    *_TopBackGroud;
    UIButton                  *_search;
    UIButton                  *_menu;
    
    
    UICollectionView          *_collectionview;
    UICollectionReusableView  * _header;
    
    UIPageControl             *_pageControl;
    
    NSTimer                   *_XBtimer;

}
@property (nonatomic,strong) BaoScroView *scroView;
@end

@implementation AnimationViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
     //[self createTopView];
    
    [self createui];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma arc 创建顶层视图
//-(void)createTopView{
//    _TopBackGroud = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, LFScreenH*1/11)];
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
//    //创建标题。。。。
//    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(LFScreenW/2-(LFScreenW*2/5/2),_menu.y , LFScreenW*2/5, pich)];
//    lab.text = @"Animation";
//    lab.textAlignment = NSTextAlignmentCenter;
//    lab.textColor = [UIColor whiteColor];
//    [_TopBackGroud addSubview:lab];
//    
//    
//    //back
//    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(10, _menu.y, picw+5, pich+5)];
//    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
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

#pragma mark collectionview------------------------------------------------------
-(void)createui{
    UICollectionViewFlowLayout *latyout = [[UICollectionViewFlowLayout alloc]init];
    
    _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0,  TopH, LFScreenW, LFScreenH-TopH) collectionViewLayout:latyout];
    
    
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
    
    
    _collectionview.backgroundColor = GrayColor;
    
    [self.view addSubview:_collectionview];
    
    [self createTopView];
    self.IndextTtile.text = @"Animation";
    //创建右上角菜单栏
    [self blackHeimu];
    [self createMenu];
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return 20;
}




- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(LFScreenW,LFScreenH/3);
    
}
//cell－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    
    //
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    //}
    
    if (indexPath.item==0) {
        UIImageView *yellow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5,45, 15)];
        yellow.image = [UIImage imageNamed:@"project2_inertior tittle"];
        [cell.contentView addSubview:yellow];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(yellow.maxX+5, yellow.y-3, 200, 20)];
        lab.text = @"Interior";
        [cell.contentView addSubview:lab];
    }
    else if (indexPath.item==5){
        UIImageView *yellow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5,45, 15)];
        yellow.image = [UIImage imageNamed:@"project2_exterior tittle"];
        [cell.contentView addSubview:yellow];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(yellow.maxX+5, yellow.y-3, 200, 20)];
        lab.text = @"Exterior";
        [cell.contentView addSubview:lab];

    }
    else if (indexPath.item==10){
        UIImageView *yellow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5,45, 15)];
        yellow.image = [UIImage imageNamed:@"project2_branding tittle"];
        [cell.contentView addSubview:yellow];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(yellow.maxX+5, yellow.y-3, 200, 20)];
        lab.text = @"Branding";
        [cell.contentView addSubview:lab];
        
    }
    else {
    
    
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
    
    
        UIImageView *love = [[UIImageView alloc]initWithFrame:CGRectMake(LFScreenW/2-10-35, 10, 10, 10)];
        love.image = [UIImage imageNamed:FavoritesImg];
        [whiteback addSubview:love];
    
        UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(love.maxX, 10, 20, 10)];
        lab2.text = @"251";
        lab2.textColor = [UIColor grayColor];
        [whiteback addSubview:lab2];
        lab2.font = [UIFont systemFontOfSize:10];
    }
    
    
    
    
    return cell;
    
}

#pragma MARK 设置collectionview的大小以及每一个cell的间距
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item==0||indexPath.item==5||indexPath.item==10) {
        return CGSizeMake(LFScreenW-10, 20);
    }
    
    else
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
    CGFloat headH = _header.height;
    
    self.scroView = [[BaoScroView alloc]init];
    [self.scroView setfram:CGRectMake(0, 0, LFScreenW, headH*2/3) color:[UIColor whiteColor] contentSize:CGSizeMake(4*LFScreenW, 0) pagingEnabled:YES other:NO];
    self.scroView.delegate = self;
    
    [_header addSubview:self.scroView];
    
    for (int i = 0; i<4; i++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i*LFScreenW, 0, LFScreenW, self.scroView.height)];
        img.userInteractionEnabled = YES;
        img.tag=100+i;
        img.image = [UIImage imageNamed:@"animation_top"];
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
    
    
    //创建第二层图片
    NSArray *arr = @[@"hot_1",@"hot_2"];
    NSArray *arr2 = @[@"project2_inertiorcolor",@"project2_exteriorcolor",@"project2_brandingcolor"];
    NSArray *arr3 = @[@"Interior",@"Exterior",@"Branding"];
    for (int i = 0 ; i<arr2.count; i++) {
        UIImageView *img = [[UIImageView alloc]init];
        img.frame = CGRectMake(i*LFScreenW/3, _scroView.maxY, LFScreenW/3, headH-_scroView.height);
        img.image = [UIImage imageNamed:arr2[i]];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(LFScreenW/3/2-LFScreenW/3/2, img.height/2-img.height/5/2, LFScreenW/3, img.height/5)];
        lab.text = arr3[i];
        lab.textColor = [UIColor whiteColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:13];
        [img addSubview:lab];
        
        
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapG:)];
        [_header addSubview:img];
        
    }
    
//    _load = [[UIImageView alloc]initWithFrame:CGRectMake(low, headH+10, 25, 25)];
//    _load.backgroundColor = [UIColor redColor];
//    [_header addSubview:_load];
//    
//    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_load.maxX+5, headH+10, 100, 25)];
//    lab.text = @"What's New";
//    [_header addSubview:lab];
    
    
    
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





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
