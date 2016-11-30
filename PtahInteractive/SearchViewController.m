//
//  SearchViewController.m
//  PtahInteractive
//
//  Created by ptah on 16/8/5.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchCell.h"

@interface SearchViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    //1
    UIView *_TopBackGroud;
    UIButton *_search;
    
    
    //
    UITableView  *_tableView;
    

}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTopView];
    
    
    [self createTableView];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma arc 创建第一层视图
-(void)createTopView{
    _TopBackGroud = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, LFScreenH*1/11)];
    
    _TopBackGroud.backgroundColor = TopBackGroudeColor;
    
    [self.view addSubview:_TopBackGroud];
    
    _search = [[UIButton alloc]initWithFrame:CGRectMake(LFScreenW-20-picw, _TopBackGroud.frame.size.height-35, picw, pich)];
    
    [_search setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [_TopBackGroud addSubview:_search];
    
    
    //
    UITextField *text = [[UITextField alloc]initWithFrame:CGRectMake(60, 25, LFScreenW-60-10-(LFScreenW-_search.x), 25)];
    text.borderStyle = UITextBorderStyleNone;
    
    text.background = [UIImage imageNamed:@"search_frame"];
    text.backgroundColor = [UIColor clearColor];
    text.font = [UIFont fontWithName:@"Arial" size:15];
//    text.layer.cornerRadius = 15;
    
    text.textColor = [UIColor blackColor];
    
    text.clearButtonMode = UITextFieldViewModeAlways;
    
    text.keyboardType = UIKeyboardTypeDefault;
    
    text.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    text.returnKeyType = UIReturnKeySearch;
    
    text.delegate = self;
    
    [_TopBackGroud addSubview:text];
    
    
//    _search = [[UIButton alloc]initWithFrame:CGRectMake(_menu.x-20-picw, _menu.y, picw, pich)];
//    [_search addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
//    //_search.tag = 200;
//    
//    [_search setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    //[_TopBackGroud addSubview:_search];
    
    
    //back
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(10, _search.y, picw, pich+3)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_TopBackGroud addSubview:back];
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark 代理的实现

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;

}


#pragma mark 创建tableview－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _TopBackGroud.maxY, LFScreenW, LFScreenH-_TopBackGroud.height) style:UITableViewStylePlain];
    
    _tableView.backgroundColor = GrayColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //_tableView.rowHeight = LFScreenW/8;
    
    _tableView.tableHeaderView = [self headView];
    [self.view addSubview:_tableView];

}
#pragma mark 头部视图
-(UIView *)headView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, 90)];
    //
    view.backgroundColor = GrayColor;
    
//    UIImageView *hotImg = [[UIImageView alloc]init];
//    [hotImg setfram:CGRectMake(20, 10, 20, 20) image:@"" useinterface:NO];
//    hotImg.backgroundColor = [UIColor redColor];
//    
//    [view addSubview:hotImg];
//    //
//    UILabel *hotLab = [[UILabel alloc]init];
//    [hotLab setfram:CGRectMake(hotImg.maxX+10, 10, 100, 20) text:@"Hot search" color:[UIColor blackColor] font:15];
//    [view addSubview:hotLab];
    NSArray *arr = @[@"Classic",@"Modern",@"Shopping",@"Business"];
    //间距
    CGFloat kWidth = 10;
    CGFloat btWth = (LFScreenW-5*10)/4;
    for (int i =0; i<arr.count; i++) {
        UIImageView *imageBack = [[UIImageView  alloc]initWithFrame:CGRectMake(kWidth+(btWth+kWidth)*i, 10, btWth, 30)];
        
        imageBack.tag = 100+i;
        imageBack.image = [UIImage imageNamed:@"search_group tag"];
        imageBack.userInteractionEnabled = YES;
    
        
        
        //        [btn setImage:[UIImage imageNamed:@"search_group tag"] forState:UIControlStateNormal];
        
        [view addSubview:imageBack];
        
        //
        UILabel *lab = [[UILabel alloc]init];
        [lab setfram:CGRectMake(10, 7, imageBack.width-20, 15) text:arr[i] color:[UIColor blackColor] font:11];
        lab.textAlignment = NSTextAlignmentCenter;
        [imageBack addSubview:lab];
        
    }
    
    //rank list
    UIImageView *ListImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_ranking list"]];
    ListImg.frame = CGRectMake(10, 60, 30, 20);
    
    [view addSubview:ListImg];
    
    //
    UILabel *lab = [[UILabel alloc]init];
    [lab setfram:CGRectMake(ListImg.maxX+10, ListImg.y, 200, 20) text:@"Ranking List" color:[UIColor blackColor] font:19];
    [view addSubview:lab];
   
    return view;
    
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchCell *cell = [SearchCell cellWithtableView:tableView];
    
    if (!cell) {
        cell = [[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        
    }
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return LFScreenH*6/21;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
