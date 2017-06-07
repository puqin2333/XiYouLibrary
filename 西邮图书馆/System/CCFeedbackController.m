//
//  CCFeedbackController.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/1/10.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "CCFeedbackController.h"
#import "Masonry.h"
#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height

@interface CCFeedbackController ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView   *mytextView;
@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation CCFeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"问题反馈";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    self.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回-白色.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];  
    
    
    self.mytextView = [[UITextView alloc] init];
    [self.view addSubview:self.mytextView];
    [self.mytextView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.view.mas_top).with.offset(10);
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        make.height.mas_equalTo(kCCDeviceHeight * 0.3);
    }];
    self.mytextView.font = [UIFont systemFontOfSize:15];
    _mytextView.delegate = self;
    self.mytextView.textAlignment = NSTextAlignmentLeft;
    self.mytextView.layer.cornerRadius = 5.0;
    
    _mytextView.backgroundColor = [UIColor whiteColor];
        
    self.placeHolderLabel = [[UILabel alloc] init];
    [self.view addSubview:_placeHolderLabel];
    [self.placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.mytextView.mas_top).with.offset(10);
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        make.height.mas_equalTo(kCCDeviceHeight * 0.05);
    }];
    self.placeHolderLabel.text = @"请输入遇到的问题或建议。。。";
    self.placeHolderLabel.font = [UIFont systemFontOfSize:15];
    self.placeHolderLabel.textColor = [UIColor lightGrayColor];
        
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
        
    [self.view addGestureRecognizer:tap];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.mytextView.mas_bottom).with.offset(kCCDeviceHeight * 0.03);
        make.left.mas_equalTo(self.view.mas_left).with.offset(10);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
        make.height.mas_equalTo(kCCDeviceHeight * 0.07);
    }];
    button.backgroundColor = [UIColor colorWithRed:87.0/255 green:164.0/255 blue:223.0/255.0 alpha:255.0/225.0];
    button.layer.cornerRadius = 5;
    [button setTitle:@"提 交" forState:UIControlStateNormal];
    button. titleLabel.font = [UIFont systemFontOfSize: 25];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickBtn{
    [self.mytextView resignFirstResponder];
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"发送成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yesAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:yesAction];
    [self presentViewController:alertController animated:YES completion:nil];

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
- (void)clickLeftBtn
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)tapView
{
    [self.view endEditing:YES];
    if(self.mytextView.text.length == 0){
        self.placeHolderLabel.hidden = NO;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length != 0){
        self.placeHolderLabel.hidden = YES;
    }
}

@end
