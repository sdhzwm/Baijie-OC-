//
//  WMCategory.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/23.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMCategory.h"

@implementation WMCategory

- (NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
