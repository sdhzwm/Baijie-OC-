//
//  NSDate+Extension.h
//  百思不得姐
//
//  Created by 王蒙 on 15/7/27.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**是否是年*/
- (BOOL)isYear;
/**是否是今天*/
- (BOOL)isToDay;
/**是否是昨天*/
- (BOOL)isYesterDay;
/**判断当前时间与传来的时间是否一致*/
- (NSDateComponents *)deltaFrom:(NSDate *)from;
//将时间装换为本地时间
- (NSDate *)localeDate;
@end
