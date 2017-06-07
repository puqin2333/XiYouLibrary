//
//  NSString+Extension.m
//  西邮图书馆
//
//  Created by 满脸胡茬的怪蜀黍 on 2017/1/9.
//  Copyright © 2017年 陈普钦. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize) sizeWithFont:(UIFont*)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
