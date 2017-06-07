//
//  CCAboutController.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/1/10.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "CCAboutController.h"
#import "CCHelpController.h"
#import "CCFeedbackController.h"
#import "Masonry.h"

#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height
@interface CCAboutController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, retain) NSArray *array;
@property(nonatomic, strong) UIView *headerView;
@end

@implementation CCAboutController

- (UITableView *)tableView
{
    if(!_tableView){
        self.tableView = [[UITableView alloc] init];
        [self.view addSubview: _tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.view.mas_left).with.offset(3);
            make.right.equalTo(self.view.mas_right).with.offset(-3);
            make.top.equalTo(self.headerView.mas_bottom).with.offset(2);
            make.height.mas_equalTo(kCCDeviceHeight*0.24);
        }];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = kCCDeviceHeight*0.08;
        self.tableView.scrollEnabled = NO;
        
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        self.tableView.tableFooterView = view;
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回-白色.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];  
    UIView *view = [[UIView alloc] init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(kCCDeviceHeight*0.25);
    }];
    view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"big"]];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(view.mas_centerX);
        make.centerY.mas_equalTo(view.mas_centerY).with.offset(-20);
        make.width.mas_equalTo(kCCDeviceWidth * 0.18);
        make.height.mas_equalTo(kCCDeviceWidth * 0.18);
    }];
    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(imageView.mas_bottom).with.offset(2);
        make.width.mas_equalTo(kCCDeviceWidth);
        make.height.mas_equalTo(kCCDeviceWidth * 0.07);
    }];
    label.text = @"西邮图书馆";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    UILabel *label1 = [[UILabel alloc] init];
    [view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(label.mas_bottom).with.offset(-3);
        make.width.mas_equalTo(kCCDeviceWidth );
        make.height.mas_equalTo(kCCDeviceWidth * 0.07);
    }];
    label1.text = @"Version2.0";
    label1.font = [UIFont systemFontOfSize:14];
    label1.textAlignment = NSTextAlignmentCenter;
    self.headerView = view;
    _array = [NSArray arrayWithObjects:@"版本更新", @"常见问题",@"问题反馈",nil];
    [self tableView];
    
    UIView *view1 = [[UIView alloc] init];
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self.tableView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    view1.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3g"]];
    [view1 addSubview:imageView1];
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(view1.mas_centerX);
        //make.centerY.mas_equalTo(view1.mas_centerY).with.offset(-20);
        make.top.mas_equalTo(self.tableView.mas_bottom).with.offset(30);
        make.width.mas_equalTo(kCCDeviceWidth * 0.18);
        make.height.mas_equalTo(kCCDeviceWidth * 0.18);
    }];
    UILabel *label2 = [[UILabel alloc] init];
    [view1 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(view1.mas_centerX);
        make.top.mas_equalTo(imageView1.mas_bottom).with.offset(2);
        make.width.mas_equalTo(kCCDeviceWidth);
        make.height.mas_equalTo(kCCDeviceWidth * 0.07);
    }];
    label2.text = @"应用开发：西邮移动应用技术开发实验室";
    label2.font = [UIFont systemFontOfSize:11];
    label2.textAlignment = NSTextAlignmentCenter;
    UILabel *label3 = [[UILabel alloc] init];
    [view1 addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.mas_equalTo(view1.mas_centerX);
        make.top.mas_equalTo(label2.mas_bottom).with.offset(-3);
        make.width.mas_equalTo(kCCDeviceWidth );
        make.height.mas_equalTo(kCCDeviceWidth * 0.07);
    }];
    label3.text = @"联系：XXX@xiyoumobile.com";
    label3.font = [UIFont systemFontOfSize:11];
    label3.textAlignment = NSTextAlignmentCenter;

    

}
- (void)clickLeftBtn
{
    [self.navigationController popViewControllerAnimated:NO];
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
#pragma UITableVIew -- DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
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
    switch (indexPath.row) {
        case 0:{
            
        }
            break;
        case 1:{
            CCHelpController *vc = [[CCHelpController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            CCFeedbackController *vc = [[CCFeedbackController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

        default:
            break;
    }
    
    
}

@end
