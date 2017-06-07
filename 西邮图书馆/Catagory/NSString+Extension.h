//
//  NSString+Extension.h
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/1/9.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)
// 给NSString这个类添加一个分类，让NSString这个类增加一个计算字符串尺寸的方法

- (CGSize) sizeWithFont:(UIFont*)font maxSize:(CGSize)maxSize;



@end
