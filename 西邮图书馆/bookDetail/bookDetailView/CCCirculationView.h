//
//  CCCirculationView.h
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/2/15.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCCirculationView : UIView
@property(strong,nonatomic) UIImageView *numberImageView;
@property(strong,nonatomic) UILabel *label;
@property(strong,nonatomic) UILabel *titleLabel;
@property(strong,nonatomic) UILabel *borrowLabel;
@property(strong,nonatomic) UILabel *totalLabel;
@end
