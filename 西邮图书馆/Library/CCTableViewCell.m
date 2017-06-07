//
//  CCTableViewCell.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/1/15.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "CCTableViewCell.h"
#import "Masonry.h"
#define kCCDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCCDeviceHeight [UIScreen mainScreen].bounds.size.height

@implementation CCTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]
    ;
    if(self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.contentView.mas_left).with.offset(5);
            make.top.equalTo(self.contentView.mas_top).with.offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(kCCDeviceWidth * 0.2);
        }];
        imageView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(imageView.mas_right).with.offset(20);
            make.top.equalTo(self.contentView.mas_top).with.offset(10);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(kCCDeviceWidth * 0.8);
        }];
        UILabel *typeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:typeLabel];
        [typeLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(imageView.mas_right).with.offset(20);
            make.top.equalTo(titleLabel.mas_top).with.offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(kCCDeviceWidth * 0.8);
        }];
        UILabel *dateLabel = [[UILabel alloc] init];
        [self.contentView addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(imageView.mas_right).with.offset(20);
            make.top.equalTo(typeLabel.mas_top).with.offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(kCCDeviceWidth * 0.8);
        }];
        UILabel *numberLabel = [[UILabel alloc] init];
        [self.contentView addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(imageView.mas_right).with.offset(20);
            make.top.equalTo(dateLabel.mas_top).with.offset(5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(kCCDeviceWidth * 0.8);
        }];


        
    }
    return self;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"message";
    CCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[CCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


@end
