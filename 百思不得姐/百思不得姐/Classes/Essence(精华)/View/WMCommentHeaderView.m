//
//  WMCommentHeaderView.m
//  百思不得姐
//
//  Created by 王蒙 on 15/8/2.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMCommentHeaderView.h"


@interface WMCommentHeaderView()

/**文字标签*/
@property (nonatomic,weak) UILabel *titleLabel;

@end
@implementation WMCommentHeaderView

+ (instancetype)initHeaderViewWithTableView:(UITableView *)tableView{
    static NSString *ID = @"header";
    WMCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!header) {
        header = [[WMCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = WMGlobalBg;
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = WMRGBColor(67, 67, 67);
        label.width = 200;
        label.x = WMWordCellMargin;
        label.font = [UIFont systemFontOfSize:14];
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.titleLabel = label;

    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = [title copy];
    self.titleLabel.text = title;
}

@end
