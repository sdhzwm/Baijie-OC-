//
//  WMAddTagbarView.m
//  百思不得姐
//
//  Created by 王蒙 on 15/8/7.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMAddTagbarView.h"
#import "WMAddTagController.h"
@interface WMAddTagbarView()

@property (weak, nonatomic) IBOutlet UIView *topView;
/** 存放所有的标签label */
@property (nonatomic, strong) NSMutableArray *tagLabels;
/**添加的按钮*/
@property (nonatomic,weak) UIButton *addBtn;
@end

@implementation WMAddTagbarView

- (NSMutableArray *)tagLabels {
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

+ (instancetype)showAddTagBarView {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    btn.size      = btn.currentImage.size;
    btn.x         = WMWordCellMargin;

    [btn addTarget:self action:@selector(addTagClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:btn];
    self.addBtn = btn;
    
    // 默认就拥有2个标签
    [self createTagLabels:@[@"吐槽", @"糗事"]];
}


- (void)addTagClick {
    
    WMAddTagController *addTag  = [[WMAddTagController alloc] init];
    __weak typeof(self) weakSelf = self;
    
    [addTag setTagsBlock:^(NSArray *tags) {
        [weakSelf createTagLabels:tags];
    }];
    addTag.tags = [self.tagLabels valueForKeyPath:@"text"];
    UITabBarController *tabbar  = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabbar.presentedViewController;
    [nav pushViewController:addTag animated:YES];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i<self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
        
        // 设置位置
        if (i == 0) {
            tagLabel.x = 5;
            tagLabel.y = 0;
        } else {
            UILabel *lastTagLabel = self.tagLabels[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + (WMWordCellMargin-5);
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= tagLabel.width) {
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftWidth;
            } else { // 按钮显示在下一行
                tagLabel.x = 5;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + (WMWordCellMargin-5);
            }
        }
    }
    
    // 最后一个标签
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + (WMWordCellMargin-5);
    
    // 更新textField的frame
    if (self.topView.width - leftWidth >= self.addBtn.width) {
        self.addBtn.y = lastTagLabel.y;
        self.addBtn.x = leftWidth;
    } else {
        self.addBtn.x = 0;
        self.addBtn.y = CGRectGetMaxY(lastTagLabel.frame) + (WMWordCellMargin-5);
    }
    
    // 整体的高度
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addBtn.frame) + 45;
    self.y -= self.height - oldH;
}

- (void)createTagLabels:(NSArray *)tags
{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (int i = 0; i<tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.backgroundColor = WMRGBColor(115, 183, 240);
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = [UIFont systemFontOfSize:14];
        // 先设置文字和字体，再进行计算
        [tagLabel sizeToFit];
        tagLabel.width += 2 * 5;
        tagLabel.height = 25;
        tagLabel.textColor = [UIColor whiteColor];
        tagLabel.layer.cornerRadius = tagLabel.width * 0.05;
        tagLabel.layer.masksToBounds = YES;
        [self.topView addSubview:tagLabel];
    }
    
    // 重新布局子控件
    [self setNeedsLayout];
}
@end
