//
//  WMPostWordController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/8/5.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMPostWordController.h"
#import "WMPulshTextView.h"
#import "WMAddTagbarView.h"
@interface WMPostWordController ()<UITextViewDelegate>

/**底部的工具条*/
@property (nonatomic,weak) WMAddTagbarView *addTagView;


/**textView*/
@property (nonatomic,weak) WMPulshTextView *textView;
@end

@implementation WMPostWordController

//- (WMAddTagbarView *)addTagView{
//    if (!_addTagView) {
//           }
//    return  _addTagView;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingNav];
    //设置textView
    [self settingTextView];
    
}

- (void)settingNav{
    
    self.view.backgroundColor = WMGlobalBg;
    self.title = @"发表文字";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self.navigationController.navigationBar layoutIfNeeded];

}

- (void)settingTextView{
   
    WMPulshTextView *textView = [[WMPulshTextView alloc] init];
    textView.frame = self.view.bounds;
  
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
     self.textView = textView;
    [self.view addSubview:textView];
    
    
    WMAddTagbarView *addTag = [WMAddTagbarView showAddTagBarView];
    addTag.y = self.view.height - addTag.height;
    addTag.width = self.view.width;
    [self.view addSubview:addTag];
    self.addTagView = addTag;
  
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}


- (void)keyboardDidChangeFrame:(NSNotification*)notification{
   CGRect keyBardF = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
   CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.addTagView.transform = CGAffineTransformMakeTranslation(0, keyBardF.origin.y - WMScreenH);
    }];
}

- (void)post{
    
    NSLog(@"%@",@"发送");
}



- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
