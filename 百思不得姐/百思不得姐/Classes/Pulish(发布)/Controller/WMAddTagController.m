//
//  WMAddTagController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/8/7.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMAddTagController.h"
#import "WMTextTagButton.h"
#import "WMTabTextFiled.h"
#import <SVProgressHUD.h>
@interface WMAddTagController () <UITextFieldDelegate>
/**contentView*/
@property (nonatomic,weak  ) UIView         *contentView;
/**用来添加textFiled的views*/
@property (nonatomic,weak  ) UIView         *addTextView;
/**textFile*/
@property (nonatomic,weak  ) WMTabTextFiled *textField;
/**添加按钮*/
@property (nonatomic,weak  ) UIButton       *addButton;
/**标签组*/
@property (nonatomic,strong) NSMutableArray *tagBtnArr;

@end


@implementation WMAddTagController

#pragma mark - 懒加载
- (NSMutableArray *)tagBtnArr{
    if (!_tagBtnArr) {
        _tagBtnArr = [NSMutableArray array];
    }
    return _tagBtnArr;
}
- (UIView *)contentView {

    if (!_contentView) {
        UIView *contentView = [[UIView alloc] init];
        
        [self.view addSubview:contentView];
        self.contentView = contentView;
    }
    return _contentView;
}

 - (UIView *)addTextView {
    
    if (!_addTextView) {
        UIView *addTextView = [[UIView alloc] init];
        
        [self.contentView addSubview:addTextView];
        self.addTextView = addTextView;
    }
    return _addTextView;
}
//设置textFiled
- (WMTabTextFiled *)textField {
    if (!_textField) {
        WMTabTextFiled *textFile = [[WMTabTextFiled alloc] init];
        textFile.delegate = self;
        __weak typeof(self) weakSelf = self;
        textFile.delegateBlock = ^{
            if (weakSelf.textField.hasText)return ;
            
            [weakSelf removeBtn:[weakSelf.tagBtnArr lastObject]];
            
        };
        
        [textFile addTarget:self action:@selector(textDisChange) forControlEvents:UIControlEventEditingChanged];
        self.addTextView.height = CGRectGetMaxY(textFile.frame);
        [self.addTextView addSubview:textFile];
        self.textField = textFile;
        
    }
    return _textField;
}

- (UIButton *)addButton {
    if (!_addButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.width = self.contentView.width;
        button.height = 30;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, WMWordCellMargin, 0, WMWordCellMargin);
        button.backgroundColor = WMGlobalBg;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addTextTagButton) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:button];
        self.addButton = button;
    }
    return _addButton;
}
#pragma mark - viewDidLoad及ViewWillAppear
- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingNav];
 
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
    
}
#pragma mark - 设置nav以及textfiled
//设置导航条内容
- (void)settingNav {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dome)];
}
- (void)setupTags
{
    if (self.tags.count) {
        for (NSString *tag in self.tags) {
            self.textField.text = tag;
            [self addTextTagButton];
        }
        self.tags = nil;
    }
}

#pragma mark - action -- target方法
//当文字改变之后的操作
- (void)textDisChange {
    
    
    [self updateTextFiledFrame];
    
    if (self.textField.hasText) {
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.addTextView.frame) + 10;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签:%@",self.textField.text] forState:UIControlStateNormal];
       
        NSString *lastText = [self.textField.text LastByType:@","];
        
        if (lastText != nil) {
            self.textField.text = lastText;
            [self addTextTagBtn];
            [self.textField resignFirstResponder];
            [self.textField becomeFirstResponder];
           
            return;
        }
        
        if ([self.textField.text convertToInt] >= 15) {
           
            [self addTextTagBtn];
            [self.textField resignFirstResponder];
            [self.textField becomeFirstResponder];
            
            return;
        }

    }else {
        self.addButton.hidden = YES;
    }
   
}

//点击标签按钮
- (void)addTextTagButton {
  
    [self addTextTagBtn];

}
//添加标签按钮
- (void)addTextTagBtn {
    
    if (self.tagBtnArr.count >=5){
        [SVProgressHUD showErrorWithStatus:@"最多只能添加5个" maskType:SVProgressHUDMaskTypeBlack];
        
        return;
    }
    
    WMTextTagButton *btn = [WMTextTagButton buttonWithType:UIButtonTypeCustom];
   
    [btn setTitle:self.textField.text forState:UIControlStateNormal];

    [btn addTarget:self action:@selector(removeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.addTextView addSubview:btn];
    [self.tagBtnArr addObject:btn];
    //更新这些btn
    [self updateAddTagButtonFrame];
    //清空
    self.textField.text = @"";
    self.addButton.hidden = YES;

}

- (void)removeBtn:(WMTextTagButton *)btn{
    [btn removeFromSuperview];
    [self.tagBtnArr removeObject:btn];
    [self updateAddTagButtonFrame];
}
#pragma mark - 更新布局的相关方法

/**
 * 布局控制器view的子控件
 */
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.contentView.x = WMTagMargin;
    self.contentView.width = self.view.width - 2 * self.contentView.x;
    self.contentView.y = 64 + WMTagMargin;
    self.contentView.height = WMScreenH;
    
    self.addTextView.x = WMWordCellMargin;
    self.addTextView.width = self.contentView.width - 2*WMWordCellMargin;
    self.textField.width = self.contentView.width;
    [self setupTags];
}
//更新按钮的布局
- (void)updateAddTagButtonFrame {
    
    for (int i = 0; i < self.tagBtnArr.count; i++) {
        WMTextTagButton *btn = self.tagBtnArr[i];
        if (i == 0) {
            btn.x = 0;
            btn.y = 0;
        }else {
            WMTextTagButton *lastBtn = self.tagBtnArr[i - 1];
            //计算当前行左边的宽度
            CGFloat leftWith  = CGRectGetMaxX(lastBtn.frame) + WMTagMargin;
            //计算当前行右边的宽度
            CGFloat rightWith = self.addTextView.width - leftWith;
            
            if (rightWith >= btn.width) {
                btn.y = lastBtn.y;
                btn.x = leftWith;
            }else {
                btn.x = 0;
                btn.y = CGRectGetMaxY(lastBtn.frame) + WMTagMargin;
            }
        }
    }
    [self updateTextFiledFrame];
    
}
//更新文字布局
- (void)updateTextFiledFrame {

    WMTextTagButton *lastBtn = [self.tagBtnArr lastObject];

    CGFloat leftWith         = CGRectGetMaxX(lastBtn.frame) + 10;

    if ((self.addTextView.width - leftWith) >= [self textFieldTextWidth]) {
        self.textField.y         = lastBtn.y;
        self.textField.x         = leftWith;
    }else {
        self.textField.x         = 0;
        self.textField.y         = CGRectGetMaxY(lastBtn.frame) + 5;
    }

    self.addTextView.height  = CGRectGetMaxY(self.textField.frame);


}
//获取文字的宽度
- (CGFloat)textFieldTextWidth {
    CGFloat textWith = [self.textField.text sizeWithAttributes:@{NSFontAttributeName:self.textField.font}].width;
    return MAX(100, textWith);
}

- (void)dome {
    
    NSArray *tags = [self.tagBtnArr valueForKeyPath:@"currentTitle"];
    
    !self.tagsBlock ? :self.tagsBlock(tags);
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.hasText) {
        [self addTextTagBtn];
    }
    return YES;
}
@end
