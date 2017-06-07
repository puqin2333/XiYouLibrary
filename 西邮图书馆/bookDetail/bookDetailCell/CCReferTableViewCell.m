//
//  CCReferTableViewCell.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/2/17.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "CCReferTableViewCell.h"
#import "Masonry.h"
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height

@implementation CCReferTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.left.equalTo(self).with.offset(W*0.1);
            make.size.mas_equalTo(CGSizeMake(W*0.8, H*0.03));
        }];
        
        UILabel *authortitleLabel = [[UILabel alloc]init];
        authortitleLabel.text = @"作者:";
        authortitleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:authortitleLabel];
        [authortitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(H*0.01);
            make.left.equalTo(self).with.offset(W*0.1);
            make.size.mas_equalTo(CGSizeMake(W*0.1, H*0.03));
        }];
        
        self.authorLabel = [[UILabel alloc]init];
        self.authorLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.authorLabel];
        [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(H*0.01);
            make.left.equalTo(authortitleLabel.mas_right).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(W*0.6, H*0.03));
        }];
        
        UILabel *IDtitleLabel = [[UILabel alloc]init];
        IDtitleLabel.text = @"控制号:";
        IDtitleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:IDtitleLabel];
        [IDtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(authortitleLabel.mas_bottom).with.offset(H*0.01);
            make.left.equalTo(self).with.offset(W*0.1);
            make.size.mas_equalTo(CGSizeMake(W*0.15, H*0.03));
        }];
        
        self.IDLabel = [[UILabel alloc]init];
        self.IDLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.IDLabel];
        [self.IDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.authorLabel.mas_bottom).with.offset(H*0.01);
            make.left.equalTo(IDtitleLabel.mas_right).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(W*0.6, H*0.03));
        }];
    }
    return self;
}


@end
