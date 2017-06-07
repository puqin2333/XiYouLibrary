//
//  CCSectionView.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/2/15.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "CCSectionView.h"

#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height

@implementation CCSectionView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.numberImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, kCCDeviceHeight*0.06, kCCDeviceHeight*0.06)];
        [self addSubview:self.numberImageView];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kCCDeviceHeight*0.09, kCCDeviceHeight*0.01, kCCDeviceWidth*0.3, kCCDeviceHeight*0.05)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [self addSubview:self.titleLabel];
        
        self.collectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kCCDeviceWidth*0.5+kCCDeviceHeight*0.07, 0, kCCDeviceHeight*0.06, kCCDeviceHeight*0.06)];
        self.collectImageView.image = [UIImage imageNamed:@"collect.png"];
        [self addSubview:self.collectImageView];
        
        self.collectBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.collectBtn.frame = CGRectMake(kCCDeviceWidth*0.5+kCCDeviceHeight*0.13, kCCDeviceHeight*0.01, kCCDeviceWidth*0.2, kCCDeviceHeight*0.05);
        [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [self.collectBtn setTintColor:[UIColor blackColor]];
        self.collectBtn.titleLabel.font=[UIFont boldSystemFontOfSize:21];
        [self addSubview:self.collectBtn];
    }
    return self;
}


@end
