//
//  CCBookDetailController.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/2/7.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "CCBookDetailController.h"
#import "Masonry.h"
#import "CCJSONModel.h"
#import "YYModel.h"
#import "AFNetworking.h"
#import "CCHeaderView.h"
#import "CCSectionView.h"
#import "CCCirculationView.h"
#import "CCBookDetailTableViewCell.h"
#import "CCReferTableViewCell.h"
#import "CCCirculationCell.h"
#import "CCCirculationView.h"
#import "CCReferbooksModel.h"
#import "CCCirculationModel.h"
#import "CCBookdetailModel.h"
#import "FeHandwritingViewController.h"
#import "AppDelegate.h"
#import "CCLognController.h"


#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height

@interface CCBookDetailController()

@property(strong, nonatomic) UITableView *tableview;
@property(strong, nonatomic) UIButton *upTopBtn;
@property(strong, nonatomic) NSMutableArray *bookdetailModelArray;
@property(strong, nonatomic) NSMutableArray *circulationModelArray;
@property(strong, nonatomic) NSMutableArray *referbooksModelArray;
@property(copy, nonatomic) NSString *domainStr;

@end

@implementation CCBookDetailController

- (UITableView *)tableView{
    if (!_tableview) {
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, kCCDeviceWidth - 20, kCCDeviceHeight ) style:UITableViewStyleGrouped];
        self.tableview.showsVerticalScrollIndicator = NO;
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
        self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.tableview.sectionFooterHeight = 0;
        self.tableview.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.tableview];
        self.tableview.hidden = YES;
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self obtainData];
    [self showAnimation];
    
    self.navigationItem.title = @"图书详情";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回-白色.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.upTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.upTopBtn setImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateNormal];
    self.upTopBtn.layer.masksToBounds = YES;
    self.upTopBtn.layer.cornerRadius = kCCDeviceHeight*0.03;
    self.upTopBtn.hidden = YES;
    self.upTopBtn.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.upTopBtn addTarget:self action:@selector(pressup) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.upTopBtn ];
    [self.upTopBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCCDeviceHeight*0.06, kCCDeviceHeight*0.06));
        make.bottom.equalTo(self.view).with.offset(-kCCDeviceHeight*0.05);
        make.right.equalTo(self.view).with.offset(-kCCDeviceHeight*0.03);
    }];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kCCDeviceWidth, kCCDeviceHeight - 64) style:UITableViewStyleGrouped];
    self.tableview.showsVerticalScrollIndicator = NO;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableview.sectionFooterHeight = 0;
    self.tableview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.tableview];
    self.tableview.hidden = YES;
    
    [self.view bringSubviewToFront:self.upTopBtn];
}

- (void)showAnimation{
    FeHandwritingViewController *vc = [[FeHandwritingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//视图滚动时进行监听
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.tableView.contentOffset.y > 0) {
        self.upTopBtn.hidden = NO;
    }
    else{
        self.upTopBtn.hidden = YES;
    }
}
- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.tableView.contentOffset.y > 0) {
        self.upTopBtn.hidden = NO;
    }
    else{
        self.upTopBtn.hidden = YES;
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y<kCCDeviceHeight/2.0){
        self.upTopBtn.hidden = YES;
    }
    else
        self.upTopBtn.hidden = NO;
}

//btn 点击事件
- (void)clickLeftBtn{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}
- (void)pressup{
    
    [self.tableview setContentOffset:CGPointMake(0, 0)];
    self.upTopBtn.hidden=YES;
}

#pragma ---UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger number = 0;
    switch (section) {
        case 0:
            number = 1;
            break;
        case 1:
            number = 1;
            break;
        case 2:
            number = self.circulationModelArray.count;
            break;
        case 3:
            number = 1;
            break;
        case 4:
            number = self.referbooksModelArray.count;
            break;
    }
    return number;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        CCBookdetailModel *bookdetailModel = self.bookdetailModelArray[indexPath.row];
        CGSize size = [bookdetailModel.size CGSizeValue];
        return kCCDeviceHeight*0.01+size.height;
    }
    else if (indexPath.section==1) {
        return kCCDeviceHeight*0.22;
    }
    else if (indexPath.section==2){
        CCCirculationModel *circulationModel = self.circulationModelArray[indexPath.row];
        if (circulationModel.Date==nil) {
            return kCCDeviceHeight*0.14;
        }
        else
            return kCCDeviceHeight*0.18;
    }
    else if (indexPath.section==4){
        CCReferbooksModel *referbooksModel = self.referbooksModelArray[indexPath.row];
        CGSize size = [referbooksModel.size CGSizeValue];
        return kCCDeviceHeight*0.11 + size.height;
    }
    else
        return kCCDeviceHeight*0.06;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
        cell.textLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CCBookdetailModel *bookdetailModel = self.bookdetailModelArray[indexPath.row];
        cell.textLabel.text = bookdetailModel.Title;
        return cell;
    }
    else if (indexPath.section==1) {
        CCBookDetailTableViewCell *cell = [[CCBookDetailTableViewCell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CCBookdetailModel *bookdetailModel = self.bookdetailModelArray[indexPath.row];
        cell.authorLabel.text = bookdetailModel.Author;
        cell.sortLabel.text = bookdetailModel.Sort;
        cell.pubLabel.text = bookdetailModel.Pub;
        cell.favLabel.text = bookdetailModel.FavTimes;
        cell.renttimesLabel.text = bookdetailModel.RentTimes;
        return cell;
    }
    else if (indexPath.section==2){
        CCCirculationCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"circulation"];
        if (cell==NULL) {
            cell = [[CCCirculationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"circulation"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        CCCirculationModel *circulationModel = self.circulationModelArray[indexPath.row];
        if (circulationModel.Date.length==0) {
            cell.dateLabel.hidden = YES;
            cell.datetitleLabel.hidden = YES;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
            btn.layer.cornerRadius = 10;
            cell.backgroundView = btn;
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell).with.offset(kCCDeviceWidth*0.05);
                make.size.mas_equalTo(CGSizeMake(kCCDeviceWidth*0.9, kCCDeviceHeight*0.11));
            }];
        }
        else{
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
            btn.layer.cornerRadius = 10;
            cell.backgroundView = btn;
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell).with.offset(kCCDeviceWidth*0.05);
                make.size.mas_equalTo(CGSizeMake(kCCDeviceWidth*0.9, kCCDeviceHeight*0.15));
            }];
        }
        cell.barcodeLabel.text = circulationModel.Barcode;
        cell.stateLabel.text = circulationModel.Status;
        cell.departmentLabel.text = circulationModel.Department;
        cell.dateLabel.text = circulationModel.Date;
        return cell;
    }
    else if (indexPath.section==4){
        
        CCReferTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"refer"];
        if (cell==NULL) {
            cell = [[CCReferTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"refer"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        CCReferbooksModel *referbooksModel = self.referbooksModelArray[indexPath.row];
        CGSize size = [referbooksModel.size CGSizeValue];
        [cell.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell).with.offset(0);
            make.left.equalTo(cell).with.offset(kCCDeviceWidth*0.1);
            make.size.mas_equalTo(CGSizeMake(kCCDeviceWidth*0.8, size.height));
        }];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        btn.layer.cornerRadius = 10;
        cell.backgroundView = btn;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell).with.offset(kCCDeviceWidth*0.05);
            make.size.mas_equalTo(CGSizeMake(kCCDeviceWidth*0.9, kCCDeviceWidth*0.14 + size.height));
        }];
        cell.titleLabel.text = referbooksModel.Title;
        cell.authorLabel.text = referbooksModel.Author;
        cell.IDLabel.text = referbooksModel.ID;
        return cell;
    }
    else{
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.selectionStyle = -UITableViewCellSelectionStyleNone;
        CCBookdetailModel *bookdetailModel = self.bookdetailModelArray[0];
        cell.textLabel.text = bookdetailModel.Subject;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2) {
        return kCCDeviceHeight*0.12;
    }
    else if(section==0)
        return 0;
    else
        return kCCDeviceHeight*0.08;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        CCSectionView *sectionView = [[CCSectionView alloc]initWithFrame:CGRectMake(0, 0, kCCDeviceWidth, kCCDeviceHeight*0.06)];
        sectionView.numberImageView.image=[UIImage imageNamed:@"number-1"];
        sectionView.titleLabel.text = @"基本资料";
        [sectionView.collectBtn addTarget:self action:@selector(presscollect) forControlEvents:UIControlEventTouchUpInside];
        return sectionView;
    }
    else if (section==2){
        CCCirculationView *circulationView = [[CCCirculationView alloc]initWithFrame:CGRectMake(0, 0, kCCDeviceWidth, kCCDeviceHeight*0.12)];
        circulationView.numberImageView.image = [UIImage imageNamed:@"number-2"];
        circulationView.titleLabel.text = @"流通情况";
        CCBookdetailModel *bookdetailModel = self.bookdetailModelArray[0];
        circulationView.borrowLabel.text = bookdetailModel.Avaliable;
        circulationView.totalLabel.text = bookdetailModel.Total;
        return circulationView;
    }
    else{
        CCSectionView *sectionView = [[CCSectionView alloc]initWithFrame:CGRectMake(0, 0, kCCDeviceWidth, kCCDeviceHeight*0.06)];
        sectionView.numberImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"number-%ld",(long)section]];
        if (section==3) {
            sectionView.titleLabel.text = @"图书主题";
        }
        else
            sectionView.titleLabel.text = @"相关推荐";
        sectionView.collectBtn.hidden = YES;
        sectionView.collectImageView.hidden = YES;
        return sectionView;
    }

}


- (void)obtainData{
    
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if (self.Barcode != nil) {
        self.domainStr = [NSString stringWithFormat:@"https://api.xiyoumobile.com/xiyoulibv2/book/detail/barcode/%@",_Barcode ];
        
    }else{
        self.domainStr = [NSString stringWithFormat:@"https://api.xiyoumobile.com/xiyoulibv2/book/detail/id/%@",_ID ];
    }
    NSURL *URL = [NSURL URLWithString:_domainStr];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        self.bookdetailModelArray = [[NSMutableArray alloc] init];
        self.circulationModelArray = [[NSMutableArray alloc] init];
        self.referbooksModelArray = [[NSMutableArray alloc] init];
        NSDictionary *Detaildic = [responseObject objectForKey:@"Detail"];
        NSLog(@"%@",Detaildic);
        CCBookdetailModel *bookdetailModel = [CCBookdetailModel yy_modelWithDictionary:Detaildic];
        NSDictionary *Doubandic = [Detaildic objectForKey:@"DoubanInfo"];
        if ([Doubandic isEqual:[NSNull null]]) {
            CCHeaderView *headerView = [[CCHeaderView alloc]initWithFrame:CGRectMake(0, 0, kCCDeviceWidth, kCCDeviceHeight*0.29)];
            self.tableview.tableHeaderView = headerView;
        }
        else{
                 NSDictionary *Imagedic = [Doubandic objectForKey:@"Images"];
                 bookdetailModel.Image = [Imagedic objectForKey:@"large"];
                 CCHeaderView *headerView = [[CCHeaderView alloc]initWithFrame:CGRectMake(0, 0, kCCDeviceWidth, kCCDeviceHeight*0.29)];
                 headerView.nopictureImage.hidden = YES;
                 NSURL *imageurl = [NSURL URLWithString:bookdetailModel.Image];
                 self.tableview.tableHeaderView = headerView;
                 //[headerView.bookImageView sd_setImageWithURL:imageurl];
             }
        CGSize size=[bookdetailModel.Title boundingRectWithSize:CGSizeMake(kCCDeviceWidth*0.9, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20]} context:nil].size;
        NSValue *value = [NSValue valueWithCGSize:size];
        bookdetailModel.size = value;
        [self.bookdetailModelArray addObject:bookdetailModel];
        NSArray *circulationArray = [Detaildic objectForKey:@"CirculationInfo"];
        for (NSDictionary *dic in circulationArray) {
            CCCirculationModel *circulationModel = [CCCirculationModel yy_modelWithDictionary:dic];
            [self.circulationModelArray addObject:circulationModel];
        }
        NSArray *referbooksArray = [Detaildic objectForKey:@"ReferBooks"];
        for (NSDictionary *dic in referbooksArray) {
                CCReferbooksModel *referbooksModel = [CCReferbooksModel yy_modelWithDictionary:dic];
                 CGSize size = [referbooksModel.Title boundingRectWithSize:CGSizeMake(kCCDeviceWidth*0.8, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
                 NSValue *value = [NSValue valueWithCGSize:size];
                 referbooksModel.size = value;
                 [self.referbooksModelArray addObject:referbooksModel];
            }

             [self.tableview reloadData];
             self.tableview.hidden = NO;
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"%@",error);
         }];
}


- (void)presscollect{
    AppDelegate *Delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSLog(@"%@",Delegate.Session);
    if (Delegate.islogin==YES) {
        NSString *domainStr = [NSString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/user/addFav?session=%@",Delegate.Session ];
        NSURL *URL = [NSURL URLWithString:domainStr];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

        [manager GET:URL.absoluteString parameters:nil progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 NSLog(@"%@",responseObject);
                 NSString *result=[responseObject objectForKey:@"Detail"];
                 if ([result isEqualToString:@"ADDED_SUCCEED"]) {
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"收藏成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                     UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                     [alertController addAction:yesAction];
                     [self presentViewController:alertController animated:YES completion:nil];
                 }
                 else if ([result isEqualToString:@"ALREADY_IN_FAVORITE"]){
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"已收藏" message:nil preferredStyle:UIAlertControllerStyleAlert];
                     UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                     [alertController addAction:yesAction];
                     [self presentViewController:alertController animated:YES completion:nil];
                 }
                 else if ([result isEqualToString:@"ADDED_FAILED"]){
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"收藏失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
                     UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                     [alertController addAction:yesAction];
                     [self presentViewController:alertController animated:YES completion:nil];
                 }
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"%@",error);
             }];
    }
    else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"当前未登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        }];
        [alertController addAction:yesAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
