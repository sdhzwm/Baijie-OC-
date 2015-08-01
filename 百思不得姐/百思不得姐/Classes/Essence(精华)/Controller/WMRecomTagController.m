//
//  WMRecommendTagsController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/24.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMRecomTagController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "WMSubscribedTag.h"
#import "WMSubscirUserTagCell.h"
@interface WMRecomTagController ()
/**refView*/
@property (nonatomic,strong) UIView *headView;
/*数据模型*/
@property (nonatomic,strong) NSArray *refArr;
@end

@implementation WMRecomTagController
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
static NSString * SubscirUserTagID = @"SubscirUserTag";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = WMGlobalBg;
    self.title = @"推荐标签";
    self.tableView.rowHeight = 70;
    self.tableView.tableHeaderView = self.headView;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WMSubscirUserTagCell class]) bundle:nil] forCellReuseIdentifier:SubscirUserTagID];

    [self setUpLoad];
}

- (void)setUpLoad{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php"  parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject){
        self.refArr = [WMSubscribedTag objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败，请重新加载..."];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.refArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WMSubscirUserTagCell *cell = [tableView dequeueReusableCellWithIdentifier:SubscirUserTagID];
    WMSubscribedTag *subTag = self.refArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.subTag = subTag;
    return cell;
    
}

@end
