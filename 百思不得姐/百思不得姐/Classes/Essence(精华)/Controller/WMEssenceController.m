//
//  WMEssenceController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/22.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMEssenceController.h"
#import "WMSubscribedTagController.h"
#import "WMWordController.h"

@interface WMEssenceController ()<UIScrollViewDelegate>

/**保存按钮的状态*/
@property (nonatomic,weak) UIButton *seletedBtn;
/**保存按钮的状态*/
@property (nonatomic,strong) UIView   *redIndedicatorView;
/**保存按钮的状态*/
@property (nonatomic,weak) UIView   *titlesView;
/**uiScrollView*/
@property (nonatomic,weak) UIScrollView *conterView;
@end

@implementation WMEssenceController


- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setUpNavigation];
    [self setUpSubController];
    //设置标签栏
    [self setUpTitlesView];
    
    //添加ScrollView
    
    [self setUpScrollView];
}

- (void)setUpNavigation{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    UIBarButtonItem *item = [UIBarButtonItem initWithBackGroudImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" targer:self action:@selector(onClick)];
    self.navigationItem.leftBarButtonItem = item;

}

- (void)setUpSubController{
    WMWordController *sub4 = [[WMWordController alloc] init];
    sub4.title = @"图片";
    sub4.essenceType = EssenceTypePicture;
    [self addChildViewController:sub4];
       WMWordController *sub1 = [[WMWordController alloc] init];
      sub1.title = @"全部";
     sub1.essenceType = EssenceTypeAll;
    [self addChildViewController:sub1];
    WMWordController *sub2 = [[WMWordController alloc] init];
      sub2.title = @"视频";
     sub2.essenceType = EssenceTypeVideo;
    [self addChildViewController:sub2];
    WMWordController *sub3 = [[WMWordController alloc] init];
      sub3.title = @"声音";
     sub3.essenceType = EssenceTypeVoice;
    [self addChildViewController:sub3];
    WMWordController *sub = [[WMWordController alloc] init];
    sub.title = @"段子";
    sub.essenceType = EssenceTypeWord;
    [self addChildViewController:sub];

    
}
- (void)setUpTitlesView{
    //标签栏
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    
    [self setUpIndedicatorView];
    
    [self setUpSubBtn];
    
    [titlesView addSubview:self.redIndedicatorView];
}

- (void)setUpIndedicatorView{
    //红色的指示符
    UIView *redIndedicatorView = [[UIView alloc] init];
    redIndedicatorView.backgroundColor = [UIColor redColor];
    redIndedicatorView.height = 2;
    redIndedicatorView.y = self.titlesView.height - redIndedicatorView.height;
    self.redIndedicatorView = redIndedicatorView;
    }

- (void)setUpSubBtn{

    //内部子标签
    NSUInteger count = self.childViewControllers.count;
    CGFloat btnW = self.titlesView.width/count;
    CGFloat btnH = self.titlesView.height;
    
    for (NSUInteger i = 0; i<count; i++) {
        
        UIButton *btn = [[UIButton alloc] init];
        
        btn.tag = i;
        btn.height = btnH;
        btn.width = btnW;
        btn.x = i*btnW;
        
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [self.titlesView addSubview:btn];
        
        if (i==0) {
            btn.enabled = NO;
            self.seletedBtn = btn;
            [btn.titleLabel sizeToFit];
            self.redIndedicatorView.width = btn.titleLabel.width;
            self.redIndedicatorView.centerX = btn.centerX;
        }
        
    }

}

- (void)setUpScrollView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.width*self.childViewControllers.count,0);
    [self.view insertSubview:scrollView atIndex:0];
    self.conterView = scrollView;
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)titleClick:(UIButton*)btn{
    self.seletedBtn.enabled = YES;
    btn.enabled = NO;
    self.seletedBtn = btn;
    [UIView animateWithDuration:0.25 animations:^{
        self.redIndedicatorView.width = btn.titleLabel.width;
        self.redIndedicatorView.centerX = btn.centerX;
    }];
    
    CGPoint offset = self.conterView.contentOffset;
    offset.x = btn.tag * self.conterView.width;
    self.conterView.contentOffset = offset;
    [self scrollViewDidEndScrollingAnimation:self.conterView];

}

- (void)onClick{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Subscribed" bundle:nil];
    WMSubscribedTagController *subscri = [sb instantiateInitialViewController];
    
    [self.navigationController pushViewController:subscri animated:YES];
}

#pragma mark - delegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSUInteger atIndex = self.conterView.contentOffset.x /scrollView.width;
    UIViewController *sub = self.childViewControllers[atIndex];
    sub.view.x = scrollView.contentOffset.x;
    sub.view.y = 0;
    sub.view.height = scrollView.height;
    [scrollView addSubview:sub.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSUInteger atIndex = self.conterView.contentOffset.x / scrollView.width;
    
    [self titleClick:self.titlesView.subviews[atIndex]];

}



@end
