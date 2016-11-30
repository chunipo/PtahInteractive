//
//  PtahDenluVc.m
//  PtahInteractive
//
//  Created by ptah on 16/8/17.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "PtahDenluVc.h"
#import "HomeViewCtroller.h"
#import "MainNavigationControllerViewController.h"
#import "CoreLaunchCool.h"

@interface PtahDenluVc ()<UITextFieldDelegate>
{

    UIImageView                 *_back;
    UITextField                 *_textName;
    UITextField                 *_textPassword;
    UITextField                 *_texteMail;
}

@end

@implementation PtahDenluVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:29./255 green:170./255 blue:243./255 alpha:1];
    [self LowImg];
    //创建注册界面
    [self TextFileUI];
}


#pragma mark 创建注册界面-------------------------------------------------------------------------------------------------
-(void)TextFileUI{
    
    
    
    //注册
    
    
    _textName = [[UITextField alloc]initWithFrame:CGRectMake(30, LFScreenH/3, LFScreenW-60, 40)];
    _textName.borderStyle = UITextBorderStyleNone;
    //  _textName.backgroundColor = [UIColor clearColor];
    _textName.font = [UIFont fontWithName:@"Arial" size:15];
    _textName.background = [UIImage imageNamed:@"search_frame"];
    //_textName.layer.cornerRadius = 15;
    _textName.placeholder = @"    Email";
    _textName.textColor = [UIColor blackColor];
    
    _textName.clearButtonMode = UITextFieldViewModeAlways;
    
    _textName.keyboardType = UIKeyboardTypeDefault;
    
    _textName.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    _textName.returnKeyType = UIReturnKeyDone;
    
    _textName.delegate = self;
    
    [self.view addSubview:_textName];
    
    [_textName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    
    //paaword
    _textPassword = [[UITextField alloc]initWithFrame:CGRectMake(30, _textName.maxY+10, LFScreenW-60, 40)];
    _textPassword.borderStyle = UITextBorderStyleNone;
    // text.backgroundColor = [UIColor clearColor];
    _textPassword.font = [UIFont fontWithName:@"Arial" size:15];
    _textPassword.background = [UIImage imageNamed:@"search_frame"];
    _textPassword.placeholder = @"    Passward";
    _textPassword.textColor = [UIColor blackColor];
    
    _textPassword.clearButtonMode = UITextFieldViewModeAlways;
    
    _textPassword.keyboardType = UIKeyboardTypeDefault;
    
    _textPassword.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    _textPassword.returnKeyType = UIReturnKeyDone;
    
    _textPassword.delegate = self;
    
    [self.view addSubview:_textPassword];
    
    [_textPassword addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _textPassword.secureTextEntry = YES;
    
    
    
    
    
    //登陆
    
    UIImageView *img = [[UIImageView alloc]init];
    [img setfram:CGRectMake(_textName.x, _textPassword.maxY+20,_textPassword.width, 40) image:@"frame-2" useinterface:NO];
    [self.view addSubview:img];
    
    UIButton *registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(_textName.x, _textPassword.maxY+20,_textPassword.width, 40)];
    
    [registerBtn setTitle:@"Sign in" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(reigister:) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.tag = 200;
    [self.view addSubview:registerBtn];
    
    //wanjimima
    UIButton *fogrtBtn = [[UIButton alloc]initWithFrame:CGRectMake(LFScreenW/2-LFScreenW/4, registerBtn.maxY+20, LFScreenW/2, 20)];
    
    [fogrtBtn setTitle:@"Foget password?" forState:UIControlStateNormal];
    
    [self.view addSubview:fogrtBtn];
    
    
    
}
-(void)reigister:(UIButton *)btn{
    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:[[MainNavigationControllerViewController alloc]initWithRootViewController:[[HomeViewCtroller alloc]init]]];
    
//    [CoreLaunchCool animWithWindow:[[UIApplication sharedApplication] delegate].window image:[UIImage imageNamed:@"skinBackImage_7.jpg"]];


}

- (void)textFieldDidChange:(UITextField *)textField
{
    
    if (textField.text.length > 19) {
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


-(void)LowImg{
    UILabel *lab= [[UILabel alloc]init];
    [lab setfram:CGRectMake(LFScreenW/2-40, LFScreenH-40, 80, 20) text:@"©2016 Tetris" color:[UIColor whiteColor] font:12];
    lab.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:lab];
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
