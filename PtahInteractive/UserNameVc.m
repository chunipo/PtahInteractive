//
//  UserNameVc.m
//  PtahInteractive
//
//  Created by ptah on 16/8/18.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "UserNameVc.h"

@interface UserNameVc ()
{
    //1
    UIView *_TopBackGroud;
    
    UIButton *_menu;
    
    //2
    UITextField         *_textName;
    
}




@end

@implementation UserNameVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = GrayColor;
    
    [self createTopView];
    //创建
    [self username];
    
    //
    [self saveBtn];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}
#pragma arc 创建顶层视图
-(void)createTopView{
    _TopBackGroud = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LFScreenW, LFScreenH*1/11)];
    
    _TopBackGroud.backgroundColor = TopBackGroudeColor;
    
    [self.view addSubview:_TopBackGroud];
    
    _menu = [[UIButton alloc]initWithFrame:CGRectMake(LFScreenW-20-picw, _TopBackGroud.frame.size.height-35, picw, pich)];
    
    [_menu setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    
    [_menu addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    
    [_TopBackGroud addSubview:_menu];
    
    
    
//    _search = [[UIButton alloc]initWithFrame:CGRectMake(_menu.x-20-picw, _menu.y, picw, pich)];
//    
//    [_search setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
//    [_TopBackGroud addSubview:_search];
    
    
    
    //back
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(10, _menu.y, picw+5, pich+5)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_TopBackGroud addSubview:back];
    
    
    
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)home{
    
}

-(void)username{
    _textName = [[UITextField alloc]initWithFrame:CGRectMake(20,TopH+30, LFScreenW-40, 40)];
    _textName.borderStyle = UITextBorderStyleNone;
      _textName.backgroundColor = [UIColor clearColor];
    _textName.font = [UIFont fontWithName:@"Arial" size:15];
//    _textName.layer.cornerRadius = 15;
    _textName.placeholder = @"User Name";
    
    _textName.text = self.userName;
    _textName.font = [UIFont systemFontOfSize:20];
    _textName.textColor = [UIColor blackColor];
    
    _textName.clearButtonMode = UITextFieldViewModeNever;
    
    _textName.keyboardType = UIKeyboardTypeDefault;
    
    _textName.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    _textName.returnKeyType = UIReturnKeyDone;
    
//    _textName.delegate = self;
    
    [self.view addSubview:_textName];
    
    [_textName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIImageView *line = [[UIImageView alloc]init];
    [line setfram:CGRectMake(_textName.x-10, _textName.maxY-12, _textName.width+10, 5) image:@"edit-user-name_line" useinterface:NO];
    [self.view addSubview:line];
    
    //添加一个叉号
    UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(_textName.maxX-25, _textName.y+10, 20, 20)];
    [deleteBtn setImage:[UIImage imageNamed:@"edit-user-name_delete"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];


}

-(void)delete{
    _textName.text = @"";
}

- (void)textFieldDidChange:(UITextField *)textField
{
    
    if (textField.text.length > 30) {
        textField.text = [textField.text substringToIndex:19];
    }
    
}

#pragma mark 代理的实现

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
    
}

#pragma mark save---------------------------
-(void)saveBtn{
    UIButton *saveBt = [[UIButton alloc]initWithFrame:CGRectMake(_textName.x-10, _textName.maxY+20, _textName.width+10, 40)];
    
//    [saveBt setTitle:@"Save" forState:UIControlStateNormal];
//    //saveBt.clipsToBounds = YES;
//    saveBt.layer.cornerRadius = 5;
//    
//    [saveBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [saveBt addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
//    saveBt.backgroundColor = [UIColor orangeColor];
    [saveBt setImage:[UIImage imageNamed:@"edit-user-name_0000_save name"] forState:UIControlStateNormal];
    
    [self.view addSubview:saveBt];

}

-(void)save{
    if ([self.delegate respondsToSelector:@selector(ChangeUserName:)]) {
        [_delegate ChangeUserName:_textName.text];
    }
    [_textName resignFirstResponder];
    [SVProgressHUD showSuccessWithStatus:@"Success"];
    
       [self dismissViewControllerAnimated:YES completion:nil];
       
 
    //[self.view addSubview:hud];
   // [self dismissViewControllerAnimated:YES completion:nil];
}


@end
