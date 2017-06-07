//
//  CCCirculationCell.h
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/2/17.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCCirculationCell : UITableViewCell
@property(strong,nonatomic)UILabel *barcodeLabel;
@property(strong,nonatomic)UILabel *stateLabel;
@property(strong,nonatomic)UILabel *departmentLabel;
@property(strong,nonatomic)UILabel *dateLabel;
@property(strong,nonatomic)UILabel *datetitleLabel;
@end
