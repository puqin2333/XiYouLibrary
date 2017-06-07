//
//  CCDetailController.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/1/9.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "CCDetailController.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "CCJSONModel.h"
#import "YYModel.h"
#import "NSString+Extension.h"
#import "FeHandwritingViewController.h"
#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height
#define CCTextFont [UIFont systemFontOfSize:20]


@interface CCDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) UILabel *titlelabel;
@property(nonatomic, strong) UILabel *datelabel;
@property(nonatomic, strong) UILabel *publishLabel;
@property(nonatomic, strong) UIScrollView *scollView;
@property(nonatomic, retain) NSDictionary *dict;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation CCDetailController


- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] init];
        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(kCCDeviceWidth );
            make.height.mas_equalTo(kCCDeviceHeight - 64);
        }];
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        _tableView.allowsSelection = NO;
        
        CGSize textMaxSize = CGSizeMake(400 , MAXFLOAT);
        CGSize textRealSize = [_dict[@"Title"] sizeWithFont:CCTextFont maxSize:textMaxSize];
        CGSize textRealSize1 = [_dict[@"Passage"] sizeWithFont:CCTextFont maxSize:textMaxSize];
        self.tableView.rowHeight = textRealSize1.height;
        UIView *view = [UIView new];
        [self.tableView addSubview:view];
        [view addSubview:self.titlelabel];
        view.frame = CGRectMake(64, 0, kCCDeviceWidth, 80);
        self.titlelabel = [[UILabel alloc] init];
        self.titlelabel.frame = CGRectMake(40, 20, kCCDeviceWidth - 80, textRealSize.height);
        self.titlelabel.text = _dict[@"Title"];
        self.titlelabel.textAlignment = NSTextAlignmentCenter;
        self.titlelabel.numberOfLines = 0;
        view.backgroundColor = [UIColor whiteColor];
        [view addSubview:self.titlelabel];
        self.tableView.tableHeaderView = view;
        
        UIView *view1 = [[UIView alloc] init];
        [self.tableView addSubview:view1];
        view1.frame = CGRectMake(0, 0, kCCDeviceWidth, 100);
        view1.backgroundColor = [UIColor whiteColor];
        self.publishLabel = [[UILabel alloc] init];
        [view1 addSubview:self.publishLabel];
        [self.publishLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(view1.mas_right).offset(0);
            make.top.equalTo(view1.mas_top).offset(0);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(200);
        }];
        NSString *str = [NSString stringWithFormat:@"发布单位：%@",_dict[@"Publisher"]];
        self.publishLabel.text = str;
        
        self.datelabel = [[UILabel alloc] init];
        [view1 addSubview:self.datelabel];
        [self.datelabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(view1.mas_right).offset(0);
            make.top.equalTo(self.publishLabel.mas_bottom).offset(0);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(200);
        }];
        NSString *str1 = [NSString stringWithFormat:@"发布日期：%@",_dict[@"Date"]];
        self.datelabel.text = str1;

        
        self.tableView.tableFooterView = view1;

        
        }
    
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showAnimation];
    self.navigationItem.title = @"详情";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回-白色.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [self obtainData];
    //[self tableView];
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(tableView) userInfo:nil repeats:YES];
    //[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(textLabel) userInfo:nil repeats:YES];
    
}

- (void)showAnimation{
    FeHandwritingViewController *vc = [[FeHandwritingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickLeftBtn
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)obtainData{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *domainStr = [NSString stringWithFormat:@"https://api.xiyoumobile.com/xiyoulibv2/news/getDetail/%@/text/%@",_type,_ID ];
    NSURL *URL = [NSURL URLWithString:domainStr];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *dict = responseObject[@"Detail"];
        NSLog(@"%@",dict);
        self.dict = dict;

        
        } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    CGSize textMaxSize1 = CGSizeMake(400, MAXFLOAT);
    CGSize textRealSize1 = [_dict[@"Passage"] sizeWithFont:CCTextFont maxSize:textMaxSize1];
    self.textLabel = [[UILabel alloc] init];
    [cell addSubview:self.textLabel];
    self.textLabel.frame = CGRectMake(20, 0, kCCDeviceWidth - 40, textRealSize1.height);
    self.textLabel.text = _dict[@"Passage"];
    self.textLabel.numberOfLines = 0;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}


@end
