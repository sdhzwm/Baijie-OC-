//
//  WMCategory.h
//  百思不得姐
//
//  Created by 王蒙 on 15/7/23.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMCategory : NSObject
/** id */
@property (nonatomic, assign) NSInteger id;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;

/**该关注下对应的用户*/
@property (nonatomic,strong) NSMutableArray *users;
/** 页数 */
@property (nonatomic, assign) NSInteger currentPage;
/** 总数 */
@property (nonatomic, assign) NSInteger total;

@end
