//
//  NSString+WMExtension.m
//  百思不得姐
//
//  Created by 王蒙 on 15/8/8.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "NSString+WMExtension.h"

@implementation NSString (WMExtension)

- (int)convertToInt {
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

- (NSString *)LastByType:(NSString *)str {

    NSString *text = self;
    NSUInteger len = text.length;
    NSString *lastLetter = [text substringFromIndex:len - 1];
    if ([lastLetter isEqualToString:str]) {
        // 如果包含去除最后一个
        return [text substringToIndex:len - 1];
    
    }
    return  nil;
}



@end
