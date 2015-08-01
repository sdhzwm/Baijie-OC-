//
//  WMSubscrbTag.h
//  百思不得姐
//
//  Created by 王蒙 on 15/7/24.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMSubscribedTag : NSObject


/**订阅数量*/
@property (nonatomic,assign) NSUInteger  sub_number;
/**订阅ID*/
@property (nonatomic,copy) NSString * theme_id;
/**图片标签地址*/
@property (nonatomic,copy) NSString * image_list;
/**明明*/
@property (nonatomic,copy) NSString * theme_name;
/**是否是子标签*/
@property (nonatomic,assign) NSUInteger is_sub;
/**是否是默认关注的标签*/
@property (nonatomic,assign) NSUInteger is_default;
@end
