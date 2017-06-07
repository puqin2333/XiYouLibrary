//
//  CCLognController.h
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/1/11.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCLognControlDelegate <NSObject>

- (void) loginSuccess:(NSString *)Session;

@end
@interface CCLognController : UIViewController
@property(nonatomic, weak) id<CCLognControlDelegate> delegate;

@end

@protocol CCLognControlDelegate <NSObject>

- (void) loginSuccess:(NSString *)Session;

@end
