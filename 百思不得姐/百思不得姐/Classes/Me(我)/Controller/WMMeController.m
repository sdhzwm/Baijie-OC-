//
//  WMMeController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/8/4.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMMeController.h"
#import "WMMeCell.h"
#import "WMMeFootView.h"
@interface WMMeController ()

@end

@implementation WMMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setingNav];
    [self setingTableView];
}


- (void)setingNav{
    UIBarButtonItem *moon = [UIBarButtonItem initWithBackGroudImage:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" targer:self action:@selector(moon)];
    UIBarButtonItem *setting = [UIBarButtonItem initWithBackGroudImage:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click" targer:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItems = @[setting,moon];
    self.title = @"我的";
}
 static NSString *ID = @"meCell";
- (void)setingTableView{
    
    self.tableView.backgroundColor = WMGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    [self.tableView registerClass:[WMMeCell class] forCellReuseIdentifier:ID];
    
    self.tableView.tableFooterView = [[WMMeFootView alloc] init];
    
}

- (void)moon{
    NSLog(@"%@",@"哈哈");
    
}
- (void)setting{
    NSLog(@"%@",@"哈哈");
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    WMMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"Profile_noneAvatarBg"];
        cell.textLabel.text = @"登陆/注册";
    }else{
        cell.textLabel.text = @"离线下载";
    }
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSelector:@selector(descSelect) withObject:nil afterDelay:0.5f];
}

- (void)descSelect{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

@end
