//
//  WMSubscribedTagCell.h
//  百思不得姐
//
//  Created by 王蒙 on 15/7/24.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMSubscribedTag;

@interface WMSubscribedTagCell : UITableViewCell

/**数据模型*/
@property (nonatomic,strong) WMSubscribedTag *subTag;

+(instancetype)subTagSuperTableView:(UITableView *)tableView state:(NSString *)state;
@end
