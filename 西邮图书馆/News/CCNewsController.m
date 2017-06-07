//
//  CCNewsController.m
//  
//
//  Created by 陈普钦 on 16/11/14.
//
//

#import "CCNewsController.h"
#import "ViewController.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "CCJSONModel.h"
#import "YYModel.h"
#import "NSString+Extension.h"
#import "CCDetailController.h"
#import "CCSearchController.h"
#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height
#define CCTextFont [UIFont systemFontOfSize:20]

int currentPage = 1;

@interface CCNewsController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) UISegmentedControl *segmentedControl;
@property(nonatomic, strong) UIScrollView *scollView;
@property(nonatomic, strong) UIPageControl *pageControll;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, retain) NSArray *coverList;
@property(nonatomic, retain) NSMutableArray *viewControllers;

@property(nonatomic, retain) NSMutableArray *newsData;
@property(nonatomic, copy) NSString *newsTitle;
@property(nonatomic, assign) NSNumber *ID;
@property(nonatomic, assign) NSNumber *total;
@property(nonatomic, assign) NSNumber *pages;
@property (assign, nonatomic) NSMutableArray *anounceData;

@end

@implementation CCNewsController

- (UIScrollView *)scollView
{
    if(!_scollView){
        _scollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width,self.view.bounds.size.height * 0.25)];
        _scollView.pagingEnabled = YES;
        _scollView.contentSize = CGSizeMake(_scollView.frame.size.width * 3, _scollView.frame.size.height);
        _scollView.showsHorizontalScrollIndicator = NO;
        _scollView.showsVerticalScrollIndicator = NO;
        _scollView.scrollsToTop = YES;
        [self.view addSubview:_scollView];
    }
    return _scollView;
}

- (UIPageControl *) myPageControl
{
    if (!_pageControll) {
        //创建UIPageControl控件
        _pageControll = [[UIPageControl alloc] init];
        _pageControll.frame = CGRectMake(0, self.view.bounds.size.height * 0.09 + 64, _scollView.frame.size.width, self.view.bounds.size.height *0.3);
        _pageControll.currentPageIndicatorTintColor = [UIColor blackColor];
        _pageControll.currentPage = 0;
        _pageControll.numberOfPages = _coverList.count;
        [self.view addSubview:_pageControll];
    }
    return _pageControll;
}
- (UITableView *)tableView{
    if(!_tableView){
        self.tableView = [[UITableView alloc] init];
        [self.view addSubview: _tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
            make.height.mas_equalTo(kCCDeviceHeight * 0.52);
            make.left.equalTo(self.view.mas_left).with.offset(3);
            make.right.equalTo(self.view.mas_right).with.offset(-3);
            make.top.equalTo(self.segmentedControl.mas_bottom).with.offset(2);
        }];
        _tableView.rowHeight = kCCDeviceHeight * 0.09;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        
        [_tableView setShowsHorizontalScrollIndicator:YES];
        
        NSString * cellReuseIdentifier = NSStringFromClass([UITableViewCell class]);
        
        [_tableView registerClass: NSClassFromString(cellReuseIdentifier) forCellReuseIdentifier:cellReuseIdentifier];
        
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            currentPage = 0;
            [self updateData];
        }];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self updateData];
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self obtainData];
    
    self.navigationItem.title = @"西邮图书馆";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    //这是在 tabBarItem 放的图片
    UIImage *images = [UIImage imageNamed:@"comments"];
    //将图片设置为不会进行自动渲染，这样就解决图片渲染的问题了
    UIImage *selectedImage = [images imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"公告" image:selectedImage tag:0];
    //对于文字被渲染成蓝色，我们可以通过富文本来解决
    //设置普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    //设置选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [self.tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:84.0/255 green:181.0/255 blue:239.0/255.0 alpha:255.0/225.0];
    UIBarButtonItem *rightbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBtn)];
    self.navigationItem.rightBarButtonItem = rightbtn;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];  
    //设置图片轮播器
    //程序采用懒加载的方式来创建pageController控制器
    //因此此处只向数组中添加一些null作为占位符
    //等到程序需要时才真正创建pageViewcontroller
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width,self.view.bounds.size.height * 0.25)];
    [self.view addSubview:view];

    
    self.coverList = @[@"1.jpg",@"2.jpg",@"1.jpg"];
    self.viewControllers = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < _coverList.count; i++) {
        [self.viewControllers addObject:[NSNull null]];
    }
    [self scollView];
    NSLog(@"%@",self.total);
    view = _scollView;
    [self myPageControl];
    
    [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(change) userInfo:nil repeats:YES];
    
    //初始化默认加载第一页
    [self loadScrollViewWithPage:0];
    //避免翻页时才加载下一页，同时把下一页的内容也加载出来
    [self loadScrollViewWithPage:1];
    
    //设置segemented
    NSArray *array = [[NSArray alloc] initWithObjects:@"1", @"2" ,nil];
    int height = kCCDeviceHeight * 0.065;
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:array];
    [self.view addSubview:self.segmentedControl];
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.mas_equalTo(height);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(view.mas_bottom).with.offset(1);
    }];
    self.segmentedControl.backgroundColor = [UIColor colorWithRed:87.0/255 green:164.0/255 blue:223.0/255.0 alpha:225.0/225.0];
    UIFont *font = [UIFont boldSystemFontOfSize:20];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
    [self.segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    self.segmentedControl.tintColor = [UIColor whiteColor];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl setTitle:@"公告" forSegmentAtIndex:0];
    [self.segmentedControl setTitle:@"新闻" forSegmentAtIndex:1];
    [self.segmentedControl addTarget:self action:@selector(click:) forControlEvents:UIControlEventValueChanged];
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(tableView) userInfo:nil repeats:YES];
    [self updateData];
}

- (void)clickRightBtn
{
    self.hidesBottomBarWhenPushed = YES;
    CCSearchController *search = [[CCSearchController alloc] init];
    [self.navigationController pushViewController:search animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}

- (void) click:(UISegmentedControl *)sender
{
    
    switch (_segmentedControl.selectedSegmentIndex) {
        case 0:
            [self  updateData];
            break;
        case 1:
            [self updateData];
            break;
        default:
            break;
    }
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
    NSString *domainStr = [NSString new];
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        domainStr = [NSString stringWithFormat:@"https://api.xiyoumobile.com/xiyoulibv2/news/getList/news/%d",currentPage++];
    }
    else{
        domainStr = [NSString stringWithFormat:@"https://api.xiyoumobile.com/xiyoulibv2/news/getList/announce/%d",currentPage++];
    }
    NSURL *URL = [NSURL URLWithString:domainStr];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        [self endRefresh];
        NSDictionary *DetailDict = responseObject[@"Detail"];
        self.total = DetailDict[@"Amount"];
        self.newsData = DetailDict[@"Data"];
        [self updateView];

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self endRefresh];
    }];
}

# pragma 图片轮播器
- (void) loadScrollViewWithPage: (NSUInteger) page
{
    //如果超出总页数，直接返回
    if (page >= self.coverList.count) {
        return;
    }
    //获取page索引处的页面
    ViewController *controller = self.viewControllers[page];
    //如果page索引处的页面为空，就初始化
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[ViewController alloc] initwithPageNumber:page];
        //用pageview对象代替原来的对象
        [self.viewControllers replaceObjectAtIndex:page withObject:controller];
        
    }
    if (controller.view.superview == nil) {
        CGRect frame = self.scollView.frame;
        frame.origin.x = CGRectGetWidth(frame) *page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        controller.imageView.image = [UIImage imageNamed:self.coverList[page]];
        [self addChildViewController:controller];
        [self.scollView addSubview:controller.view];
    }
}

- (void) changePage:(NSInteger)page
{
    CGRect bounds = self.scollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * page;
    bounds.origin.y = 0;
    [self.scollView scrollRectToVisible:bounds animated:YES];
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
}

- (void) change
{
    if(self.pageControll.currentPage <  _coverList.count - 1){
        self.pageControll.currentPage = _pageControll.currentPage + 1;
    }
    else{
        self.pageControll.currentPage = 0;
    }
    [self changePage:self.pageControll.currentPage];
}
#pragma mark - JSON解析

- (void)obtainData{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *domainStr = [NSString stringWithFormat:@"https://api.xiyoumobile.com/xiyoulibv2/news/getList/news/%d",currentPage];
    NSURL *URL = [NSURL URLWithString:domainStr];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        NSDictionary *DetailDict = responseObject[@"Detail"];
        NSLog(@"%@",DetailDict);
        self.total = DetailDict[@"Amount"];
        self.newsData = DetailDict[@"Data"];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger number  = self.newsData.count;
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        return cell;
    }
    else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *) [cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    CCJSONModel *model = [CCJSONModel yy_modelWithDictionary:self.newsData[indexPath.row]];
    NSString *string = [NSString stringWithFormat: @"%@",model.Title];
    cell.textLabel.text = string;
    cell.textLabel.numberOfLines = 0;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.hidesBottomBarWhenPushed = YES;
    CCJSONModel *model = [CCJSONModel yy_modelWithDictionary:self.newsData[indexPath.row]];
    
    CCDetailController * postVC = [[CCDetailController alloc] init];
    
    postVC.ID = model.ID;
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        postVC.type = @"news";
    }
    else{
        postVC.type = @"announce";
    }
    [self.navigationController pushViewController: postVC animated:NO];
    self.hidesBottomBarWhenPushed = NO;

}


@end
