//
//  CCListController.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/1/10.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "CCListController.h"
#import "AFNetworking.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "CCJSONModel.h"
#import "YYModel.h"
#import "CCBookDetailController.h"
#import "FeHandwritingViewController.h"

#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height
int count = 10 ;
@interface CCListController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, retain) NSMutableArray *array;
@property(nonatomic, retain) NSDictionary *dict;

@end

@implementation CCListController

- (UITableView *)tableView
{
    if(!_tableView){
        self.tableView = [[UITableView alloc] init];
        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.view.mas_top);
            make.bottom.equalTo(self.view.mas_bottom).with.offset(44);
            make.left.equalTo(self.view.mas_left).with.offset(5);
            make.right.equalTo(self.view.mas_right).with.offset(-5);
        }];
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = kCCDeviceHeight*0.1;
        
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        
        [_tableView setShowsHorizontalScrollIndicator:YES];
        
        NSString * cellReuseIdentifier = NSStringFromClass([UITableViewCell class]);
        
        [_tableView registerClass: NSClassFromString(cellReuseIdentifier) forCellReuseIdentifier:cellReuseIdentifier];
        
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            count = 0;
            [self updateData];
        }];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self updateData];
        }];

    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showAnimation];
    self.navigationItem.title = @"排行榜";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回-白色.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];  
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableView];
}

- (void)showAnimation{
    FeHandwritingViewController *vc = [[FeHandwritingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickLeftBtn
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return count += 15;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
    else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *) [cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    CCJSONModel *model = [CCJSONModel yy_modelWithDictionary:self.array[indexPath.row]];
    NSString *string = [NSString stringWithFormat: @"《%@》",model.Title];
    cell.layer.cornerRadius = 4.0f;
    cell.backgroundColor = [UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:255.0/255];
    
    cell.textLabel.text = string;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    NSString *str = [NSString stringWithFormat: @"  浏览次数：%@",model.BorNum];
    cell.detailTextLabel.text = str;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCJSONModel *model = [CCJSONModel yy_modelWithDictionary:self.array[indexPath.row]];
    CCBookDetailController * postVC = [[CCBookDetailController alloc] init];
    //CCBookController * postVC = [[CCBookController alloc] init];
    postVC.ID = model.ID;
    NSLog(@"%@",model.ID);
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:postVC animated:NO];
    self.hidesBottomBarWhenPushed = NO;
    
}
#pragma MJRefresh --mark

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}

//更新视图
- (void) updateView
{
    [self.tableView reloadData];
}

//停止刷新

-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)updateData
{

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *domainStr = @"https://api.xiyoumobile.com/xiyoulibv2/book/rank";
    NSURL *URL = [NSURL URLWithString:domainStr];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //NSString *str = [NSString stringWithFormat:@"%d0",count++];
    params[@"size"] = @"100";

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        [self endRefresh];
        NSLog(@"%@",responseObject);
        NSArray *arr = responseObject[@"Detail"];
        self.array = [NSMutableArray arrayWithArray:arr];
        [self updateView];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self endRefresh];
    }];
}



@end
