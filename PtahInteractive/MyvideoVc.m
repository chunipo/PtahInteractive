//
//  MyvideoVc.m
//  PtahInteractive
//
//  Created by ptah on 16/8/8.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "MyvideoVc.h"
//#import "VRModel.h"
#import "MyVideoCell.h"
#import "TeriManerger.h"
#import "Local.h"
#import "LocalModel.h"


@interface MyvideoVc ()<UITableViewDelegate,UITableViewDataSource>
{
    
    //1
    UIView *_TopBackGroud;
    UIButton *_search;
    UIButton *_menu;
    
    //2
    UITableView *_MyvideoTable;
    NSMutableArray  *_arr;
    UIButton     *_allSelectBtn;
    bool     _isAll;
    
    
}
@property(nonatomic,strong)NSManagedObjectContext *context;

@end


@implementation MyvideoVc

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Local"];
    NSMutableArray* arr2 = [NSMutableArray array];
    arr2 = [_context executeFetchRequest:request error:nil];

    for (Local *localModel in arr2) {
        [_context deleteObject:localModel];
    }
    [_context save:nil];
    
     
    
    //添加进入数据库
    for (int i = 0; i<_arr.count; i++) {
        
    LocalModel *model = [[LocalModel alloc]init];
        model.localmodel = _arr[i];
     
    
    Local *localdata = [NSEntityDescription insertNewObjectForEntityForName:@"Local" inManagedObjectContext:_context];
        //localdata.originalImg = model.originalImg;
        localdata.imgName = model.imgName;
        localdata.miniImg = model.miniImg;
        localdata.originalpic = model.originalpic;

    
    NSError *error = nil;
    
    BOOL isok = [_context save:&error];
    
    if (isok) {
        NSLog(@"保存图片到本地成功");
    }else
        NSLog(@"保存图片到本地失败");

    }

}

-(void)viewDidLoad{
    [super viewDidLoad];
   [self useCoredata];

    [self createTopView];
    
    [self createTableView];
}

-(void)useCoredata{
    TeriManerger *manager = [TeriManerger shareManager];
    
    _context = manager.context;
}

#pragma arc 创建顶层视图-----------------------------------------------------------------------------------
-(void)createTopView{
    _TopBackGroud = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, LFScreenH*1/11)];
    
    _TopBackGroud.backgroundColor = TopBackGroudeColor;
    
    [self.view addSubview:_TopBackGroud];


    
    //创建标题。。。。
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(LFScreenW/2-(LFScreenW*2/5/2),_TopBackGroud.maxY-35 , LFScreenW*2/5, pich)];
    lab.text = @"My Video";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    [_TopBackGroud addSubview:lab];
    
    
    //back
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(10, lab.y, picw-5, pich)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_TopBackGroud addSubview:back];
    
    //laji
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(LFScreenW-40, 27, 15, 20)];
    [btn setImage:[UIImage imageNamed:@"local-video_top delete"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    [_TopBackGroud addSubview:btn];
    
    
    
}

-(void)delete{

    int i= 0;
    NSMutableArray *detarr = [NSMutableArray arrayWithCapacity:0];
    //如果全选就全部删除
    if (_isAll) {
        [_arr removeAllObjects];
        [_MyvideoTable reloadData];
        [_allSelectBtn setImage:[UIImage imageNamed:@"local-video_select1"] forState:UIControlStateNormal];
        
    }
    
    else{
    [_arr enumerateObjectsUsingBlock:^(LocalModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSLog(@"=======%i????=====",i);
        if (obj.selectState==YES) {
            [detarr addObject:obj];
            
        }
    }];
        [_arr removeObjectsInArray:detarr];
        [_MyvideoTable reloadData];
    }
    //如果全删，则把垃圾箱图像变为为选
    if (_arr.count==0) {
        [_allSelectBtn setImage:[UIImage imageNamed:@"local-video_select1"] forState:UIControlStateNormal];
    }
    
    

}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark  TableView--------------------------------------------------------------------------------------------------------
-(void)createTableView{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Local"];
   NSMutableArray* arr2 = [NSMutableArray array];
    arr2 = [_context executeFetchRequest:request error:nil];
    _arr = [NSMutableArray array];
    for (int i =0; i<arr2.count; i++) {
        LocalModel *model = [[LocalModel alloc]init];
        model.localmodel =arr2[i];
        
        [_arr addObject:model];
    }
    
    _MyvideoTable = [[UITableView alloc]initWithFrame:CGRectMake(0, _TopBackGroud.maxY, LFScreenW, LFScreenH-_TopBackGroud.height) style:UITableViewStylePlain];
    //
       
    _MyvideoTable.delegate = self;
    _MyvideoTable.dataSource = self;
    _MyvideoTable.separatorStyle =  UITableViewCellSeparatorStyleNone;

    
    _MyvideoTable.tableHeaderView = [self headView];
    
    [self.view addSubview:_MyvideoTable];

}
#pragma mark 头部视图－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

-(UIView *)headView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, 50)];
    
    //添加全选图片按钮
    _allSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _allSelectBtn.frame = CGRectMake(20, 13, 22, 22);
    [_allSelectBtn setImage:[UIImage imageNamed:@"local-video_select1"] forState:UIControlStateNormal];
    [_allSelectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_allSelectBtn];
    
    //添加一个全选文本框标签
    UILabel *lab = [[UILabel alloc]init];
    [lab setfram:CGRectMake(_allSelectBtn.maxX+10, 7, 50, 30) text:@"All" color:UIgracolor font:20];
    [view addSubview:lab];
    
//    //
//    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 49, LFScreenW, 1)];
//    line.backgroundColor = UIgracolor;
//    line.alpha = 0.3;
//    //[view addSubview:line];
    
    
    
    return view;
}
-(void)selectBtnClick:(UIButton *)sender
{
    //判断是否选中，是改成否，否改成是，改变图片状态
    sender.tag = !sender.tag;
    if (sender.tag)
    {
        [sender setImage:[UIImage imageNamed:@"local-video_select2"] forState:UIControlStateNormal];
        _isAll = YES;
    }else{
        [sender setImage:[UIImage imageNamed:@"local-video_select1"] forState:UIControlStateNormal];
        _isAll = NO;
    }
    //改变单元格选中状态
    for (int i=0; i<_arr.count; i++)
    {
        LocalModel *model = [_arr objectAtIndex:i];
        model.selectState = sender.tag;
    }
        //刷新表格
    [_MyvideoTable reloadData];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arr.count;
}

//定制单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify =  @"indentify";
    MyVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[MyVideoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
//        cell.delegate = self;
                //调用方法，给单元格赋值
           }
    
    cell.localmodel =_arr[indexPath.row];

    [cell addTheValue:_arr[indexPath.row]];

    
    return cell;
}

//返回单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LFScreenH*3/24;
}

//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  判断当期是否为选中状态，如果选中状态点击则更改成未选中，如果未选中点击则更改成选中状态
     */
    LocalModel *model = _arr[indexPath.row];
    
    if (model.selectState&&_isAll==NO)
    {
        model.selectState = NO;
    }else if (model.selectState&&_isAll){
        model.selectState = NO;
        _isAll=NO;
        [_allSelectBtn setImage:[UIImage imageNamed:@"local-video_select1"] forState:UIControlStateNormal];
        
    }
    else
    {
        model.selectState = YES;
    }
    
    //刷新整个表格
     //   [_MyvideoTable reloadData];
    
    //刷新当前行
    [_MyvideoTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
   
}






@end
