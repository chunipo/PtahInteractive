//
//  InRegister.m
//  PtahInteractive
//
//  Created by ptah on 16/8/18.
//  Copyright © 2016年 Ptah. All rights reserved.
//

#import "InRegister.h"


#
#import "CoreLaunchCool.h"
#import "TeriManerger.h"
#import "Login.h"
#import "AppDelegate.h"

@interface InRegister ()<UITextFieldDelegate>

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

@implementation InRegister

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    
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
    [_back setfram:CGRectMake(LFScreenW/2-LFScreenW/3, LFScreenH/3, LFScreenW*2/3, 120) image:@"" useinterface:YES];
    
    _back.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_back];
    
    
    //注册
    
    
    _textName = [[UITextField alloc]initWithFrame:CGRectMake(30, 0, _back.width-30, 40)];
    _textName.borderStyle = UITextBorderStyleRoundedRect;
    //  _textName.backgroundColor = [UIColor clearColor];
    _textName.font = [UIFont fontWithName:@"Arial" size:15];
    _textName.layer.cornerRadius = 15;
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
    _texteMail = [[UITextField alloc]initWithFrame:CGRectMake(30, 40, _back.width-30, 40)];
    _texteMail.borderStyle = UITextBorderStyleRoundedRect;
    // text.backgroundColor = [UIColor clearColor];
    _texteMail.font = [UIFont fontWithName:@"Arial" size:15];
    _texteMail.layer.cornerRadius = 15;
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
    _textPassword = [[UITextField alloc]initWithFrame:CGRectMake(30, 80, _back.width-30, 40)];
    _textPassword.borderStyle = UITextBorderStyleRoundedRect;
    // text.backgroundColor = [UIColor clearColor];
    _textPassword.font = [UIFont fontWithName:@"Arial" size:15];
    _textPassword.layer.cornerRadius = 15;
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
    
    
    
    
    
    //注册后
    UIButton *registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(_back.x, _back.maxY+20,LFScreenW*2/3, 20)];
    
    [registerBtn setTitle:@"register" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(reigister:) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.tag = 200;
    [self.view addSubview:registerBtn];
    
    //未注册
    
    UIButton *goBtn = [[UIButton alloc]initWithFrame:CGRectMake(_back.x, _back.maxY+100,LFScreenW*2/3, 20)];
    
    [goBtn setTitle:@"go" forState:UIControlStateNormal];
    [goBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [goBtn addTarget:self action:@selector(reigister:) forControlEvents:UIControlEventTouchUpInside];
    goBtn.tag=201;
    [self.view addSubview:goBtn];
    
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
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }
    else if (btn.tag==201){
        [self dismissViewControllerAnimated:YES completion:nil];
        
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
