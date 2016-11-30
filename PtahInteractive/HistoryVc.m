//
//  HistoryVc.m
//  PtahInteractive
//
//  Created by ptah on 16/8/11.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "HistoryVc.h"

#import "HistoryCell.h"
#import "TeriManerger.h"
#import "VRModel.h"
#import "History.h"
#import "WWDownload/WWSessionModel.h"
#import "WWDownloadManager.h"

@interface HistoryVc ()<UITableViewDelegate,UITableViewDataSource>
{
    //1
    UIView *_TopBackGroud;
    UIButton *_search;
    UIButton *_menu;
    
    
    //2
    UITableView  *_tableView;
    NSMutableArray  *_arr;
    
}

@property(nonatomic,strong)NSManagedObjectContext *context;
@end

@implementation HistoryVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = GrayColor;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, TopH, LFScreenW, LFScreenH-TopH)];
    view.backgroundColor =UIgracolor;
    view.alpha = 0.1;
    [self.view addSubview:view];
      [self useCoredata];
//    [self createTopView];
    
    [self CleanHistory];
    
    [self createUI];
    
}

-(void)useCoredata{
    TeriManerger *manager = [TeriManerger shareManager];
    
    _context = manager.context;
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
    
    
    UIView *cleanView = [[UIView alloc]initWithFrame:CGRectMake(0, TopH, LFScreenW, LFScreenH/14)];
    cleanView.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc]init];
    
    [lab setfram:CGRectMake(10, 15, 200, 20) text:@"Clean the history" color:UIgracolor font:19];
    [cleanView addSubview:lab];
    [self.view addSubview:cleanView];
    
    //go
    UIButton *gobtn = [[UIButton alloc]initWithFrame:CGRectMake(LFScreenW-60, 20, 40, 15)];
    [gobtn setImage:[UIImage imageNamed:@"clean the history"] forState:UIControlStateNormal];
    [gobtn addTarget:self action:@selector(clean) forControlEvents:UIControlEventTouchUpInside];
    [cleanView addSubview:gobtn];
}
#pragma mark 清理历史纪录
-(void)clean{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    NSMutableArray* arr2 = [NSMutableArray array];
    arr2 = [_context executeFetchRequest:request error:nil];
    
    for (History *localModel in arr2) {
        [_context deleteObject:localModel];
    }
    [_context save:nil];
    _arr = [_context executeFetchRequest:request error:nil];

    [_tableView reloadData];
    
}

-(void)createUI{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    _arr = [NSMutableArray arrayWithCapacity:0];
    _arr = [_context executeFetchRequest:request error:nil];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TopH+LFScreenH/14+10, LFScreenW, LFScreenH-TopH-LFScreenH/14-10) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = GrayColor;
    
    
   // _tableView.tableHeaderView = [self headView];
    
    _tableView.rowHeight = LFScreenH/9;
    [self.view addSubview:_tableView];
    
//    _arr = [NSMutableArray arrayWithCapacity:0];
//    for (int i =0; i<9; i++) {
//        [_arr addObject:[NSNumber numberWithInteger:i]];
//    }
    
    
    
    
    [self createTopView];
    [self deleteButton];
    //创建右上角菜单栏
    //    [self blackHeimu];
    //    [self createMenu];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryCell *cell = [HistoryCell cellWithtableView:tableView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _arr[indexPath.row];
    cell.Download.tag = 100+indexPath.row;
    cell.btnClickedBlock = ^(){
        History *model =_arr[indexPath.row];
        NSString *resourceUrl = [NSString stringWithFormat:ThumbnailImg,model.fileName];
        
        if (![[WWDownloadManager sharedInstance] isExistDownloadList:resourceUrl]) {
            //            UIImage *image = WeakCell.logoIV.image;
            //NSString *title = self.dataSource[indexPath.row][@"Title"];
            NSDictionary *dic = @{@"type":model.type,
                                  @"ResourceUrl":resourceUrl,
                                  @"displayName":model.displayName,
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
    };

    
    return cell;
    
}
//-(void)downloadurl:(UIButton *)btn{
//    History *model = _arr[btn.tag-100];
//    
//    NSString *resourceUrl = [NSString stringWithFormat:ThumbnailImg,model.fileName];
//    
//    if (![[WWDownloadManager sharedInstance] isExistDownloadList:resourceUrl]) {
//        //            UIImage *image = WeakCell.logoIV.image;
//        //NSString *title = self.dataSource[indexPath.row][@"Title"];
//        NSDictionary *dic = @{@"type":model.type,
//                              @"ResourceUrl":resourceUrl,
//                              @"displayName":model.displayName,
//                              @"filePath":resourceUrl
//                              };
//        
//        // NSDictionary *dic = [NSDictionary dictionary];
//        
//        [[WWDownloadManager sharedInstance] download:dic progress:^(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize) {
//            
//        } state:^(DownloadState state) {
//            NSLog(@"state======%li",state);
//        }];
//        
//    }else{
//        NSLog(@"资源已在下载列表");
//        [SVProgressHUD showSuccessWithStatus:@"Resources are download"];
//
//    }
//    
//
//    
//    
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, LFScreenH/14)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc]init];
    [lab setfram:CGRectMake(10, 15, 200, 20) text:@"History" color:UIgracolor font:19];
    [view addSubview:lab];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, view.height-1, LFScreenW, 1)];
    line.backgroundColor = UIgracolor;
    line.alpha = 0.1;
    [view addSubview:line];
    
    return view;


}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return LFScreenH/14;
}



#pragma makr左滑删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"History"];
    NSMutableArray *arr = [NSMutableArray array];
    arr = [_context executeFetchRequest:request error:nil];
    
    History *history  = _arr[indexPath.row];
    NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:0];
    for (History *hist2 in arr) {
        if ([hist2.displayName isEqualToString:history.displayName]) {
//            [arr2 addObject:hist2];
            [_context deleteObject:hist2];
        }
    }
    //[arr removeObjectsInArray:arr2];
    [_context save:nil];
    //_arr = arr;
    _arr =[_context executeFetchRequest:request error:nil];
    [_tableView reloadData];

    
    
}

//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
//}





@end
