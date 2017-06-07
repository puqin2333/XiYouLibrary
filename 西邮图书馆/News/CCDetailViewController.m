//
//  CCDetailViewController.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/2/5.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "CCDetailViewController.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "CCJSONModel.h"
#import "YYModel.h"
#import "NSString+Extension.h"
#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height
#define CCTextFont [UIFont systemFontOfSize:20]

@interface CCDetailViewController ()

@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)UILabel *dateLabel;
@property(strong,nonatomic)UILabel *publishLabel;
@property(strong,nonatomic)NSString *titlestr;
@property(strong,nonatomic)NSString *datestr;
@property(strong,nonatomic)NSString *passagestr;
@property(strong,nonatomic)NSString *publishstr;
@property(strong,nonatomic)UIImageView *LoadView;
@property(strong,nonatomic)UIWebView *webView;
@property(assign,nonatomic)CGFloat webViewheight;

@end

@implementation CCDetailViewController

- (UIWebView *)webView{
    if(!_webView){
        CGRect bounds = [[UIScreen mainScreen] applicationFrame];
        self.webView = [[UIWebView alloc] initWithFrame:bounds];
        self.webView.scalesPageToFit = YES;
        [self.view addSubview:self.webView];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
