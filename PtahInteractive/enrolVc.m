//
//  enrolVc.m
//  PtahInteractive
//
//  Created by ptah on 16/8/17.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "enrolVc.h"
#import "HomeViewCtroller.h"
#import "MainNavigationControllerViewController.h"
#import "CoreLaunchCool.h"
#import "TeriManerger.h"
#import "Login.h"
#import "AppDelegate.h"


@interface enrolVc ()<UITextFieldDelegate>

{
    UIImageView                 *_back;
    UITextField                 *_textName;
    UITextField                 *_textPassword;
    UITextField                 *_texteMail;
}

@property(nonatomic,strong)NSString *userName;

@property(nonatomic,strong)NSString *eMail;

@property(nonatomic,strong)NSString *passWord;

@property(nonatomic,strong)NSManagedObjectContext *context;

@end

@implementation enrolVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:29./255 green:170./255 blue:243./255 alpha:1];

    [self LowImg];
    
    //调用数据库
    [self useCoredata];
    
    //创建注册界面
    [self TextFileUI];
    
    //
    
}

#pragma mark 调用数据库-------------------------------------------------------------------------------------------------
-(void)useCoredata{
    TeriManerger *manager = [TeriManerger shareManager];
    
    _context = manager.context;
}

#pragma mark 创建注册界面-------------------------------------------------------------------------------------------------
-(void)TextFileUI{
    _back = [[UIImageView alloc]init];
    [_back setfram:CGRectMake(LFScreenW/2-LFScreenW/3, LFScreenH*5/18, LFScreenW*2/3, 150) image:@"" useinterface:YES];
    _back.layer.cornerRadius = 10;
    _back.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_back];
    
    
    //注册
    
    
        _textName = [[UITextField alloc]initWithFrame:CGRectMake(40, 0, _back.width-40, 50)];
        _textName.borderStyle = UITextBorderStyleNone;
        //  _textName.backgroundColor = [UIColor clearColor];
        _textName.font = [UIFont fontWithName:@"Arial" size:15];
//        _textName.layer.cornerRadius = 15;
        _textName.placeholder = @"User Name";
        _textName.textColor = [UIColor blackColor];
        
        _textName.clearButtonMode = UITextFieldViewModeAlways;
        
        _textName.keyboardType = UIKeyboardTypeDefault;
        
        _textName.autocapitalizationType = UITextAutocapitalizationTypeWords;
        
        _textName.returnKeyType = UIReturnKeyDone;
        
        _textName.delegate = self;
        
        [_back addSubview:_textName];
        
        [_textName addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
        
        //email
        _texteMail = [[UITextField alloc]initWithFrame:CGRectMake(40, 50, _back.width-40, 50)];
    _texteMail.borderStyle = UITextBorderStyleNone;
    // text.backgroundColor = [UIColor clearColor];
    _texteMail.font = [UIFont fontWithName:@"Arial" size:15];
//    _texteMail.layer.cornerRadius = 15;
    _texteMail.placeholder = @"Your Mail";
    _texteMail.textColor = [UIColor blackColor];
    
    _texteMail.clearButtonMode = UITextFieldViewModeAlways;
    
    _texteMail.keyboardType = UIKeyboardTypeDefault;
    
    _texteMail.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    _texteMail.returnKeyType = UIReturnKeyDone;
    
    _texteMail.delegate = self;
    
    [_back addSubview:_texteMail];
    
    [_texteMail addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _texteMail.keyboardType = UIKeyboardTypeEmailAddress;
    
        //paaword
        _textPassword = [[UITextField alloc]initWithFrame:CGRectMake(40, 100, _back.width-40, 50)];
    _textPassword.borderStyle = UITextBorderStyleNone;
//     _text.backgroundColor = [UIColor clearColor];
    _textPassword.font = [UIFont fontWithName:@"Arial" size:15];
   // _textPassword.layer.cornerRadius = 15;
    _textPassword.placeholder = @"Passward";
    _textPassword.textColor = [UIColor blackColor];
    
    _textPassword.clearButtonMode = UITextFieldViewModeAlways;
    
    _textPassword.keyboardType = UIKeyboardTypeDefault;
    
    _textPassword.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    _textPassword.returnKeyType = UIReturnKeyDone;
    
    _textPassword.delegate = self;
    
    [_back addSubview:_textPassword];
    
    [_textPassword addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

        _textPassword.secureTextEntry = YES;
    

    //tubiao
    NSArray *arrPic = @[@"register_user",@"register_mail",@"register_password"];
    for (int i =0; i<3; i++) {
        UIImageView *pic = [[UIImageView alloc]init];
        
        [pic setfram:CGRectMake(_textName.x-30, 18+i*50, 20, 12) image:arrPic[i] useinterface:NO];
        [_back addSubview:pic];
        
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _textName.maxY+i*_textName.height, _back.width, 1)];
        line.backgroundColor = self.view.backgroundColor;
        if (i==0) {
            pic.frame =CGRectMake(_textName.x-30, 17+i*50, 16, 12);
        }
        if (i==2) {
            [line removeFromSuperview];
        }
        [_back addSubview:line];
    }
    
    
    //注册后
    UIImageView *img = [[UIImageView alloc]init];
    [img setfram:CGRectMake(_back.x, _back.maxY+20,LFScreenW*2/3, 30) image:@"frame-2" useinterface:NO];
    [self.view addSubview:img];
    
    UIButton *registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(_back.x, _back.maxY+20,LFScreenW*2/3, 30)];
    
    [registerBtn setTitle:@"register" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(reigister:) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.backgroundColor = [UIColor clearColor];
    registerBtn.tag = 200;
    [self.view addSubview:registerBtn];
    
    
    
    //
//    UILabel *line = [[UILabel alloc]init];
//    [line setfram:CGRectMake(registerBtn.x, registerBtn.maxY+20, registerBtn.width, 30) text:@"---------  or  ---------" color:[UIColor whiteColor] font:14];
//    line.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:line];
    
    //
    UILabel *jjj = [[UILabel alloc]init];
    [jjj setfram:CGRectMake(LFScreenW/2-10, registerBtn.maxY+20, 20, 20) text:@"or" color:[UIColor whiteColor] font:14];
    jjj.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:jjj];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(jjj.x-70,  registerBtn.maxY+30, 70, 1)];
    line.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(jjj.maxX,  registerBtn.maxY+30, 70, 1)];
    line2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line2];
    
    //
    UILabel *text = [[UILabel alloc]init];
    [text setfram:CGRectMake(LFScreenW/2-registerBtn.width/2, line.maxY+25, registerBtn.width, 20) text:@"I want to play the app first" color:[UIColor whiteColor] font:14];
    text.textAlignment = NSTextAlignmentCenter;

    [self.view addSubview:text];
    
    //未注册
    
    UIImageView *img2 = [[UIImageView alloc]init];
    [img2 setfram:CGRectMake(LFScreenW/2-55/2, text.maxY+30,55, 55) image:@"register_go" useinterface:YES];
    [self.view addSubview:img2];
    
    UIButton *goBtn = [[UIButton alloc]initWithFrame:CGRectMake(13,10,30, 30)];
    
    [goBtn setTitle:@"go" forState:UIControlStateNormal];
    [goBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goBtn addTarget:self action:@selector(reigister:) forControlEvents:UIControlEventTouchUpInside];
    goBtn.titleLabel.font = [UIFont systemFontOfSize:26];
    goBtn.tag=201;
    [img2 addSubview:goBtn];
}

#pragma mark 点击注册进入注册完成界面
-(void)reigister:(UIButton *)btn{
    
    
    if (btn.tag==200) {
        
    
    self.userName = _textName.text;
    NSLog(@"用户注册的名字为：%@",self.userName);
    self.eMail = _texteMail.text;
    NSLog(@"用户注册的email为：%@",self.eMail);
    self.passWord = _textPassword.text;
    NSLog(@"用户注册的password为：%@",self.passWord);

    if (![self.userName isEqualToString:@""]&&![self.eMail isEqualToString:@""]&&![self.passWord isEqualToString:@""]) {
        
//            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            hud.label.text = @"Registration Successful";

    //添加进入数据库
    Login *user = [NSEntityDescription insertNewObjectForEntityForName:@"Login" inManagedObjectContext:_context];
    
    user.name = self.userName;
    user.password = self.passWord;
    user.email = self.eMail;
    NSError *error = nil;
    
    BOOL isok = [_context save:&error];
    
    if (isok) {
        NSLog(@"注册成功");
    }else
        NSLog(@"注册失败");
      
        
        AppDelegate *app =[[UIApplication sharedApplication] delegate];
        
        app.isLogin = YES;
     [[[[UIApplication sharedApplication] delegate] window] setRootViewController:[[MainNavigationControllerViewController alloc]initWithRootViewController:[[HomeViewCtroller alloc]init]]];
    
//    [CoreLaunchCool animWithWindow:[[UIApplication sharedApplication] delegate].window image:[UIImage imageNamed:@"skinBackImage_7.jpg"]];
        
    }

    }
    else if (btn.tag==201){
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:[[MainNavigationControllerViewController alloc]initWithRootViewController:[[HomeViewCtroller alloc]init]]];
        
//        [CoreLaunchCool animWithWindow:[[UIApplication sharedApplication] delegate].window image:[UIImage imageNamed:@"skinBackImage_7.jpg"]];
       
    }
    
}


//结束编辑
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    
//    if (textField.tag==100) {
//        self.userName = textField.text;
//        NSLog(@"用户注册的名字为：%@",self.userName);
//    }
//    else if (textField.tag==101) {
//        self.eMail = textField.text;
//        NSLog(@"用户注册的email为：%@",self.userName);
//    }
//    else if (textField.tag==102) {
//        self.passWord = textField.text;
//        NSLog(@"用户注册的password为：%@",self.userName);
//    }
//
//    NSLog(@"textFiled结束编辑");
//}

//点击return执行
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
        NSLog(@"========");
    //注销第一响应者,隐藏键盘
    [textField resignFirstResponder];
    return YES;
}

//限定输入长度
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if (range.location>20) {
//        return NO;
//    }
//    else return YES;
//}

- (void)textFieldDidChange:(UITextField *)textField
{
    
        if (textField.text.length > 19) {
            textField.text = [textField.text substringToIndex:19];
        }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)LowImg{
    UILabel *lab= [[UILabel alloc]init];
    [lab setfram:CGRectMake(LFScreenW/2-40, LFScreenH-40, 80, 20) text:@"©2016 Tetris" color:[UIColor whiteColor] font:12];
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
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
