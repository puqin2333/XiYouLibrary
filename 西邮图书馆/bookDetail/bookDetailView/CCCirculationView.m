//
//  CCCirculationView.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/2/15.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "CCCirculationView.h"
#import "Masonry.h"

#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height

@implementation CCCirculationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.numberImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, kCCDeviceHeight*0.06, kCCDeviceHeight*0.06)];
        [self addSubview:self.numberImageView];
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kCCDeviceHeight*0.09, kCCDeviceHeight*0.01, kCCDeviceWidth*0.3, kCCDeviceHeight*0.05)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [self addSubview:self.titleLabel];
        
        UILabel *borrowtitle = [[UILabel alloc]initWithFrame:CGRectMake(kCCDeviceHeight*0.017, kCCDeviceHeight*0.07, kCCDeviceWidth*0.2, kCCDeviceHeight*0.02)];
        borrowtitle.text = @"可借图书：";
        borrowtitle.font = [UIFont systemFontOfSize:14];
        [self addSubview:borrowtitle];
        
        self.borrowLabel = [[UILabel alloc]initWithFrame:CGRectMake(kCCDeviceWidth*0.21, kCCDeviceHeight*0.07, kCCDeviceWidth*0.2, kCCDeviceHeight*0.02)];
        self.borrowLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.borrowLabel];
        
        UILabel *totaltitle = [[UILabel alloc]initWithFrame:CGRectMake(kCCDeviceWidth*0.41, kCCDeviceHeight*0.07, kCCDeviceWidth*0.2, kCCDeviceHeight*0.02)];
        totaltitle.text = @"共有图书：";
        totaltitle.font = [UIFont systemFontOfSize:14];
        [self addSubview:totaltitle];
        
        self.totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(kCCDeviceWidth*0.6, kCCDeviceHeight*0.07, kCCDeviceWidth*0.2, kCCDeviceHeight*0.02)];
        self.totalLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.totalLabel];
        
    }

    return  self;
}

@end
