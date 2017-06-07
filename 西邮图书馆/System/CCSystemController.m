//
//  CCSystemController.m
//  
//
//  Created by 陈普钦 on 16/11/14.
//
//

#import "CCSystemController.h"
#import "ViewController.h"
#import "Masonry.h"
#import "CCAboutController.h"
#import "AppDelegate.h"
#import "CCLognController.h"
#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height

@interface CCSystemController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UISegmentedControl *segmentedControl;
@property(nonatomic, strong) UIScrollView *scollView;
@property(nonatomic, strong) UIPageControl *pageControll;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, retain) NSArray *coverList;
@property(nonatomic, retain) NSMutableArray *viewControllers;
@property(nonatomic, retain) NSArray *array;

@end

@implementation CCSystemController

- (UIScrollView *)scollView
{
    if(!_scollView){
        _scollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height * 0.25)];
        _scollView.pagingEnabled = YES;
        _scollView.contentSize = CGSizeMake(_scollView.frame.size.width * 3, _scollView.frame.size.height);
        _scollView.showsHorizontalScrollIndicator = NO;
        _scollView.showsVerticalScrollIndicator = NO;
        _scollView.scrollsToTop = YES;
//        [self.tableView addSubview:_scollView];
        [self.view addSubview:_scollView];
    }
    return _scollView;
}

- (UIPageControl *) myPageControl
{
    if (!_pageControll) {
        //创建UIPageControl控件
        _pageControll = [[UIPageControl alloc] init];
        _pageControll.frame = CGRectMake(0, self.view.bounds.size.height * 0.09 + 66, _scollView.frame.size.width, self.view.bounds.size.height *0.3);
        _pageControll.currentPageIndicatorTintColor = [UIColor blackColor];
        _pageControll.currentPage = 0;
        _pageControll.numberOfPages = _coverList.count;
//        [self.tableView addSubview:_pageControll];
        [self.view addSubview:_pageControll];
    }
    return _pageControll;
}

- (UITableView *)tableView
{
    if(!_tableView){
        self.tableView = [[UITableView alloc] init];
        [self.view addSubview: _tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.view.mas_left).with.offset(3);
            make.right.equalTo(self.view.mas_right).with.offset(-3);
            make.top.equalTo(self.scollView.mas_bottom).with.offset(2);
            //make.bottom.equalTo(self.tabBarController.tabBar.mas_top).with.offset(2);
            make.height.mas_equalTo(kCCDeviceHeight*0.58);
        }];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = kCCDeviceHeight * 0.09;
        self.tableView.scrollEnabled = NO;
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        self.tableView.tableFooterView = view;
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.isLogin = NO;
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"系统" image:[UIImage imageNamed:@"set"] tag:2];
    self.navigationItem.title = @"系统设置";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    
    //设置navgationbar的属性
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:84.0/255 green:181.0/255 blue:239.0/255.0 alpha:255.0/225.0];
    self.navigationController.navigationBar.translucent = NO;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width,self.view.bounds.size.height * 0.25)];
    [self.view addSubview:view];
    
    //设置图片轮播器
    //程序采用懒加载的方式来创建pageController控制器
    //因此此处只向数组中添加一些null作为占位符
    //等到程序需要时才真正创建pageViewcontroller
    self.coverList = @[@"1.jpg",@"2.jpg",@"1.jpg"];
    self.viewControllers = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < _coverList.count; i++) {
        [self.viewControllers addObject:[NSNull null]];
    }
    [self scollView];
//    self.tableView.tableHeaderView = _scollView;
    view = _scollView;
    [self myPageControl];
    [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(change) userInfo:nil repeats:YES];
    //初始化默认加载第一页
    [self loadScrollViewWithPage:0];
    //避免翻页时才加载下一页，同时把下一页的内容也加载出来
    [self loadScrollViewWithPage:1];
    
    _array = [NSArray arrayWithObjects:@"消息通知", @"2G/3G/4G网络下显示图片",@"关于我们",@"退出当前帐户",nil];
    [self tableView];
    
    
    

}

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableVIew -- DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return 4;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:  UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if (indexPath.row < 2) {
            UISwitch *switchView = [[UISwitch alloc] init];
            [cell addSubview: switchView];
            [switchView mas_makeConstraints:^(MASConstraintMaker *make){
                make.right.equalTo(cell.mas_right).with.offset(-20);
                make.height.mas_equalTo(kCCDeviceHeight *0.07);
                make.width.mas_equalTo(kCCDeviceWidth *0.1);
                make.top.equalTo(cell.mas_top).with.offset(15);\
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }];
        }
            if(indexPath.row > 1){
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        cell.textLabel.text = _array[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 2:{
            self.hidesBottomBarWhenPushed = YES;
            CCAboutController *vc = [[CCAboutController alloc] init];
            [self.navigationController pushViewController:vc animated:NO];
            self.hidesBottomBarWhenPushed = NO;
        }
            break;
        case 3:{
            if (self.isLogin == NO) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"当前未登录" preferredStyle: UIAlertControllerStyleAlert];
                UIAlertAction *yesAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确认",nil) style:UIAlertActionStyleDestructive handler:nil];
                [alertController addAction:yesAction];
                [self presentViewController:alertController animated:YES completion:nil];

            }else{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确认退出?" preferredStyle: UIAlertControllerStyleAlert];
                UIAlertAction *yesAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确认",nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    AppDelegate *Delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
                    Delegate.islogin = NO;
                    self.isLogin = NO;
                    CCLognController *loginVC = [[CCLognController alloc] init];
                    [self.navigationController pushViewController:loginVC animated:NO]
                    ;
                    Delegate.Session = nil;

                }];
                
                UIAlertAction *noAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消",nil) style:UIAlertActionStyleDestructive handler:nil];
                [alertController addAction:yesAction];
                [alertController addAction:noAction];
                [self presentViewController:alertController animated:YES completion:nil];
                CCLognController *loginVC = [[CCLognController alloc] init];
                [self.navigationController pushViewController:loginVC animated:NO]
                ;
            }
          
           
        }
            break;
        default:
            break;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
    AppDelegate *Delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    if(self.isLogin != Delegate.islogin){
        self.isLogin = Delegate.islogin;
        //Delegate.Session = nil;
        [self.tableView reloadData];
    }
}



@end
