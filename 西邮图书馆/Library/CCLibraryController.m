//
//  CCLibraryController.m
//  
//
//  Created by 陈普钦 on 16/11/14.
//
//

#import "CCLibraryController.h"
#import "CCBorrwController.h"
#import "CCListController.h"
#import "CCFootViewController.h"
#import "CCCollectionViewController.h"
#import "CCLognController.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "AppDelegate.h"

#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height

@protocol CCLognControlDelegate;

@interface CCLibraryController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CCLognControlDelegate>

@property(nonatomic, strong) UIImageView *myHeadPortrait;
@property(nonatomic, strong)  UITableView *tableView;
@property(nonatomic, retain)  NSArray *array;
@property(nonatomic, strong)  UIView *headerView;
@property(nonatomic, strong) UILabel *myHeadLabel;
@property(nonatomic,copy) NSString *Session;
@property(nonatomic, strong) UILabel *label,*label1;
@property(nonatomic, retain) NSDictionary *dict;

@end

@implementation CCLibraryController



- (UITableView *)tableView
{
    if(!_tableView){
        self.tableView = [[UITableView alloc] init];
        [self.view addSubview: _tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.view.mas_left).with.offset(3);
            make.right.equalTo(self.view.mas_right).with.offset(-3);
            make.top.equalTo(self.headerView.mas_bottom).with.offset(2);
            make.height.mas_equalTo(kCCDeviceHeight*0.58);
        }];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = kCCDeviceHeight *0.09;
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
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"account"] tag:1];
    self.navigationItem.title = @"我的";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:84.0/255 green:181.0/255 blue:239.0/255.0 alpha:255.0/225.0];
    UIView *view = [[UIView alloc] init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(kCCDeviceHeight*0.25);
    }];
    view.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:223.0/255.0 alpha:155.0/255.0];
    
    
    
    UIImageView *backgroundView = [[UIImageView alloc] init];
    [view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(view.mas_top);
        make.left.mas_equalTo(view.mas_left);
        make.right.mas_equalTo(view.mas_right);
        make.height.mas_equalTo(kCCDeviceHeight*0.25);
    }];

    backgroundView.image = [UIImage imageNamed:@"mybackground"];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(backgroundView.mas_centerX);
        make.centerY.mas_equalTo(backgroundView.mas_centerY).with.offset(-20);
        make.width.mas_equalTo(kCCDeviceWidth * 0.18);
        make.height.mas_equalTo(kCCDeviceWidth * 0.18);
    }];
    imageView.image = [UIImage imageNamed:@"image"];

    self.headerView = backgroundView;
    _array = [NSArray arrayWithObjects:@"我的借阅", @"我的足迹",@"我的收藏",@"排行榜",nil];
    [self tableView];
    
    self.myHeadPortrait = imageView;
    _myHeadPortrait.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(backgroundView.mas_centerX);
        make.top.mas_equalTo(imageView.mas_bottom).with.offset(2);
        make.width.mas_equalTo(kCCDeviceWidth);
        make.height.mas_equalTo(kCCDeviceWidth * 0.07);
    }];
    label.text = @"点击登录";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    _myHeadLabel = label;
    [self setHeadPortrait];
   
                                                                
}
- (void)clickLeftBtn
{
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma UITableVIew -- DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:  UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = _array[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self.Session isEqualToString:@"ACCOUNT_ERROR"]&&self.Session) {
        switch (indexPath.row) {
            case 0:{
                self.hidesBottomBarWhenPushed = YES;
                CCBorrwController *vc = [[CCBorrwController alloc] init];
                vc.Session = self.Session;
                NSLog(@"%@",self.Session);
                [self.navigationController pushViewController:vc animated:NO];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            case 1:{
                self.hidesBottomBarWhenPushed = YES;
                CCFootViewController *vc = [[CCFootViewController alloc] init];
                vc.Session = self.Session;
                NSLog(@"%@",self.Session);
                [self.navigationController pushViewController:vc animated:NO];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            case 2:{
                self.hidesBottomBarWhenPushed = YES;
                CCCollectionViewController *vc = [[CCCollectionViewController alloc] init];
                vc.Session = self.Session;
                [self.navigationController pushViewController:vc animated:NO];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            case 3:{
                self.hidesBottomBarWhenPushed = YES;
                CCListController *vc = [[CCListController alloc] init];
                [self.navigationController pushViewController:vc animated:NO];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            default:
                break;
        }

    }
    else{
        switch (indexPath.row) {
            case 0:{
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前未登录" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alView show];
            }
                break;
            case 1:{
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前未登录" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alView show];

            }
                break;
            case 2:{
                UIAlertView *alView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前未登录" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alView show];
            }
                break;
            case 3:{
                self.hidesBottomBarWhenPushed = YES;
                CCListController *vc = [[CCListController alloc] init];
                [self.navigationController pushViewController:vc animated:NO];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            default:
                break;
        }

    }
    
    
}


- (void)setHeadPortrait{
    //  把头像设置成圆形
    self.myHeadPortrait.layer.cornerRadius = kCCDeviceWidth * 0.09;
    self.myHeadPortrait.layer.masksToBounds=YES;
    //  给头像加一个圆形边框
    self.myHeadPortrait.layer.borderWidth = 1.0f;
    self.myHeadPortrait.layer.borderColor = [UIColor whiteColor].CGColor;

    _myHeadPortrait.userInteractionEnabled = YES;
    _myHeadLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LogIn)];
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LogIn)];
    [_myHeadPortrait addGestureRecognizer:singleTap];
    [_myHeadLabel addGestureRecognizer:singleTap1];
}
- (void)setHeadPortrait1{
    //  把头像设置成圆形
    self.myHeadPortrait.layer.cornerRadius = kCCDeviceWidth * 0.09;
    self.myHeadPortrait.layer.masksToBounds=YES;
    //  给头像加一个圆形边框
    self.myHeadPortrait.layer.borderWidth = 1.0f;
    self.myHeadPortrait.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _myHeadPortrait.userInteractionEnabled = YES;
    _myHeadLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(alterHeadPortrait:)];
    [_myHeadPortrait addGestureRecognizer:singleTap];
}

- (void)LogIn{
    self.hidesBottomBarWhenPushed = YES;
    CCLognController *vc = [[CCLognController alloc] init];
    vc.delegate = self;
    [vc removeFromParentViewController];
    [self.navigationController pushViewController:vc animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}

//  方法：alterHeadPortrait
-(void)alterHeadPortrait:(UITapGestureRecognizer *)gesture{
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。

    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    _myHeadPortrait.image = newPhoto;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)obtainData{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *domainStr = @"https://api.xiyoumobile.com/xiyoulibv2/user/info";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"session"] = self.Session;
    NSURL *URL = [NSURL URLWithString:domainStr];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        _dict = responseObject[@"Detail"];
        _label.text = _dict[@"ID"];
        _label1.text = _dict[@"Department"];
        self.navigationItem.title = _dict[@"Name"];
        NSLog(@"%@",_dict);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)loginSuccess:(NSString *)Session{

    self.Session = Session;
    NSLog(@"%@",self.Session);
    
    [self obtainData];
    NSLog(@"1");
    if(![self.Session isEqualToString:@"ACCOUNT_ERROR"] && ![self.Session isEqualToString:nil]){
        UIView *view = [[UIView alloc] init];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(64);
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.height.mas_equalTo(kCCDeviceHeight*0.25);
        }];
        view.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:223.0/255.0 alpha:155.0/255.0];
        UIImageView *backgroundView = [[UIImageView alloc] init];
        [view addSubview:backgroundView];
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(view.mas_top);
            make.left.mas_equalTo(view.mas_left);
            make.right.mas_equalTo(view.mas_right);
            make.height.mas_equalTo(kCCDeviceHeight*0.25);
        }];
        backgroundView.image = [UIImage imageNamed:@"mybackground"];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.mas_equalTo(view.mas_centerX);
            make.centerY.mas_equalTo(view.mas_centerY).with.offset(-20);
            make.width.mas_equalTo(kCCDeviceWidth * 0.18);
            make.height.mas_equalTo(kCCDeviceWidth * 0.18);
        }];
        imageView.image = [UIImage imageNamed:@"image"];
        _label = [[UILabel alloc] init];
        [view addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.mas_equalTo(view.mas_centerX);
            make.top.mas_equalTo(imageView.mas_bottom).with.offset(2);
            make.width.mas_equalTo(kCCDeviceWidth);
            make.height.mas_equalTo(kCCDeviceWidth * 0.07);
        }];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textAlignment = NSTextAlignmentCenter;
        _label1 = [[UILabel alloc] init];
        [view addSubview:_label1];
        [_label1 mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.mas_equalTo(view.mas_centerX);
            make.top.equalTo(_label.mas_bottom).with.offset(-3);
            make.width.mas_equalTo(kCCDeviceWidth );
            make.height.mas_equalTo(kCCDeviceWidth * 0.07);
        }];
        _label1.font = [UIFont systemFontOfSize:14];
        _label1.textAlignment = NSTextAlignmentCenter;
        self.myHeadPortrait = imageView;
        _myHeadPortrait.backgroundColor = [UIColor whiteColor];
        [self setHeadPortrait1];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
    AppDelegate *Delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    if(self.isLogin!=Delegate.islogin){
        self.isLogin=Delegate.islogin;
        if (self.isLogin == YES) {
            [self obtainData];
        }
    }
    self.Session = Delegate.Session;
    if (self.Session == nil) {
        UIView *view = [[UIView alloc] init];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(64);
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.height.mas_equalTo(kCCDeviceHeight*0.25);
        }];
        view.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:223.0/255.0 alpha:155.0/255.0];
        
        
        
        UIImageView *backgroundView = [[UIImageView alloc] init];
        [view addSubview:backgroundView];
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(view.mas_top);
            make.left.mas_equalTo(view.mas_left);
            make.right.mas_equalTo(view.mas_right);
            make.height.mas_equalTo(kCCDeviceHeight*0.25);
        }];
        
        backgroundView.image = [UIImage imageNamed:@"mybackground"];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.mas_equalTo(backgroundView.mas_centerX);
            make.centerY.mas_equalTo(backgroundView.mas_centerY).with.offset(-20);
            make.width.mas_equalTo(kCCDeviceWidth * 0.18);
            make.height.mas_equalTo(kCCDeviceWidth * 0.18);
        }];
        imageView.image = [UIImage imageNamed:@"image"];
        
        self.myHeadPortrait = imageView;
        _myHeadPortrait.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] init];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.mas_equalTo(backgroundView.mas_centerX);
            make.top.mas_equalTo(imageView.mas_bottom).with.offset(2);
            make.width.mas_equalTo(kCCDeviceWidth);
            make.height.mas_equalTo(kCCDeviceWidth * 0.07);
        }];
        label.text = @"点击登录";
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        _myHeadLabel = label;
        [self setHeadPortrait];
        self.navigationItem.title = @"我的";
    }
    [self.tableView reloadData];
    
}


@end

