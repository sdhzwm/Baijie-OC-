//
//  WMCategoryCell.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/23.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMCategoryCell.h"
#import "WMCategory.h"
@interface WMCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *selectIdView;


@end
@implementation WMCategoryCell

- (void)awakeFromNib {
    self.backgroundColor = WMGlobalBg;
    self.selectIdView.backgroundColor = WMRGBColor(219, 21, 26);
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
     self.textLabel.y = 2;
    
    self.textLabel.height = self.contentView.height - 2*self.textLabel.y;
}

- (void)setCategory:(WMCategory *)category{
    _category = category;
    
    self.textLabel.text = category.name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectIdView.hidden = !self.selected;
    
    self.textLabel.textColor = selected ?self.selectIdView.backgroundColor :WMRGBColor(78, 78, 78);
}

@end
