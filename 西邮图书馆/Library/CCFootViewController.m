//
//  CCFootViewController.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/1/10.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "CCFootViewController.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "YYModel.h"
#import "CCJSONModel.h"
#import "CCTableViewCell.h"
#import "FeHandwritingViewController.h"
#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height

@interface CCFootViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, retain) NSArray *array;

@end

@implementation CCFootViewController

- (UITableView *)tableView{
    if(!_tableView){
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kCCDeviceWidth, kCCDeviceHeight ) style:UITableViewStylePlain];
        [self.view addSubview: self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.rowHeight = kCCDeviceHeight * 0.19;
        
        NSString * cellReuseIdentifier = NSStringFromClass([UITableViewCell class]);
        
        [_tableView registerClass: NSClassFromString(cellReuseIdentifier) forCellReuseIdentifier:cellReuseIdentifier];
    }
    return _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showAnimation];
    self.navigationItem.title = @"我的足迹";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回-白色.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];  
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self obtainData];
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(tableView) userInfo:nil repeats:YES];
    
}

- (void)showAnimation{
    FeHandwritingViewController *vc = [[FeHandwritingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)obtainData{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *domainStr = @"https://api.xiyoumobile.com/xiyoulibv2/user/history";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"session"] = self.Session;
    NSURL *URL = [NSURL URLWithString:domainStr];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        _array = responseObject[@"Detail"];
        
        NSLog(@"%@",_array);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


- (void)clickLeftBtn
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    CCJSONModel *model = [CCJSONModel yy_modelWithDictionary:self.array[indexPath.row]];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:  UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        UIImageView *imageView = [[UIImageView alloc] init];
        [cell.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(cell.contentView.mas_left).with.offset(20);
            make.top.equalTo(cell.contentView.mas_top).with.offset(10);
            make.bottom.equalTo(cell.contentView.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(kCCDeviceWidth * 0.23);
        }];
        imageView.image = [UIImage imageNamed:@"background-1"];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [cell.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(imageView.mas_right).with.offset(20);
            make.top.equalTo(cell.contentView.mas_top).with.offset(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(kCCDeviceWidth * 0.7);
        }];
        titleLabel.text = model.Title;
        titleLabel.font = [UIFont systemFontOfSize:15];
        
        UILabel *typeLabel = [[UILabel alloc] init];
        [cell.contentView addSubview:typeLabel];
        [typeLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(imageView.mas_right).with.offset(20);
            make.top.equalTo(titleLabel.mas_bottom).with.offset(0);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(kCCDeviceWidth * 0.7);
        }];
        NSString *str = [NSString stringWithFormat:@"操作类型：%@",model.Type];
        typeLabel.text = str;
        typeLabel.font = [UIFont systemFontOfSize:13];
        
        UILabel *dateLabel = [[UILabel alloc] init];
        [cell.contentView addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(imageView.mas_right).with.offset(20);
            make.top.equalTo(typeLabel.mas_bottom).with.offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(kCCDeviceWidth * 0.7);
        }];
        NSString *str1 = [NSString stringWithFormat:@"操作日期：%@",model.Date];
        dateLabel.text = str1;
        dateLabel.font = [UIFont systemFontOfSize:13];
        
        UILabel *numberLabel = [[UILabel alloc] init];
        [cell.contentView addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(imageView.mas_right).with.offset(20);
            make.top.equalTo(dateLabel.mas_bottom).with.offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(kCCDeviceWidth * 0.69);
        }];
        NSString *str2 = [NSString stringWithFormat:@"索书号：%@",model.Barcode];
        numberLabel.text = str2;
        numberLabel.font = [UIFont systemFontOfSize:13];
        
    }
    return cell;
}

@end
