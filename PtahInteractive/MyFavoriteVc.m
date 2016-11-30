//
//  MyFavoriteVc.m
//  PtahInteractive
//
//  Created by ptah on 16/8/10.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "MyFavoriteVc.h"
#import "MyFavoriteCell.h"
#import "VRModel.h"
#import "TeriManerger.h"
#import "Collect.h"

@interface MyFavoriteVc ()<UITableViewDelegate,UITableViewDataSource>
{
    //1
    UIView *_TopBackGroud;
    UIButton *_search;
    UIButton *_menu;
    
    
    //2
    UITableView  *_tableView;
    NSMutableArray *_arr;
    
}


@property(nonatomic,strong)NSManagedObjectContext *context;
@end

@implementation MyFavoriteVc

-(void)useCoredata{
    TeriManerger *manager = [TeriManerger shareManager];
    
    _context = manager.context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = GrayColor;
    [self useCoredata];
//    [self createTopView];
    
    [self createUI];
    
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

-(void)createUI{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Collect"];
    _arr = [NSMutableArray arrayWithCapacity:0];
    _arr = [_context executeFetchRequest:request error:nil];
    

    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TopH, LFScreenW, LFScreenH-TopH) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.tableHeaderView = [self headView];
    
    _tableView.rowHeight = LFScreenH/9;
    [self.view addSubview:_tableView];
    
    
    
    
    [self createTopView];
    [self deleteButton];
    //创建右上角菜单栏
    //    [self blackHeimu];
    //    [self createMenu];

}

-(UIView *)headView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, LFScreenH/20)];
    
    UILabel *lab = [[UILabel alloc]init];
    [lab setfram:CGRectMake(20, 5, 200, 20) text:@"My Favorties" color:UIgracolor font:19];
    [view addSubview:lab];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, view.height-1, LFScreenW, 1)];
    line.backgroundColor = UIgracolor;
    line.alpha = 0.1;
    [view addSubview:line];
    
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyFavoriteCell *cell = [MyFavoriteCell cellWithtableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _arr[indexPath.row];
    
    return cell;

}


@end
