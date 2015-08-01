//
//  WMGRecommendController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/22.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMRecommendController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "WMCategoryCell.h"
#import "WMCategoryUserCell.h"
#import "WMCategory.h"
#import "WMCategoryUsers.h"

@interface WMRecommendController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryUserTableView;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/**模型数组*/
@property (nonatomic,strong) NSArray *categorys;
@property (nonatomic, strong) NSMutableDictionary *params;
/** AFN请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation WMRecommendController
/**左侧cell标识符*/
static NSString *const WMCategorysId = @"WMCategorysId";
/**右侧cell标识符*/
static NSString *const WMCategorysUserId = @"WMCategorysUserId";

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐关注";
    [self setUpTableView];
    [self setUpLoad];
    
}
#pragma mark - 设置表格信息
- (void)setUpTableView{
    self.view.backgroundColor = WMGlobalBg;
    //取消系统自带的Inset并且自己设置
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.categoryUserTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    //注册cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([WMCategoryCell class]) bundle:nil] forCellReuseIdentifier:WMCategorysId];
    
    [self.categoryUserTableView registerNib:[UINib nibWithNibName:NSStringFromClass([WMCategoryUserCell class]) bundle:nil] forCellReuseIdentifier:WMCategorysUserId];
    //设置右侧的行高
    self.categoryUserTableView.rowHeight = 70;
    
    //加载上拉的及下拉的控件
    self.categoryUserTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
     self.categoryUserTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.categoryUserTableView.footer.hidden = YES;
}
#pragma mark - 设置加载左侧信息
- (void)setUpLoad{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        self.categorys = [WMCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.categoryTableView reloadData];
        
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        [self.categoryUserTableView.header beginRefreshing];
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
    }];
    
}
#pragma mark - 加载下拉刷新信息及程序左侧的点击
- (void)loadNewData{
    WMCategory *category = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];
    category.currentPage = 1;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(category.id);
    
    parameters[@"page"] = @(category.currentPage);
    
    self.params = parameters;
    
    [ self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *user = [WMCategoryUsers objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
        if (self.params != parameters) return;
        [category.users removeAllObjects];
        
        [category.users addObjectsFromArray:user];
        
        //保存总数
        category.total = [responseObject[@"total"] integerValue];
        // 刷新右边的表格
        [self.categoryUserTableView reloadData];
        [self.categoryUserTableView.header endRefreshing];
       
        [self checkFootHidden];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.params = parameters;
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
        [self.categoryUserTableView.header endRefreshing];
    }];
}
#pragma mark - 加载程序的上拉刷新
- (void)loadMoreUsers{
    
    WMCategory *category = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(category.id);
    parameters[@"page"] = @(++category.currentPage);
   
    self.params = parameters;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *user = [WMCategoryUsers objectArrayWithKeyValuesArray:responseObject[@"list"]];
      
         if (self.params != parameters) return;
        
        [category.users addObjectsFromArray:user];
        // 刷新右边的表格
        [self.categoryUserTableView reloadData];
        
        
        [self checkFootHidden];
       
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.params = parameters;
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
        [self.categoryUserTableView.footer endRefreshing];
    }];


}
#pragma mark - 检查是否foot的状态
- (void)checkFootHidden{
    
    WMCategory *category = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];

    self.categoryUserTableView.footer.hidden = (category.users.count == 0);
    
    //如果当前数量与总数相等的话就隐藏
    if(category.users.count == category.total){
        
        [self.categoryUserTableView.footer noticeNoMoreData];
       
    }else{
        
        [self.categoryUserTableView.footer endRefreshing];
    }
}
#pragma mark - UITableViewDeledate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryTableView) {
        
         return self.categorys.count;
    
    }else{
        
        [self checkFootHidden];
        WMCategory *category = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];
        
        
        return category.users.count;
    }
   
}
/**cell的显示*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableView) {
        
        WMCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:WMCategorysId];
        
        cell.category = self.categorys[indexPath.row];
        
        return cell;
    }else{
        
        WMCategoryUserCell *cell = [tableView dequeueReusableCellWithIdentifier:WMCategorysUserId];
        
        WMCategory *category = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];
        
        cell.user = category.users[indexPath.row];
        return cell;
    }
}
/**左侧的点击事件，后期会加上右侧的点击*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.categoryUserTableView.footer endRefreshing];
    [self.categoryUserTableView.header endRefreshing];
    
    WMCategory *category = self.categorys[indexPath.row];
    
    if (category.users.count) {
        [self.categoryUserTableView reloadData];
    }else{
            // 刷新右边的表格
        [self.categoryUserTableView reloadData];
            
        [self.categoryUserTableView.header beginRefreshing];

    }
    
}
- (void)dealloc{

    [self.manager.operationQueue cancelAllOperations];
}
@end
