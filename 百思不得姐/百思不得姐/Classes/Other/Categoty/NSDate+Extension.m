//
//  NSDate+Extension.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/27.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

//与当前时间对比。
- (NSDateComponents *)deltaFrom:(NSDate *)from{
    //获取当前日历
    NSCalendar *component = [NSCalendar currentCalendar];
    //比较时间
    NSCalendarUnit unit =  NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    return [component components:unit fromDate:from toDate:self options:0];
}


- (BOOL)isYear{
    //获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //自己的时间
    NSUInteger selfDate = [calendar component:NSCalendarUnitYear fromDate:self];
    //当前时间
    NSUInteger currDate = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
   
    return  selfDate == currDate;
}

- (BOOL)isToDay{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //格式化时间
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    //传来的时间
    NSDate *currDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    
    return  selfDate == currDate;
}
/**思路是先格式化时间，分别获取到年月日，然后进行对比*/
- (BOOL)isYesterDay{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //格式化时间
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    //传来的时间
    NSDate *currDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *commponents = [calendar components:unit fromDate:selfDate toDate:currDate options:0];
    return  commponents.year == 0 && commponents.month == 0 && commponents.day == 1;
}
//将时间转化为当地时间
- (NSDate *)localeDate{
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: self];
    NSDate *localeDate = [self  dateByAddingTimeInterval: interval];
    
    return localeDate;
}
@end
