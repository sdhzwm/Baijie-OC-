//
//  NSString+WMExtension.h
//  百思不得姐
//
//  Created by 王蒙 on 15/8/8.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WMExtension)
/**判断中英文的长度*/
- (int)convertToInt;
/**判断字符串是否包含传入的符号*/
- (NSString *)LastByType:(NSString *)str;
@end
