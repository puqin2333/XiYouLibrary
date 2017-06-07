//
//  CCJSONModel.h
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/1/8.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CCJSONModel : NSObject

@property(nonatomic, retain) NSString *Date;
@property(nonatomic, copy) NSString *Title;
@property(nonatomic, copy) NSString *ID;
@property(nonatomic, assign) NSNumber *BorNum;
@property(nonatomic, copy)NSString *Barcode;
@property(nonatomic, copy) NSString *Type;
@property(nonatomic, copy) NSString *Department;
@property(nonatomic, copy) NSString *State;

@end

