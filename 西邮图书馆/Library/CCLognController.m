//
//  CCLognController.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/1/11.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "CCLognController.h"
#import "CCLibraryController.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height
@interface CCLognController ()<UITextFieldDelegate>
@property(nonatomic ,strong) UITextField *username,*password;
@property(nonatomic, strong) UIButton *loginButton;
@property(nonatomic,copy) NSString *Session;
@property(strong,nonatomic) UIActivityIndicatorView *activityindicatorView;
@end

@implementation CCLognController

- (void) click: (id) sender
{
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
}
- (void)clickLeftBtn
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSString *ID=[userDefaults objectForKey:@"username"];

    self.navigationItem.title = @"西邮图书馆";
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255 green:240./255 blue:240.0/255.0 alpha:255/255.0];
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回-白色.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];  
    self.username = [[UITextField alloc] init];
    [self.view addSubview:self.username];
    [self.username mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.view.mas_top).with.offset(80);
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.height.mas_equalTo(60);
    }];
    _username.borderStyle = UITextBorderStyleRoundedRect;
    _username.textAlignment = NSTextAlignmentLeft;
    _username.returnKeyType = UIReturnKeyDone;
    _username.delegate = self;
    _username.backgroundColor = [UIColor whiteColor];
    _username.placeholder = @"账号";
    _username.text = ID;

    self.password = [[UITextField alloc] init];
    [self.view addSubview:self.password];
    [self.password mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.username.mas_bottom).with.offset(6);
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.height.mas_equalTo(60);
    }];
    _password.borderStyle = UITextBorderStyleRoundedRect;
    _password.textAlignment = NSTextAlignmentLeft;
    _password.returnKeyType = UIReturnKeyDone;
    _password.backgroundColor = [UIColor whiteColor];
    _password.placeholder = @"密码";
    _password.secureTextEntry = YES;
    _password.clearsOnBeginEditing = YES;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.password.mas_bottom).with.offset(60);
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        make.height.mas_equalTo(self.view.bounds.size.height * 0.08);
    }];
    button.layer.cornerRadius = 5.0f;
    button.backgroundColor = [UIColor colorWithRed:84.0/255 green:181.0/255 blue:239.0/255.0 alpha:255.0/225.0];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pressLogin) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderWidth = 1;
    button.layer.borderColor = [[UIColor whiteColor] CGColor];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    self.loginButton = button;
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.top.equalTo(self.password.mas_bottom).with.offset(15);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(15);
    }];
    [button1 setImage:[UIImage imageNamed:@"checkbox_unchecked"] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"checkbox_checked"] forState:UIControlStateSelected];
    [button1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(button1.mas_right).with.offset(12);
        make.top.equalTo(self.password.mas_bottom).with.offset(15);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(150);
    }];
    label.text = @"自动登录";
    label.font = [UIFont systemFontOfSize:15];
    
    
    UILabel *label1 = [[UILabel alloc] init];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.top.equalTo(self.password.mas_bottom).with.offset(15);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(100);
    }];
    label1.text = @"记住密码";
    label1.font = [UIFont systemFontOfSize:15];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(label1.mas_left).with.offset(-12);
        make.top.equalTo(self.password.mas_bottom).with.offset(15);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(15);
    }];
    [button2 setImage:[UIImage imageNamed:@"checkbox_unchecked"] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"checkbox_checked"] forState:UIControlStateSelected];
    [button2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self setactivityindicatorView];
}

- (void)setactivityindicatorView{
    self.activityindicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityindicatorView.hidesWhenStopped=YES;
    self.activityindicatorView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:self.activityindicatorView];
    [self.activityindicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kCCDeviceWidth*0.2, kCCDeviceWidth*0.1));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_username resignFirstResponder];
    [_password resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_username resignFirstResponder];
    [_password resignFirstResponder];
    return YES;
}

- (void)click{
    NSUserDefaults
    *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:_password.text forKey:@"password"];
     [userDefaults synchronize];

}

- (void)pressLogin
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    
    NSString* textName = _username.text;
    NSString* textKey = _password.text;
    
//    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
//    NSString *ID=[userDefaults objectForKey:@"username"];
    
    if([textName isEqualToString:@""]||[textKey isEqualToString:@""]){
        
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或密码不能为空！" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alView show];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = textName;
    params[@"password"] = textKey;
    NSURL *url = [NSURL URLWithString:@"https://api.xiyoumobile.com/xiyoulibv2/user/login"];
    [manager POST:url.absoluteString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        self.Session =[NSString stringWithFormat:@"%@",responseObject[@"Detail"]];
        id value=[responseObject objectForKey:@"Result"];
        [self login:self.Session and:[value boolValue]];
        if(![responseObject[@"Detail"] isEqualToString:@"ACCOUNT_ERROR"]){
            
//            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录成功！" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
//            [alView show];
            NSUserDefaults
            *userDefaults = [NSUserDefaults standardUserDefaults];
            
            //登陆成功后把用户名和密码存储到UserDefault
            [userDefaults
             setObject:_username.text forKey:@"username"];
             [userDefaults synchronize];
            AppDelegate *Delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
            Delegate.islogin=YES;

           [self performSelector:@selector(changeToMainView) withObject:self afterDelay:2];
        }
        else{
            UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"验证失败，用户名或密码错误！" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alView show];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"验证失败，用户名或密码错误！" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alView show];

        
        NSLog(@"%@",error);
        
    }];
}

- (void)login:(NSString *)session and:(BOOL)result{
    if (result==YES) {
        AppDelegate *Delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        Delegate.islogin=YES;
        Delegate.Session = self.Session;
    }
    else{
        
        self.password.text = nil;
    }
}

- (void)changeToMainView{
    [self.delegate loginSuccess:self.Session];
    [self.navigationController popViewControllerAnimated:NO];
}

@end
