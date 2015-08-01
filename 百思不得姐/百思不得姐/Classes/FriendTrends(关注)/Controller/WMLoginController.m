//
//  WMLoginController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/26.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMLoginController.h"

@interface WMLoginController ()
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginHorizonayoutContraint;

@end

@implementation WMLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)registerUserBtn:(UIButton*)sender {
    [self.view endEditing:YES];
    if (self.loginHorizonayoutContraint.constant == 0) {
        
        
        self.loginHorizonayoutContraint.constant = -self.view.width;
        NSLog(@"%f",self.loginHorizonayoutContraint.constant);

        sender.selected = YES;
    }else{
        self.loginHorizonayoutContraint.constant = 0;
         NSLog(@"%f",self.loginHorizonayoutContraint.constant);
        sender.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)closesBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
- (IBAction)loginOnClick:(id)sender {
    [self.view endEditing:YES];
}




@end
