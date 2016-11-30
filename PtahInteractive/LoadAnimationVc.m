

#define OrigImg @"http://52.18.202.69:8080/files/tetrisvr/%@.jpg"



#import "LoadAnimationVc.h"
#import "BaoScroView.h"

#import "Masonry.h"

#import "AFNetworking.h"
#import <AFNetworking/AFNetworking.h>
#import "BitmapPlayerViewController.h"
#import "AppDelegate.h"

#import "enrolVc.h"


#import "Video360ViewController.h"
#import "GVRVideoView.h"
#import "gvrVc.h"
#import "NetWork.h"
#import "PlayVideoViewController.h"

#import "Collect.h"
#import "TeriManerger.h"
#import "History.h"

#import "WWDownloadManager.h"
#import "WWSessionModel.h"

#import "SZKNetWorkUtils.h"


#import "GooglePanaromaVc.h"

@interface LoadAnimationVc ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,GVRWidgetViewDelegate>
{
    //1
    UIView *_TopBackGroud;
    UIButton *_search;
    UIButton *_menu;
    
    //5
    UIImageView *_load;
    
    UIButton *_collect;
    
    
    UICollectionView *_collectionview;
    
    UICollectionReusableView* _header;
    
    UIPageControl *_pageControl;
    
}

@property (nonatomic,strong) BaoScroView *scroView;

@property(nonatomic,strong)AppDelegate *appDele;


@property(nonatomic,strong)NSManagedObjectContext *context;
@end

@implementation LoadAnimationVc
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self createui];
    
    [self createHistory];
}

-(void)createHistory{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    NSArray *arr = [NSArray array];
    arr = [_context executeFetchRequest:request error:nil];
    if(arr.count==0){
        if(!(self.displayName==nil)){

        //添加进入数据库
        History *history = [NSEntityDescription insertNewObjectForEntityForName:@"History" inManagedObjectContext:_context];
               history.displayName = self.displayName;
        history.favorite = self.favorite;
        history.type = self.type;
        history.fileName = self.filename;
        
        NSError *error = nil;
        
        BOOL isok = [_context save:&error];
        
        if (isok) {
            NSLog(@"添加浏览成功");
        }else
            NSLog(@"添加浏览失败");
        }

    }
    else{
        int i =0;
    for (History *collect in arr) {
        if ([collect.displayName isEqualToString:self.displayName]) {
            i++;
            break;
        }
        else{
           ;
        }
    }
        if (i==0) {
                  if(!(self.displayName==nil)){
            //添加进入数据库
            History *history = [NSEntityDescription insertNewObjectForEntityForName:@"History" inManagedObjectContext:_context];
            
            history.displayName = self.displayName;
            history.favorite = self.favorite;
            history.type = self.type;
            history.fileName = self.filename;
            
            NSError *error = nil;
            
            BOOL isok = [_context save:&error];
            
            if (isok) {
                NSLog(@"添加浏览成功");
            }else
                NSLog(@"添加浏览失败");
            

        }
        }
    
    }
    
}

-(void)useCoredata{
    TeriManerger *manager = [TeriManerger shareManager];
    
    _context = manager.context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
     self.automaticallyAdjustsScrollViewInsets = NO;
    [self useCoredata];
    //appdele
//    [self createappDele];
//    
//    [self createTopView];
    
   
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
//
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
//
//


#pragma mark collectionview------------------------------------------------------
-(void)createui{
    UICollectionViewFlowLayout *latyout = [[UICollectionViewFlowLayout alloc]init];
    
    _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, TopH, LFScreenW, LFScreenH-TopH) collectionViewLayout:latyout];
    
    
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
    
    return CGSizeMake(LFScreenW,LFScreenH*3/8+45);
    
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
    
    
        UIImageView *love = [[UIImageView alloc]initWithFrame:CGRectMake(LFScreenW/2-10-35, 10, 10, 10)];
        love.image = [UIImage imageNamed:FavoritesImg];
        [whiteback addSubview:love];
    
        UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(love.maxX, 10, 20, 10)];
        lab2.text = @"251";
        lab2.textColor = [UIColor grayColor];
        [whiteback addSubview:lab2];
        lab2.font = [UIFont systemFontOfSize:10];
    
    
    
    
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
    
    _header.backgroundColor = [UIColor whiteColor];
    }
    
    
    return _header;
}

#pragma mark  头部视图创建－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
-(void)createView{
    CGFloat headH = _header.height-45;
    //
  
    UIImageView *VRvie = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, headH*3/5)];
    
    //VRvie.image = [UIImage imageNamed:@"dome_pic.jpg"];
    [VRvie sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:OrigImg,self.filename]]];
    VRvie.userInteractionEnabled = YES;
    [_header addSubview:VRvie];
    
    //播放按钮
    CGFloat playW = 65;
    UIButton *playBt = [[UIButton alloc]initWithFrame:CGRectMake(LFScreenW/2-playW/2, VRvie.height/2-playW/2, playW, playW)];
    [playBt setImage:[UIImage imageNamed:@"project_play"] forState:UIControlStateNormal];
    playBt.tag=300;
    [playBt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [VRvie addSubview:playBt];
    
    //名称
    UILabel *displayName = [[UILabel alloc]init];
    [displayName setfram:CGRectMake(10, VRvie.maxY+3, LFScreenW*4/9, 30) text:self.displayName color:[UIColor grayColor] font:14];
    [_header addSubview:displayName];
    
    //收藏的图片
    UIImageView *favoriteImg = [[UIImageView alloc]init];
    
    [favoriteImg setfram:CGRectMake(LFScreenW*17/24, VRvie.maxY+10, 15, 15) image:FavoritesImg useinterface:YES];
    [_header addSubview:favoriteImg];
    
    //收藏次数
    UILabel *favorite = [[UILabel alloc]init];
    [favorite setfram:CGRectMake(favoriteImg.maxX+5, favoriteImg.y-2, 30, 20) text:self.favorite color:UIgracolor font:14];
    
    [_header addSubview:favorite];
    
    //分辨率图
    UIImageView *modes = [[UIImageView alloc]init];
    [modes setfram:CGRectMake(favorite.maxX, favoriteImg.y, 40, 15) image:cqdy useinterface:NO];
    [_header addSubview:modes];
    
    //
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, displayName.maxY, LFScreenW, 5)];
    line.backgroundColor = UIgracolor;
    line.alpha = 0.1 ;
    [_header addSubview:line];
    
    //
    NSArray *arr1 = @[@"Time",@"Length",@"Type"];
    NSArray *arr2 = @[@"01/01/2016",@"1min",@"Animation"];
    
    NSArray *array3 = [self.created componentsSeparatedByString:@"-"];
    
    for (int i = 0; i<3; i++) {
        //
        UILabel *lab = [[UILabel alloc]init];
        [lab setfram:CGRectMake(10, line.maxY+5+i*(20+2), 40, 20) text:arr1[i] color:UIgracolor font:12];
        //冒号
        UILabel *lab2 = [[UILabel alloc]init];
        [lab2 setfram:CGRectMake(lab.maxX+5, lab.y, 5, 20) text:@":" color:UIgracolor font:11];
        [_header addSubview:lab2];
        [_header addSubview:lab];
        //
        
        UILabel *lab3 = [[UILabel alloc]init];
        [lab3 setfram:CGRectMake(lab2.maxX, lab.y, 100, 20) text:arr2[i] color:UIgracolor font:12];
        [_header addSubview:lab3];
        if (i==2) {
            if ([self.type isEqualToString:@"0"]) {
                lab3.text = @"Panorama";
                
            }
        }else if (i==0){
            lab3.text = [NSString stringWithFormat:@"%@/%@/%@",array3[2],array3[1],array3[0]];
        }
        
        
    }
    
    //右侧收藏按钮
    _collect = [[UIButton alloc]initWithFrame:CGRectMake(favorite.x, (headH-line.maxY)/2-22/2+5+line.maxY, 25, 22)];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Collect"];
    NSArray *arr = [NSArray array];
    arr = [_context executeFetchRequest:request error:nil];
    
    for (Collect *collect in arr) {
        if ([collect.displayName isEqualToString:self.displayName]) {
            _collect.selected = YES;
            break;
        }
        else{
            _collect.selected = NO;
        
        }
    }

    
    [_collect setImage:[UIImage imageNamed:@"project_like-1"] forState:UIControlStateNormal];
    _collect.tag=100;
    [_collect setImage:[UIImage imageNamed:@"project_like-2"] forState:UIControlStateSelected];
    [_collect addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [_header addSubview:_collect];
    
    //下载
    UIButton *load = [[UIButton alloc]initWithFrame:CGRectMake(_collect.maxX+10, (headH-line.maxY)/2-35/2+line.maxY+2, 35, 35)];
    [load setImage:[UIImage imageNamed:@"project_download"] forState:UIControlStateNormal];
    [load addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [_header addSubview:load];
    load.tag=101;
    
    //
    UILabel *lab4 = [[UILabel alloc]init];
    [lab4 setfram:CGRectMake(load.x, load.maxY, 50, 20) text:@"48.336M" color:UIgracolor font:9];
    [_header addSubview:lab4];
    
    
    
    _load = [[UIImageView alloc]initWithFrame:CGRectMake(low, headH+17, 25, 15)];
    _load.image = [UIImage imageNamed:@"project_0006_形状-3"];
    
    [_header addSubview:_load];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_load.maxX+5, headH+10, 200, 25)];
    lab.text = @"Maybe you will like";
    [_header addSubview:lab];
    
    
    
}
#pragma mark  loading-------------------------------------------------------------------------------------------------
-(void)click:(UIButton *)btn{
    //收藏
    if (btn.tag==100) {
        if (btn.selected==NO) {
            btn.selected=YES;
            //添加进入数据库
            Collect *collect = [NSEntityDescription insertNewObjectForEntityForName:@"Collect" inManagedObjectContext:_context];
            
            collect.displayName = self.displayName;
            collect.favorite = self.favorite;
            collect.type = self.type;
            collect.fileName = self.filename;
            
            NSError *error = nil;
            
            BOOL isok = [_context save:&error];
            
            if (isok) {
                NSLog(@"收藏成功");
            }else
                NSLog(@"收藏失败");
        }
        else{
            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Collect"];
            NSArray *arr = [NSArray array];
            arr = [_context executeFetchRequest:request error:nil];
            for (Collect *colle in arr) {
                if ([colle.displayName isEqualToString:self.displayName]) {
                    [_context deleteObject:colle];
                }
            }
            BOOL isok = [_context save:nil];
            if (isok) {
                NSLog(@"*****删除成功******");
            }
            
            
        btn.selected=NO;
        }
        
//        NSString *url = @"http://52.18.202.69:8080/tetrisvr/service/user/login.do";
//        NSDictionary *dict =@{
//            @"email":@"11",
//            @"password":@"111"};
//        [NetWork PostNetWorkWithUrl:url parameters:dict hudView:self.view successBlock:^(id data) {
//            
//            
//            NSLog(@"88888888888888888888888");
//        } failureBlock:^(NSString *error) {
//            
//        }];
        
    }
    //下载
    else if (btn.tag==101){
//        if (self.appDele.isLogin==NO) {
//            enrolVc *enroVc = [[enrolVc alloc]init];
//            
//            [self presentViewController:enroVc animated:YES completion:nil];
//        }
      //  else{
            
        //NSString *resourceUrl = self.dataSource[indexPath.row][@"ResourceUrl"];
      //  NSString *resourceUrl = @"http://ps3.tgbus.com/UploadFiles/201305/20130516105149437.jpg";
        NSString *resourceUrl = [NSString stringWithFormat:ThumbnailImg,self.filename];
        
        if (![[WWDownloadManager sharedInstance] isExistDownloadList:resourceUrl]) {
            //上传下载量
            NSString *url = [NSString stringWithFormat:@"http://52.18.202.69:8080/tetrisvr/service/vritem/%@/download",self.itemid];
            [NetWork PutNetWorkWithUrl:url parameters:nil hudView:self.view successBlock:^(id data) {
                NSLog(@"####上传成功####");
            } failureBlock:^(NSString *error) {
                NSLog(@"####上传失败 error:%@####",error);

            }];

            
            
            
//            UIImage *image = WeakCell.logoIV.image;
            //NSString *title = self.dataSource[indexPath.row][@"Title"];
            NSDictionary *dic = @{@"type":self.type,
                                  @"ResourceUrl":resourceUrl,
                                  @"displayName":self.displayName,
                                  @"filePath":resourceUrl
                                  };

           // NSDictionary *dic = [NSDictionary dictionary];
            
            [[WWDownloadManager sharedInstance] download:dic progress:^(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize) {
                
            } state:^(DownloadState state) {
                NSLog(@"state======%li",state);
            }];
            
        }else{
            NSLog(@"资源已在下载列表");
            [SVProgressHUD showSuccessWithStatus:@"Resources are download"];
        }
        
        }
        
 //   }
    //播放
    else if (btn.tag==300)
    {

        
        GooglePanaromaVc *ponaro = [[GooglePanaromaVc alloc]init];
        
        // [self.navigationController pushViewController:ponaro animated:YES];
        ponaro.filename = [NSString stringWithFormat:ThumbnailImg,self.filename];
        ponaro.type=0;
        [self presentViewController:ponaro animated:YES completion:nil];
        
        //上传在线播放量
        NSString *url = [NSString stringWithFormat:@"http://52.18.202.69:8080/tetrisvr/service/vritem/%@/viewed",self.itemid];
        [NetWork PutNetWorkWithUrl:url parameters:nil hudView:self.view successBlock:^(id data) {
            
            NSLog(@"####上传成功####");

            
        } failureBlock:^(NSString *error) {
                           NSLog(@"####上传失败 error:%@####",error);
        }];
       
        
//            NSString *path = [[NSBundle mainBundle] pathForResource:@"dome_pic" ofType:@"jpg"];
//            [self launchAsImage:[NSURL fileURLWithPath:path]];
        
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"VR"message:@"Please choose the style"preferredStyle:UIAlertControllerStyleAlert];
        
     
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"internet pictures"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self launchAsImage:[NSURL URLWithString:@"http://www.apoints.com/graphics/UploadFiles/200803/20080301202754140.jpg"]];
            
            
            
        } ];

        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"cardboard iOS 360 VR" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
                    NSString *path = [[NSBundle mainBundle] pathForResource:@"demo1.mp4" ofType:nil];
                                     NSLog(@"=======%@=======,",path);
                    NSURL *url = [NSURL fileURLWithPath:path];
            
                    Video360ViewController *videoController = [[Video360ViewController alloc] initWithNibName:@"HTY360PlayerVC" bundle:nil url:url];
            
                    if (![[self presentedViewController] isBeingDismissed]) {
                        [self presentViewController:videoController animated:YES completion:nil];
                    }
        } ];
        
        
        UIAlertAction *okAction2 = [UIAlertAction actionWithTitle:@"pano1.jpg" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//             [self launchAsImage:[NSURL URLWithString:@"http://52.18.202.69:8080/files/tetrisvr/pano1.jpg"]];
            
//            NSString *path = [[NSBundle mainBundle] pathForResource:@"pano1.jpg" ofType:nil];
            //
            // NSString *path = model.filePath;
         //[self launchAsImage:[NSURL fileURLWithPath:path]];
            
            GooglePanaromaVc *ponaro = [[GooglePanaromaVc alloc]init];
            
           // [self.navigationController pushViewController:ponaro animated:YES];
            ponaro.filename = [NSString stringWithFormat:ThumbnailImg,self.filename];
            ponaro.type=0;
            [self presentViewController:ponaro animated:YES completion:nil];
            
           
            
                    } ];
        
        UIAlertAction *okAction3 = [UIAlertAction actionWithTitle:@"GVR video" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            PlayVideoViewController *vrvc = [[PlayVideoViewController alloc]init];
//
            
            gvrVc *vrvc = [[gvrVc alloc]init];
            
            //[self.navigationController pushViewController:vrvc animated:YES];
            [self presentViewController:vrvc animated:YES completion:nil];
            
            
        } ];

        
       // [alertController addAction:cancelAction];
        
       // [alertController addAction:okAction];
        
       // [alertController addAction:okAction2];
        
        // [alertController addAction:okAction3];

        
       // [self presentViewController:alertController animated:YES completion:nil];
        
        
        }

        

        
        

     

        
    }
        
                                   
        



- (void)launchAsImage:(NSURL*)url {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BitmapPlayer" bundle:nil];
    PlayerViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"BitmapPlayerViewController"];
    
    [self presentViewController:vc animated:NO completion:^{
        [vc initParams:url];
    }];
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
