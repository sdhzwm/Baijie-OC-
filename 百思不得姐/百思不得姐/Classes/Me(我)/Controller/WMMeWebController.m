//
//  WMMeWebController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/8/4.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMMeWebController.h"
#import <NJKWebViewProgress.h>
@interface WMMeWebController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBack;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForWard;

@end

@implementation WMMeWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}
- (IBAction)goBack:(id)sender {
    
    [self.webView goBack];
}
- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}
- (IBAction)refresh:(id)sender {
    [self.webView reload];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.goBack.enabled = webView.canGoBack;
    self.goForWard.enabled = webView.canGoForward;
}


@end
