//
//  WMCategoryCell.h
//  百思不得姐
//
//  Created by 王蒙 on 15/7/23.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMCategory;
@interface WMCategoryCell : UITableViewCell
/**模型*/
@property (nonatomic,strong) WMCategory *category;
@end
