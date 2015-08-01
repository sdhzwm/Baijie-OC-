//
//  WMSubscribedTagController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/24.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMSubscribedTagController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "WMSubscribedTag.h"
#import "WMSubscribedTagCell.h"
#import "WMRefHeadView.h"
#import "WMRecomTagController.h"
@interface WMSubscribedTagController ()<RefHeadViewDelegate>

/**推荐标签*/
@property (nonatomic,strong) NSArray *refArr;

/**已经订阅的标签*/
@property (nonatomic,strong) NSArray *defArr;


/**<#name#>*/
@property (nonatomic,strong) NSArray *dictArr;


/**搜索框*/
@property (nonatomic,strong) UIView *headView;


/**refView*/
@property (nonatomic,strong) WMRefHeadView *refView;
@end

@implementation WMSubscribedTagController

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        
        UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(5, 5, [UIScreen mainScreen].bounds.size.width-10, 30)];
        searchBar.barTintColor = [UIColor whiteColor];
        searchBar.placeholder = @"搜索";
        [_headView addSubview:searchBar];
        
    }
    return _headView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = WMGlobalBg;
    self.title = @"推荐标签";
    self.tableView.rowHeight = 70;
   // self.tableView.tableHeaderView = self.headView;
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushTagController)];
    btn.tintColor = WMRGBColor(131, 131, 131);
    self.navigationItem.rightBarButtonItem = btn;
    [self setUpLoad];
}

#pragma mark - 设置加载左侧信息
- (void)setUpLoad{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tags_list";
    parameters[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.defArr = [WMSubscribedTag objectArrayWithKeyValuesArray:responseObject[@"def_tags"]];
        self.refArr = [WMSubscribedTag objectArrayWithKeyValuesArray:responseObject[@"rec_tags"]];
       
        [self.tableView reloadData];

        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
    }];
    
}
- (void)headView:(WMRefHeadView *)refHead didOnclick:(UIButton *)btn{
    [self pushTagController];
}

- (void)pushTagController{
    WMRecomTagController *subscribedTag = [[WMRecomTagController alloc] init];
    
    [self.navigationController pushViewController:subscribedTag animated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
        return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count  = section == 0 ? self.refArr.count :self.defArr.count;

    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        WMSubscribedTag *subTag = (indexPath.section == 0) ? self.refArr[indexPath.row]:self.defArr[indexPath.row];
    
        NSString *state = (indexPath.section == 0) ? @"ref" :@"def";
    
        WMSubscribedTagCell *cell = [WMSubscribedTagCell subTagSuperTableView:tableView state:state];
        cell.subTag =  subTag;
        return cell;
 }

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectio{
    self.refView = [WMRefHeadView refHeadView];
    self.refView.delegate = self;
    self.refView.state = sectio==0 ?  @"ref": @"def";
    
    return self.refView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  section == 0 ? 10:1;
}


@end
