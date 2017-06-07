//
//  CCCirculationCell.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/2/17.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "CCCirculationCell.h"
#import "Masonry.h"
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height

@implementation CCCirculationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *barcodeLabel = [[UILabel alloc]init];
        barcodeLabel.text = @"条码:";
        barcodeLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:barcodeLabel];
        [barcodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.left.equalTo(self).with.offset(W*0.1);
            make.size.mas_equalTo(CGSizeMake(W*0.1, H*0.03));
        }];
        
        self.barcodeLabel = [[UILabel alloc]init];
        self.barcodeLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.barcodeLabel];
        [self.barcodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.left.equalTo(barcodeLabel.mas_right).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(W*0.6, H*0.03));
        }];
        
        UILabel *stateLabel = [[UILabel alloc]init];
        stateLabel.text = @"状态:";
        stateLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:stateLabel];
        [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(barcodeLabel.mas_bottom).with.offset(H*0.01);
            make.left.equalTo(self).with.offset(W*0.1);
            make.size.mas_equalTo(CGSizeMake(W*0.1, H*0.03));
        }];
        
        self.stateLabel = [[UILabel alloc]init];
        self.stateLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.stateLabel];
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.barcodeLabel.mas_bottom).with.offset(H*0.01);
            make.left.equalTo(stateLabel.mas_right).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(W*0.6, H*0.03));
        }];
        
        UILabel *departmentLabel = [[UILabel alloc]init];
        departmentLabel.text = @"所在书库:";
        departmentLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:departmentLabel];
        [departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(stateLabel.mas_bottom).with.offset(H*0.01);
            make.left.equalTo(self).with.offset(W*0.1);
            make.size.mas_equalTo(CGSizeMake(W*0.2, H*0.03));
        }];
        
        self.departmentLabel = [[UILabel alloc]init];
        self.departmentLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.departmentLabel];
        [self.departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.stateLabel.mas_bottom).with.offset(H*0.01);
            make.left.equalTo(departmentLabel.mas_right).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(W*0.6, H*0.03));
        }];
        
        self.datetitleLabel = [[UILabel alloc]init];
        self.datetitleLabel.text = @"应还日期:";
        self.datetitleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.datetitleLabel];
        [self.datetitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(departmentLabel.mas_bottom).with.offset(H*0.01);
            make.left.equalTo(self).with.offset(W*0.1);
            make.size.mas_equalTo(CGSizeMake(W*0.2, H*0.03));
        }];
        
        self.dateLabel = [[UILabel alloc]init];
        self.dateLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.departmentLabel.mas_bottom).with.offset(H*0.01);
            make.left.equalTo(self.datetitleLabel.mas_right).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(W*0.6, H*0.03));
        }];
    }
    return self;
}


@end
