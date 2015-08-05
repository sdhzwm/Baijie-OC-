//
//  WMMeFootView.m
//  百思不得姐
//
//  Created by 王蒙 on 15/8/4.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMMeFootView.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "WMSquare.h"
#import <SVProgressHUD.h>
#import "WMMeButton.h"
#import "WMLoginController.h"
#import "WMMeWebController.h"
@implementation WMMeFootView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        parameters[@"a"] = @"square";
        parameters[@"c"] = @"topic";
        
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
           
            NSArray *square = [WMSquare objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            [self setingBtn:square];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"网络加载失败..."];
        }];
    }
    return self;
}


- (void)setingBtn:(NSArray*)squares{
    
    NSUInteger cols = 4;
   
    CGFloat btnW = WMScreenW / cols;
    CGFloat btnH = btnW;
    for (int i = 0; i < squares.count; i++) {
        WMMeButton *btn = [WMMeButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        btn.square = squares[i];
        NSUInteger col = i % cols;
        NSUInteger row = i/cols;
        
        btn.x = col *btnW;
        btn.y = row *btnH;
        btn.height = btnH;
        btn.width = btnW;
    }
    //计算总共的行数
    NSUInteger rows = (squares.count + cols - 1) / cols;
    
    self.height = rows *btnH;
    // 重绘
    [self setNeedsDisplay];
}


- (void)onClick:(WMMeButton *)btn{
    
    if ([btn.square.url hasPrefix:@"http"]) {
        //跳转到对应的网页
        WMMeWebController *webViewVC = [[WMMeWebController alloc] init];
        webViewVC.title = btn.square.name;
        webViewVC.url = btn.square.url;
        
        UITabBarController *tabbar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        

        UINavigationController *nav = (UINavigationController *)tabbar.selectedViewController;
    

        [nav pushViewController:webViewVC animated:YES];
      
        
    }else{
        WMLoginController *login = [[WMLoginController alloc] init];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:nil];
    }
}
@end
