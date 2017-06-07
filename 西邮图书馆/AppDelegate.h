//
//  AppDelegate.h
//  西邮图书馆
//
//  Created by 陈普钦 on 16/11/14.
//  Copyright (c) 2016年 陈普钦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(assign,nonatomic)BOOL islogin;
@property(copy,nonatomic)NSString *Session;

@end

