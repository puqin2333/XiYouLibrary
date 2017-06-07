//
//  CCBookDetailTableViewCell.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/2/17.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "CCBookDetailTableViewCell.h"
#import "Masonry.h"


#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height
@implementation CCBookDetailTableViewCell

- (instancetype)init{
    self=[super init];
    if (self) {
        UILabel *authortitleLabel = [[UILabel alloc]init];
        authortitleLabel.text = @"作者:";
        authortitleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:authortitleLabel];
        [authortitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(kCCDeviceHeight*0.01);
            make.left.equalTo(self).with.offset(kCCDeviceHeight*0.017);
            make.size.mas_equalTo(CGSizeMake(kCCDeviceWidth*0.1, kCCDeviceHeight*0.03));
        }];
        
        self.authorLabel = [[UILabel alloc]init];
        self.authorLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.authorLabel];
        [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(kCCDeviceHeight*0.01);
            make.left.equalTo(authortitleLabel.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(kCCDeviceWidth*0.8, kCCDeviceHeight*0.03));
        }];
        
        UILabel *sorttitleLabel = [[UILabel alloc]init];
        sorttitleLabel.text = @"索书号:";
        sorttitleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:sorttitleLabel];
        [sorttitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(authortitleLabel.mas_bottom).with.offset(kCCDeviceHeight*0.01);
            make.left.equalTo(self).with.offset(kCCDeviceHeight*0.017);
            make.size.mas_equalTo(CGSizeMake(kCCDeviceWidth*0.15, kCCDeviceHeight*0.03));
        }];
        
        self.sortLabel = [[UILabel alloc]init];
        self.sortLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.sortLabel];
        [self.sortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.authorLabel.mas_bottom).with.offset(kCCDeviceHeight*0.01);
            make.left.equalTo(sorttitleLabel.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(kCCDeviceWidth*0.6, kCCDeviceHeight*0.03));
        }];
        
        UILabel *pubtitleLabel = [[UILabel alloc]init];
        pubtitleLabel.text = @"出版社:";
        pubtitleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:pubtitleLabel];
        [pubtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(sorttitleLabel.mas_bottom).with.offset(kCCDeviceHeight*0.01);
            make.left.equalTo(self).with.offset(kCCDeviceHeight*0.017);
            make.size.mas_equalTo(CGSizeMake(kCCDeviceWidth*0.15, kCCDeviceHeight*0.03));
        }];
        
        self.pubLabel = [[UILabel alloc]init];
        self.pubLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.pubLabel];
        [self.pubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sortLabel.mas_bottom).with.offset(kCCDeviceHeight*0.01);
            make.left.equalTo(pubtitleLabel.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(kCCDeviceWidth*0.6, kCCDeviceHeight*0.03));
        }];
        
        UILabel *FavtitleLabel = [[UILabel alloc]init];
        FavtitleLabel.text = @"收藏次数:";
        FavtitleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:FavtitleLabel];
        [FavtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(pubtitleLabel.mas_bottom).with.offset(kCCDeviceHeight*0.01);
            make.left.equalTo(self).with.offset(kCCDeviceHeight*0.017);
            make.size.mas_equalTo(CGSizeMake(kCCDeviceWidth
                                             *0.2, kCCDeviceHeight*0.03));
        }];
        
        self.favLabel = [[UILabel alloc]init];
        self.favLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.favLabel];
        [self.favLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.pubLabel.mas_bottom).with.offset(kCCDeviceHeight*0.01);
            make.left.equalTo(FavtitleLabel.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(kCCDeviceWidth*0.6, kCCDeviceHeight*0.03));
        }];
        
        UILabel *renttimestitleLabel = [[UILabel alloc]init];
        renttimestitleLabel.text = @"借阅次数:";
        renttimestitleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:renttimestitleLabel];
        [renttimestitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(FavtitleLabel.mas_bottom).with.offset(kCCDeviceHeight*0.01);
            make.left.equalTo(self).with.offset(kCCDeviceHeight*0.017);
            make.size.mas_equalTo(CGSizeMake(kCCDeviceWidth*0.2, kCCDeviceHeight*0.03));
        }];
        
        self.renttimesLabel = [[UILabel alloc]init];
        self.renttimesLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.renttimesLabel];
        [self.renttimesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.favLabel.mas_bottom).with.offset(kCCDeviceHeight*0.01);
            make.left.equalTo(renttimestitleLabel.mas_right).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(kCCDeviceWidth*0.6, kCCDeviceHeight*0.03));
        }];
    }
    return self;
}

@end
