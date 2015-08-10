//
//  WMPublishViewController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/30.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMPublishViewController.h"
#import <POP.h>
#import "WMCustomBtn.h"
#import "WMPostWordController.h"
#import "WMNavigationController.h"

#define screenSize [UIScreen mainScreen].bounds.size
@interface WMPublishViewController ()

@end

@implementation WMPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.userInteractionEnabled = NO;
    //设置按钮的数据
    NSArray *imageArr = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titleArr = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    //添加按钮
    if (imageArr.count == titleArr.count) {
        int maxCols = 3;
        CGFloat btnW = 72;
        CGFloat btnH = btnW + 30;
        CGFloat btnStartY = (screenSize.height - 2 *btnH)*0.5;
        CGFloat btnStartX = 20;
        CGFloat margin = (screenSize.width - 2 * btnStartX - maxCols * btnW)/(maxCols - 1);
        
        for (int i = 0; i<imageArr.count; i++) {
            
            WMCustomBtn *btn = [[WMCustomBtn alloc] init];
            
            [self setBtnTitleWithImage:btn title:titleArr[i] image:imageArr[i]];
            btn.tag = i;
            int row = i / maxCols;
            int col = i % maxCols;
            CGFloat btnX = btnStartX + col*(btnW + margin);
            CGFloat btnEndY = btnStartY + row * btnH;
            CGFloat btnBeginY = btnEndY - screenSize.height;
            
            
            POPSpringAnimation *pop = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
            pop.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnBeginY, btnW, btnH)];
            pop.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnEndY, btnW, btnH)];
            pop.springBounciness = 10;
            pop.springSpeed = 10;
            pop.beginTime = CACurrentMediaTime() + 0.1 * i;
            
            [btn pop_addAnimation:pop forKey:nil];
        }
      
        [self setSloganView:imageArr.count];
    }

}

- (void)setSloganView:(NSUInteger)imageCount {
    
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganView];
    
    // 标语动画
    POPSpringAnimation *popSlogan = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = screenSize.width * 0.5;
    CGFloat centerEndY = screenSize.height * 0.2;
    CGFloat centerBeginY = centerEndY - screenSize.height;
    popSlogan.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    popSlogan.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    popSlogan.beginTime = CACurrentMediaTime() + (imageCount - 3) * 0.1;
    popSlogan.springBounciness = 10;
    popSlogan.springSpeed = 10;
    [popSlogan setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        // 标语动画执行完毕, 恢复点击事件
        self.view.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:popSlogan forKey:nil];
    self.view.userInteractionEnabled = YES;

}

- (void)setBtnTitleWithImage:(UIButton*)btn title:(NSString*)title image:(NSString*)image {
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)onClick:(UIButton*)btn {
    //动画执行完毕后
    [self cancelWithCompletionBlock:^{
        if (btn.tag == 2) {
            WMPostWordController *post = [[WMPostWordController alloc] init];
            
            WMNavigationController *nav = [[WMNavigationController alloc] initWithRootViewController:post];
            
            UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
            
            [root presentViewController:nav animated:YES completion:nil];
            
        }
    }];
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self cancelWithCompletionBlock:nil];
}

- (IBAction)closeVc:(id)sender {
    [self cancelWithCompletionBlock:nil];
}

- (void)cancelWithCompletionBlock:(void (^)())completionBlock {
    self.view.userInteractionEnabled = NO;
    NSUInteger atIndex = 2;
    for (NSUInteger i = atIndex; i<self.view.subviews.count; i++) {
        UIView *subView = self.view.subviews[i];
        CGFloat centerY = subView.centerY + screenSize.height;
        
        POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        
        basic.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)];
        
        basic.beginTime = CACurrentMediaTime() + (i - atIndex) * 0.1;
        
        [subView pop_addAnimation:basic forKey:nil];
        
        if(i == self.view.subviews.count - 1){
            [basic setCompletionBlock:^(POPAnimation *basic, BOOL finish) {
                
                [self dismissViewControllerAnimated:NO completion:nil];
                
                !completionBlock ? : completionBlock();

                
            }];
        }
    }
}

@end
