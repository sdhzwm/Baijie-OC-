//
//  WMCommentCell.h
//  百思不得姐
//
//  Created by 王蒙 on 15/8/3.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMComment;
@interface WMCommentCell : UITableViewCell

/**数据模型*/
@property (nonatomic,strong) WMComment *cmt;
@end
