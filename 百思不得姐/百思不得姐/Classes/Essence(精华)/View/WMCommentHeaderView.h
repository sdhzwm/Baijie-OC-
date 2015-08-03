//
//  WMCommentHeaderView.h
//  百思不得姐
//
//  Created by 王蒙 on 15/8/2.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMCommentHeaderView : UITableViewHeaderFooterView


+ (instancetype)initHeaderViewWithTableView:(UITableView *)tableView;

/**文字*/
@property (nonatomic,copy) NSString *title;
@end
