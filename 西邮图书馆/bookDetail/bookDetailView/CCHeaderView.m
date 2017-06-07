//
//  CCHeaderView.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/2/15.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "CCHeaderView.h"
#import "Masonry.h"
#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height

@implementation CCHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kCCDeviceWidth, kCCDeviceHeight * 0.29)];
        imageView.image = [UIImage imageNamed:@"bookbackground"];
        [self addSubview:imageView];
        
        self.bookImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kCCDeviceWidth - kCCDeviceWidth*0.35)/2, kCCDeviceHeight*0.01, kCCDeviceWidth*0.28, kCCDeviceHeight*0.2)];
        self.bookImageView.center = imageView.center;
        self.bookImageView.backgroundColor=[UIColor grayColor];
        [imageView addSubview:self.bookImageView];
        
        self.nopictureImage = [[UIImageView alloc]init];
        [self.bookImageView addSubview:self.nopictureImage];
        [self.nopictureImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.and.centerY.equalTo(self.bookImageView);
            make.size.mas_equalTo(CGSizeMake(kCCDeviceHeight*0.1, kCCDeviceHeight*0.1));
        }];
        self.nopictureImage.image = [UIImage imageNamed:@"final.png"];
    }
    return self;

}

@end
