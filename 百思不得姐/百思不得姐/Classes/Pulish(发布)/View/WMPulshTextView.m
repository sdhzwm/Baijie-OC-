//
//  WMPulshTextView.m
//  百思不得姐
//
//  Created by 王蒙 on 15/8/5.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMPulshTextView.h"

@interface WMPulshTextView()
/**标签*/
@property (nonatomic,weak) UILabel *placeholderLabel;
@end

@implementation WMPulshTextView

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        UILabel *placeholderText        = [[UILabel alloc] init];
            //自动换行
        placeholderText.numberOfLines   = 0;
        CGRect frame                    = placeholderText.frame;
        frame.origin.x                  = 5;
        frame.origin.y                  = 7;
        placeholderText.frame           = frame;
        
        [self addSubview:placeholderText];
        self.placeholderLabel           = placeholderText;

    }
    return  _placeholderLabel;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        //垂直方向
        self.alwaysBounceVertical = YES;
            //字体大小
        self.font                 = [UIFont systemFontOfSize:14];
            //占位颜色
        self.placeholderColor     = [UIColor grayColor];

        //占位文字的改变用的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];

    }
    return  self;
}

- (void)setPlaceholder: (NSString *)placeholder {

    _placeholder                    = [placeholder copy];
    self.placeholderLabel.text      = placeholder;
    [self updatePlaceholderFontSize];
}
/**重写占位字符的颜色*/
- (void)setPlaceholderColor: (UIColor *)placeholderColor {
    _placeholderColor               = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;

}
/**重写字体*/
- (void)setFont: (UIFont *)font {

    [super setFont:font];
    self.placeholderLabel.font      = font;
    [self updatePlaceholderFontSize];

}
/**重写text*/
- (void)setText: (NSString *)text {
    [super setText:text];
    //监听文本的改变
    [self textChange];
}
/**重写富文本*/
- (void)setAttributedText: (NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    //监听文本的改变
    [self textChange];
}

//监听文字改变

- (void)textChange {
    //如若有文字就隐藏
    self.placeholderLabel.hidden    = self.hasText;
}
/**更新占位文字的size*/
- (void)updatePlaceholderFontSize {

    CGFloat screenW                 = [UIScreen mainScreen].bounds.size.width;
    CGFloat placeholderX            = self.placeholderLabel.frame.origin.x;
    CGSize maxSize                  = CGSizeMake((screenW - 2 * placeholderX), MAXFLOAT);
    self.placeholderLabel.size      = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
}
@end
