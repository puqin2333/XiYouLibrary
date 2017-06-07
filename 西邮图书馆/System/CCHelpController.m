//
//  CCHelpController.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/1/10.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "CCHelpController.h"
#import "Masonry.h"
#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height

@interface CCHelpController ()

@end

@implementation CCHelpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"常见问题";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回-白色.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];  
    UIView *view = [[UIView alloc] init];
    [self.view addSubview:view];
    view.layer.cornerRadius = 3.0;
    [view mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(self.view.mas_left).with.offset(10);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
        make.height.mas_equalTo(kCCDeviceHeight*0.1);
    }];
    view.layer.cornerRadius = 3.0;
    view.backgroundColor = [UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_top).with.offset(5);
        make.width.mas_equalTo(view.mas_width);
        make.height.mas_equalTo(kCCDeviceHeight * 0.05);
    }];
    label.text = @"1.登录时的学号和密码都是什么？";
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentLeft;
    UILabel *label1 = [[UILabel alloc] init];
    [view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(label.mas_bottom).with.offset(-5);
        make.width.mas_equalTo(view.mas_width);
        make.height.mas_equalTo(kCCDeviceHeight * 0.05);
    }];
    label1.text = @" 学号一般为自己的学号，初时密码为学号后六位";
    label1.font = [UIFont systemFontOfSize:13];
    
    UIView *view1 = [[UIView alloc] init];
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(view.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.view.mas_left).with.offset(10);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
        make.height.mas_equalTo(kCCDeviceHeight*0.13);
    }];
    view1.layer.cornerRadius = 3.0;
    view1.backgroundColor = [UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1];
    UILabel *label2 = [[UILabel alloc] init];
    [view1 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(view1.mas_centerX);
        make.top.mas_equalTo(view1.mas_top).with.offset(5);
        make.width.mas_equalTo(view1.mas_width);
        make.height.mas_equalTo(kCCDeviceHeight * 0.05);
    }];
    label2.text = @"2.登录时的学号和密码都是什么？";
    label2.font = [UIFont systemFontOfSize:13];
    label2.textAlignment = NSTextAlignmentLeft;
    UILabel *label3 = [[UILabel alloc] init];
    [view1 addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(view1.mas_centerX);
        make.top.mas_equalTo(label2.mas_bottom).with.offset(-5);
        make.width.mas_equalTo(view1.mas_width);
        make.height.mas_equalTo(kCCDeviceHeight * 0.08);
    }];
    label3.text = @"  学号一般为自己的学号，初时密码为学号后六位";
    label3.font = [UIFont systemFontOfSize:13];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickLeftBtn
{
    [self.navigationController popViewControllerAnimated:NO];
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
