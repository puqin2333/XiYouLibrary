//
//  CCBorrwController.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/1/10.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "CCBorrwController.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "YYModel.h"
#import "CCJSONModel.h"
#import "CCTableViewCell.h"
#import "FeHandwritingViewController.h"
#import "CCBookDetailController.h"

#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height
long m = 0;
long n = 0;
@interface CCBorrwController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, retain) NSArray *array;

@end

@implementation CCBorrwController

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
        
        UIView *view = [UIView new];
        [self.tableView addSubview:view];
        view.frame = CGRectMake(64, 0, kCCDeviceWidth, kCCDeviceHeight * 0.2);
        UILabel *titleLabel = [[UILabel alloc] init];
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(view.mas_top);
            make.height.mas_equalTo(kCCDeviceHeight * 0.05);
            make.width.mas_equalTo(kCCDeviceWidth );
            make.left.equalTo(view.mas_left).with.offset(20);
        }];
        NSString *rented = [NSString stringWithFormat:@"已借图书： %lu本",(unsigned long)_array.count];
        titleLabel.text = rented;
        UILabel *titleLabel1 = [[UILabel alloc] init];
        [view addSubview:titleLabel1];
        [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(titleLabel.mas_bottom);
            make.height.mas_equalTo(kCCDeviceHeight * 0.05);
            make.width.mas_equalTo(kCCDeviceWidth );
            make.left.equalTo(view.mas_left).with.offset(20);
        }];
        long int a = 15 - (unsigned long)_array.count;
        NSString *canrent = [NSString stringWithFormat:@"剩余可借： %ld本",a];
        titleLabel1.text = canrent;
        UILabel *titleLabel2 = [[UILabel alloc] init];
        [view addSubview:titleLabel2];
        [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(titleLabel1.mas_bottom);
            make.height.mas_equalTo(kCCDeviceHeight * 0.05);
            make.width.mas_equalTo(kCCDeviceWidth * 0.9);
            make.left.equalTo(view.mas_left).with.offset(20);
        }];
        NSString *rent = [NSString stringWithFormat:@"续借图书： %ld本",m];
        titleLabel2.text = rent;
        UILabel *titleLabel3 = [[UILabel alloc] init];
        [view addSubview:titleLabel3];
        [titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(titleLabel2.mas_bottom);
            make.height.mas_equalTo(kCCDeviceHeight * 0.05);
            make.width.mas_equalTo(kCCDeviceWidth * 0.9);
            make.left.equalTo(view.mas_left).with.offset(20);
        }];
        NSString *didrent = [NSString stringWithFormat:@"超期图书： %ld本",n];

        titleLabel3.text = didrent;
        
        self.tableView.tableHeaderView = view;
    }
    return _tableView;
}

- (void)viewDidLoad
{
    [self showAnimation];
    [super viewDidLoad];
    self.navigationItem.title = @"我的借阅";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回-白色.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];  
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self obtainData];
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(load) userInfo:nil repeats:YES];
}

- (void)showAnimation{
    FeHandwritingViewController *vc = [[FeHandwritingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)load{
    
    if (![_array  isEqual: @"NO_RECORD"]) {
        [self tableView];
    }
    else{
        UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有借阅记录" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alView show];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)obtainData{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *domainStr = @"https://api.xiyoumobile.com/xiyoulibv2/user/rent";
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        NSString *str = [NSString stringWithFormat:@"分馆：%@",model.Department];
        typeLabel.text = str;
        typeLabel.font = [UIFont systemFontOfSize:12];
        
        UILabel *dateLabel = [[UILabel alloc] init];
        [cell.contentView addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(imageView.mas_right).with.offset(20);
            make.top.equalTo(typeLabel.mas_bottom).with.offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(kCCDeviceWidth * 0.7);
        }];
        NSString *str1 = [NSString stringWithFormat:@"到期时间：%@",model.Date];
        dateLabel.text = str1;
        dateLabel.font = [UIFont systemFontOfSize:13];
        
        UILabel *numberLabel = [[UILabel alloc] init];
        [cell.contentView addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(imageView.mas_right).with.offset(20);
            make.top.equalTo(dateLabel.mas_bottom).with.offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(kCCDeviceWidth * 0.7);
        }];
        
        NSString *str2 = [NSString stringWithFormat:@"状态：%@",model.State];
        numberLabel.text = str2;
        numberLabel.textColor = [UIColor colorWithRed:154.0/255.0 green:217.0/255.0 blue:87.0/255.0 alpha:1.0];
        numberLabel.font = [UIFont systemFontOfSize:13];

    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CCJSONModel *model = [CCJSONModel yy_modelWithDictionary:self.array[indexPath.row]];
    CCBookDetailController *bookVC = [[CCBookDetailController alloc]init];
    bookVC.Barcode = model.Barcode;
    bookVC.ID = nil;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bookVC animated:NO];
}
@end
