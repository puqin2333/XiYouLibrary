//
//  CCBookDetailController.h
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/2/7.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCBookDetailController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, copy) NSString *ID;
@property(nonatomic ,copy) NSString *Barcode;

@end
