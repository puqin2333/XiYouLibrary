//
//  CCSearchController.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/1/10.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "CCSearchController.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "CCJSONModel.h"
#import "CCBookDetailController.h"

#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kSearchHistoryKey @"SearchHistoryKey"

@interface CCSearchController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) UITableView *searchTableView;
@property(strong, nonatomic) NSMutableArray *bookModelArray;
@property(strong, nonatomic) UILabel *notsearchLabel;
@property(nonatomic, strong) UITableView *historyTableView;
@property(nonatomic, assign) BOOL isHistory;
@property(nonatomic, strong) NSMutableArray *historyArray;
@property(nonatomic, strong) UIView *hotView;

@end

@implementation CCSearchController

- (UISearchBar *)searchBar{
    if (!_searchBar) {
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 65, self.view.bounds.size.width, 55)];
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.placeholder = @"搜索 书名 作者 分类";
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.delegate = self;
        _searchBar.keyboardType = UIKeyboardTypeDefault;
        [self.view addSubview:_searchBar];
    }
    return _searchBar;
}

- (UITableView *)searchTableView{
    if (!_searchTableView) {
        self.searchTableView = [[UITableView alloc] init];
        [self.view addSubview:self.searchTableView];
        [self.searchTableView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.view.mas_left).with.offset(3);
            make.right.equalTo(self.view.mas_right).with.offset(-3);
            make.top.mas_equalTo(self.searchBar.mas_bottom);
            make.height.mas_equalTo(kCCDeviceHeight - 120);
        }];
        self.searchTableView.delegate = self;
        self.searchTableView.dataSource = self;
        self.searchTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        self.searchTableView.showsVerticalScrollIndicator = NO;
    }
    return _searchTableView;
}

- (UIView *)hotView{
    if(!_hotView){
        self.hotView = [[UIView alloc] init];
        self.hotView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:self.hotView];
        [self.hotView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.top.mas_equalTo(self.searchBar.mas_bottom);
            make.height.mas_equalTo(kCCDeviceHeight * 0.2);
        }];
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.hotView addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.hotView.mas_left).with.offset(20);
            make.top.equalTo(self.hotView.mas_top).with.offset(10);
            make.height.mas_equalTo(kCCDeviceHeight * 0.07);
            make.width.mas_equalTo(kCCDeviceWidth * 0.2);
        }];
        btn1.titleLabel.text = @"计算机";
        btn1.backgroundColor = [UIColor redColor];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.hotView addSubview:btn2];
        [btn2 mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(btn1.mas_right).with.offset(50);
            make.top.equalTo(self.hotView.mas_top).with.offset(10);
            make.height.mas_equalTo(kCCDeviceHeight * 0.07);
            make.width.mas_equalTo(kCCDeviceWidth * 0.2);
        }];
        btn2.titleLabel.text = @"123";
        btn2.backgroundColor = [UIColor redColor];

    }
    return _hotView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图书检索";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回-白色.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    [self searchBar];
    //[self hotView];
    
//    self.searchTableView = [[UITableView alloc] init];
//    [self.view addSubview:self.searchTableView];
//    [self.searchTableView mas_makeConstraints:^(MASConstraintMaker *make){
//        make.left.equalTo(self.view.mas_left).with.offset(3);
//        make.right.equalTo(self.view.mas_right).with.offset(-3);
//        make.top.mas_equalTo(self.searchBar.mas_bottom);
//        make.height.mas_equalTo(kCCDeviceHeight - 120);
//    }];
//    self.searchTableView.delegate = self;
//    self.searchTableView.dataSource = self;
//    self.searchTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
//    self.searchTableView.showsVerticalScrollIndicator = NO;
    
    //历史记录
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *historyList = [defaults valueForKey:kSearchHistoryKey];
    if ((historyList.count != 0) && (![historyList isKindOfClass:[NSNull class]])) {
        self.historyArray = [historyList mutableCopy];
    }
    
}

- (NSMutableArray *)historyArray{
    if (!_historyArray) {
        _historyArray = [NSMutableArray array];
    }
    return _historyArray;
}

- (void)searchResultWithKeyWord:(NSString *)text{
    if ([text isEqualToString:@""]) {
        return;
    }
    [self.historyArray insertObject:text atIndex:0];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.historyArray forKey:kSearchHistoryKey];
    [defaults synchronize];
    
    
}



- (void)clickLeftBtn
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getlist:(NSString *)searchstr{
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    [session GET:searchstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.bookModelArray=[[NSMutableArray alloc]init];
        NSDictionary *Detaildic=[responseObject objectForKey:@"Detail"];
        if ([Detaildic isKindOfClass:[NSDictionary class]]) {
            NSArray *bookDataArray=[Detaildic objectForKey:@"BookData"];
            NSLog(@"%@",bookDataArray);
            for (NSDictionary *dic in bookDataArray) {
                CCJSONModel *bookModel=[CCJSONModel yy_modelWithJSON:dic];
                [self.bookModelArray addObject:bookModel];
            }
            if (self.searchBar.text.length==0) {
                [self.bookModelArray removeAllObjects];
            }
        }
        [self.searchTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
    UIButton *cancelBtn=[self.searchBar valueForKey:@"cancelButton"];
    cancelBtn.enabled=YES;
}
#pragma UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self searchTableView];
    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"];
    cancelBtn.enabled = YES;
    [self.bookModelArray removeAllObjects];
    [self.searchTableView reloadData];
    NSString *searchstr = @"https://api.xiyoumobile.com/xiyoulibv2/book/search";
    NSCharacterSet *characterset=[[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> .~"]invertedSet];
    NSString *encodedstr=[searchstr stringByAddingPercentEncodingWithAllowedCharacters:characterset];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"matchMethod"] = @"jq";
    params[@"keyword"] = searchBar.text;

    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];

    [session GET:encodedstr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.bookModelArray = [NSMutableArray array];
        NSDictionary *dectDic = [responseObject objectForKey:@"Detail"];
        if ([dectDic isKindOfClass:[NSDictionary class]]) {
            NSArray *bookDataArray = [dectDic objectForKey:@"BookData"];
            NSLog(@"%@",bookDataArray);
            for (NSDictionary *dic in bookDataArray) {
                CCJSONModel *bookModel = [CCJSONModel yy_modelWithJSON:dic];
                [self.bookModelArray addObject:bookModel];
            }
            [self.searchTableView reloadData];
        }
        else{
            self.notsearchLabel=[[UILabel alloc] initWithFrame:CGRectMake(kCCDeviceWidth*0.3, kCCDeviceHeight*0.5, kCCDeviceWidth*0.4, kCCDeviceHeight*0.03)];
            self.notsearchLabel.text = @"未找到相关书籍";
            self.notsearchLabel.font = [UIFont boldSystemFontOfSize:18];
            [self.view addSubview:self.notsearchLabel];
            self.notsearchLabel.hidden = NO;

        }
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        NSLog(@"Error: %@", error);
    }];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        [self.bookModelArray removeAllObjects];
        [self.searchTableView reloadData];
    }
    else{
        NSString *searchstr = [[NSString alloc]initWithFormat:@"https://api.xiyoumobile.com/xiyoulibv2/book/search?keyword=%@",searchText];
        NSCharacterSet *characterset = [[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "]invertedSet];
        NSString *encodedstr=[searchstr stringByAddingPercentEncodingWithAllowedCharacters:characterset];
        [self getlist:encodedstr];

    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    self.searchBar.showsCancelButton=NO;
    self.searchBar.text=nil;
    [self.bookModelArray removeAllObjects];
    [self.searchTableView reloadData];
    self.notsearchLabel.hidden=YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.searchBar.showsCancelButton=YES;
    self.notsearchLabel.hidden=YES;
    UIButton *btn=[searchBar valueForKey:@"cancelButton"];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[self searchTableView];
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bookModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[self.searchTableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==NULL) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    CCJSONModel *bookModel=self.bookModelArray[indexPath.row];
    cell.textLabel.text=bookModel.Title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    CCJSONModel *model = self.bookModelArray[indexPath.row];
    NSLog(@"%@",model.Title);
    CCBookDetailController *bookVC = [[CCBookDetailController alloc]init];
    bookVC.ID = model.ID;
    bookVC.Barcode = nil;
    NSLog(@"%@",model.ID);
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bookVC animated:YES];
    [self.searchBar resignFirstResponder];
    self.searchBar.showsCancelButton = NO;
}

@end
