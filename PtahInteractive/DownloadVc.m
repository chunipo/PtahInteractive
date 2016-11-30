//
//  DownloadVc.m
//  PtahInteractive
//
//  Created by ptah on 16/8/29.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "DownloadVc.h"

#import "DownloadCell.h"


#import "WWDownloadManager.h"
#import "WWSessionModel.h"
#import "PlayerViewController.h"
#import "GooglePanaromaVc.h"

@interface DownloadVc ()<UITableViewDelegate,UITableViewDataSource>
{
    //1
    UIView *_TopBackGroud;
    UIButton *_search;
    UIButton *_menu;
    
    NSIndexPath *_indexpath;
    //2
//    UITableView  *_tableView;
    NSMutableArray  *_arr;
    
}
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation DownloadVc


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = GrayColor;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, TopH, LFScreenW, LFScreenH-TopH)];
    view.backgroundColor =UIgracolor;
    view.alpha = 0.1;
    [self.view addSubview:view];
    
    //    [self createTopView];
    
    [self CleanHistory];
    [self initData];
    [self createUI];
    
}

- (void)initData
{
    self.dataSource = [NSMutableArray array];
    self.dataArr = [NSMutableArray array];
    dispatch_queue_t nimei = dispatch_queue_create("lalal", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(nimei, ^{
    
  

    NSMutableArray *arr = [NSMutableArray array];
    arr = [WWDownloadManager sharedInstance].sessionModelsArray;
    //创建一个保存不同时间的数组
    NSMutableArray *arr2 = [NSMutableArray array];
    [arr2 addObject:@"0"];
    
    
    for (int i =0; i<arr.count; i++) {
        WWSessionModel *model1 = arr[0];
        WWSessionModel *model2 = arr[i];
        if (i==0) {
            [self.dataArr addObject:model1.startTimeStr];
        }
        if (![model1.startTimeStr isEqualToString:model2.startTimeStr]) {
            [arr2 addObject:[NSString stringWithFormat:@"%i",i]];
            [self.dataArr addObject:model2];
        }
        
    }
   //存数据

        for (int i =0; i<arr2.count; i++) {
            NSMutableArray *arr3 = [NSMutableArray array];
            //将不同时间的下载东西存在不同的数组里
            for (int j = [arr2[i] intValue]; j<arr.count; j++) {
                //后面没有数了
                if (i+1==arr2.count) {
                    if (j+1==arr.count) {
                        WWSessionModel *model3 = arr[j];
                        [arr3 addObject:model3];
                        break;
                    }
                   WWSessionModel *model3 = arr[j];
                   [arr3 addObject:model3];
                }
                //后面还有数
                else if (j==[arr2[i+1] intValue]){
                    break;
                }
                WWSessionModel *model3 = arr[j];
                [arr3 addObject:model3];
            }
            [self.dataSource  addObject:arr3];
        }

 
        dispatch_sync(dispatch_get_main_queue(), ^{


            [self.tableView reloadData];
                });
        
          });
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
//    //    //创建标题。。。。
//    //    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(LFScreenW/2-(LFScreenW*2/5/2),_menu.y , LFScreenW*2/5, pich)];
//    //    lab.text = @"Hot VR";
//    //    lab.textAlignment = NSTextAlignmentCenter;
//    //    lab.textColor = [UIColor whiteColor];
//    //    [_TopBackGroud addSubview:lab];
//
//
//    //back
//   UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(10, _menu.y, picw+5, pich+5)];
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

#pragma mark 创建删除界面－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
-(void)CleanHistory{
    UIView *cleanView = [[UIView alloc]initWithFrame:CGRectMake(0, TopH, LFScreenW, LFScreenH/14+10)];
    cleanView.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc]init];
    
    [lab setfram:CGRectMake(10, 15, 200, 20) text:@"Clean the history" color:UIgracolor font:19];
    [cleanView addSubview:lab];
    [self.view addSubview:cleanView];
    
    //go
    UIButton *gobtn = [[UIButton alloc]initWithFrame:CGRectMake(LFScreenW-60, 20, 40, 15)];
    [gobtn setImage:[UIImage imageNamed:@"clean the history"] forState:UIControlStateNormal];
    [cleanView addSubview:gobtn];
    [gobtn addTarget:self action:@selector(clean) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, cleanView.height-10, LFScreenW, 10)];
    line.backgroundColor = GrayColor;
   //line.alpha = 0.1;
    [cleanView addSubview:line];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, cleanView.maxY, LFScreenW, LFScreenH/14)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *lab2 = [[UILabel alloc]init];
    [lab2 setfram:CGRectMake(10, 15, 200, 20) text:@"My Download" color:UIgracolor font:19];
    //[lab2 setfram:CGRectMake(10, 15, 200, 20) text:self.dataArr[section] color:UIgracolor font:19];
    [view addSubview:lab2];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, view.height-1, LFScreenW, 1)];
    line2.backgroundColor = GrayColor;
//    line.alpha = 0.1;
    [view addSubview:line2];
    
    [self.view addSubview:view];
}

#pragma mark 清理下载内容
-(void)clean{
    [[WWDownloadManager sharedInstance].sessionModelsArray removeAllObjects];
    [self initData];

}

-(void)createUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TopH+LFScreenH/7+10, LFScreenW, LFScreenH-TopH-LFScreenH/7-10) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = GrayColor;
    
    
    // _tableView.tableHeaderView = [self headView];
    
    _tableView.rowHeight = LFScreenH/9;
    [self.view addSubview:_tableView];
    
    _arr = [NSMutableArray arrayWithCapacity:0];
    for (int i =0; i<9; i++) {
        [_arr addObject:[NSNumber numberWithInteger:i]];
    }
    
    
    
    
    [self createTopView];
    [self deleteButton];
    //创建右上角菜单栏
    //    [self blackHeimu];
    //    [self createMenu];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [(NSMutableArray *)(self.dataSource[section]) count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DownloadCell *cell = [DownloadCell cellWithtableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WWSessionModel *model = self.dataSource[indexPath.section][indexPath.row];
    if (model.displayName) {
        cell.name.text = model.displayName;

    }
        if ([model.type isEqual:@"0"]) {
        cell.pic2.image = [UIImage imageNamed:@"panorama-s"];
    }
    //下载图片
    cell.pic.image = [UIImage imageNamed:model.filePath];
// [cell.pic sd_setImageWithURL:[NSURL URLWithString:model.filePath]];
    //下载大小
    cell.size.text = model.totalSize;
    //cell的btn给tag值
    cell.Download.tag = indexPath.row;
    switch (model.downloadState) {
            //正在下载
        case DownloadStateStart:
        {
            cell.progressView.hidden = NO;
//            cell.sizeLb.hidden = NO;
            if (model.totalSize) {
                cell.progressView.progress = 1.0*model.receivedLength/model.totalLength;
                cell.size.text = [NSString stringWithFormat:@"%@/%@",model.receivedSize,model.totalSize];
            }else{
                cell.progressView.progress =0;
                cell.size.text = @"0";
            }
            [cell.Download setImage:[UIImage imageNamed:@"download-_pause-new"] forState:UIControlStateNormal];
        }
            break;
            //暂停下载
        case DownloadStateSuspended:
        {
            cell.progressView.hidden = NO;
//            cell.sizeLb.hidden = NO;
            [cell.Download setImage:[UIImage imageNamed:@"download-download"] forState:UIControlStateNormal];
            
            if (model.totalSize) {
                cell.progressView.progress = 1.0*model.receivedLength/model.totalLength;
                if (model.receivedSize) {
                    cell.size.text = [NSString stringWithFormat:@"%@/%@",model.receivedSize,model.totalSize];
                }
               
            }else{
                cell.progressView.progress =0;
                cell.size.text = @"0";
            }
            
        }
            break;
            //等待下载waitting
        case DownloadStateLoading:
        {
            cell.progressView.hidden = YES;
//            cell.sizeLb.hidden = YES;
            [cell.Download setImage:[UIImage imageNamed:@"waitting"] forState:UIControlStateNormal];
              cell.size.text = @"waiting";
        }
            break;
            //已完成
        case DownloadStateCompleted:
        {
            cell.progressView.hidden = YES;
            //cell.sizeLb.hidden = YES;
            cell.viewBlack.hidden = YES;
            [cell.Download setImage:[UIImage imageNamed:@"download-play"] forState:UIControlStateNormal];
            [cell.Download addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
            _indexpath = indexPath;
            //[self initData];
        }
            break;
        case DownloadStateFailed:
        {
            cell.progressView.hidden = YES;
//            cell.sizeLb.hidden = YES;
            [cell.Download setImage:[UIImage imageNamed:@"edit-user-name_delete"] forState:UIControlStateNormal];
            
        }
            break;
        default:
            break;
    }
    
    model.stateBlock = ^(DownloadState state){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            switch (state) {
                          //暂停下载
                case DownloadStateSuspended:
                {
                    cell.progressView.hidden = NO;
//                    cell.sizeLb.hidden = NO;
                    [cell.Download setImage:[UIImage imageNamed:@"download-download"] forState:UIControlStateNormal];


                     //[_tableView reloadData];
               ;
                }
                    break;
                    //等待下载
                case DownloadStateLoading:
                {
                    cell.progressView.hidden = YES;
//                    cell.sizeLb.hidden = YES;
                    [cell.Download setImage:[UIImage imageNamed:@"waitting"] forState:UIControlStateNormal];

                  //   [_tableView reloadData];
                }
                    break;
                case DownloadStateCompleted:
                {
                                        cell.progressView.hidden = YES;
                    //                    cell.sizeLb.hidden = YES;
                    [cell.Download setImage:[UIImage imageNamed:@"download-play"] forState:UIControlStateNormal];
                   // self.dataSource = [WWDownloadManager sharedInstance].sessionModelsArray;
                    //[self.tableView reloadRrowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                                      // [_tableView reloadData];
                    [self initData];
                }
                    break;
                    //正在下载
                case DownloadStateStart:
                {
                    cell.progressView.hidden = NO;
//                    cell.sizeLb.hidden = NO;
                    [cell.Download setImage:[UIImage imageNamed:@"download-_pause-new"] forState:UIControlStateNormal];
                   // [_tableView reloadData];
                   


                }
                    break;
                default:
                    break;
            }
        });
        
        
    };
    
    model.progressBlock = ^(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize){
        NSLog(@"%@",[NSThread currentThread]);
        cell.progressView.progress = progress;
        cell.size.text = [NSString stringWithFormat:@"%@/%@",writtenSize,totalSize];
    };
    
    
    cell.btnClickedBlock = ^(){
        [[WWDownloadManager sharedInstance] download:@{@"ResourceUrl":model.url} progress:^(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize) {
            
        } state:^(DownloadState state) {
            
        }];
        
          [self.tableView reloadData];
    };
    


    

    
    
    return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, LFScreenH/14)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc]init];
    //[lab setfram:CGRectMake(10, 15, 200, 20) text:@"My Download" color:UIgracolor font:19];
    if (self.dataArr.count!=0) {
         [lab setfram:CGRectMake(10, 15, 200, 20) text:self.dataArr[section] color:UIgracolor font:19];
    }
    
    [view addSubview:lab];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, view.height-1, LFScreenW, 1)];
    line.backgroundColor = UIgracolor;
    line.alpha = 0.1;
    [view addSubview:line];
    
    return view;
    
    
}


//点击播放
-(void)play:(UIButton *)btn{
    WWSessionModel *model = self.dataSource[_indexpath.section][_indexpath.row];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"pano1.jpg" ofType:nil];
  //
   // NSString *path = model.filePath;
    NSLog(@"-------------%@===========",model.filePath);
    NSLog(@"==========%@===========",path);
    GooglePanaromaVc *vr = [[GooglePanaromaVc alloc]init];
    vr.filename = model.filePath;
    vr.type=1;
    [self presentViewController:vr animated:YES completion:nil];
    
    //[self launchAsImage:[NSURL fileURLWithPath:model.filePath]];
}

//- (void)launchAsImage:(NSURL*)url {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BitmapPlayer" bundle:nil];
//    PlayerViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"BitmapPlayerViewController"];
//    
//    [self presentViewController:vc animated:NO completion:^{
//        [vc initParams:url];
//    }];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return LFScreenH/14;
}



#pragma makr左滑删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // NSArray *_tempIndexPathArr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
    WWSessionModel *model = self.dataSource[indexPath.section][indexPath.row];
    [[WWDownloadManager sharedInstance]deleteFile:model.url];
   // [_tableView beginUpdates];
 

    //[self.dataSource removeObjectAtIndex:indexPath.row ];
   
    //[_tableView deleteRowsAtIndexPaths:_tempIndexPathArr withRowAnimation:UITableViewRowAnimationFade];
          // [_tableView endUpdates];
    self.dataSource = [WWDownloadManager sharedInstance].sessionModelsArray;
    [_tableView reloadData];
    
}


@end
