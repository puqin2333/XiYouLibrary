//
//  CCBookdetailModel.h
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/2/18.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCCirculationModel.h"
#import "CCReferbooksModel.h"

@interface CCBookdetailModel : NSObject
@property(strong,nonatomic)NSString *Author;
@property(strong,nonatomic)NSString *Sort;
@property(strong,nonatomic)NSString *Pub;
@property(strong,nonatomic)NSString *FavTimes;
@property(strong,nonatomic)NSString *RentTimes;
@property(strong,nonatomic)NSString *Image;
@property(strong,nonatomic)NSString *Title;
@property(strong,nonatomic)NSString *Subject;
@property(strong,nonatomic)NSString *Total;
@property(strong,nonatomic)NSString *Avaliable;
@property(strong,nonatomic)NSValue *size;
@end
