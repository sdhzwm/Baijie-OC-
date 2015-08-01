//
//  WMTableViewController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/7/27.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMWordController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "WMWordToip.h"
#import "WMAllEssenceCell.h"

@interface WMWordController ()

/**模型*/
@property (nonatomic,strong) NSMutableArray *words;

/**加载帖子关键字*/
@property (nonatomic,copy) NSString *maxtime;


/**页数*/
@property (nonatomic,assign) NSUInteger page;
@end

@implementation WMWordController


- (NSMutableArray *)words{
    if (!_words) {
        _words = [NSMutableArray array];
    }
    return _words;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    [self setUpRefresh];
    
}
static NSString *allWord = @"allWordId";

- (void)setUpTableView{
    
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = WMTitilesViewY + WMTitilesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor clearColor];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WMAllEssenceCell class]) bundle:nil] forCellReuseIdentifier:allWord];

}

- (void)setUpRefresh{
    
     self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(setLoadNewData)];
     self.tableView.header.autoChangeAlpha = YES;
     [self.tableView.header beginRefreshing];

     self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(setLoadMoreDate)];
    
}


- (void)setLoadNewData{
    
    [self.tableView.footer endRefreshing];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.essenceType);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject){
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.words = [WMWordToip objectArrayWithKeyValuesArray:responseObject[@"list"]];
       
        [self.tableView reloadData];
        
        [self.tableView.header endRefreshing];
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         [self.tableView.header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
    }];
    
}


- (void)setLoadMoreDate{
    
    [self.tableView.header endRefreshing];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.essenceType);
    NSInteger page = self.page + 1;
    parameters[@"page"] = @(page);
    parameters[@"maxtime"] = self.maxtime;
    
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject){
       
        NSLog(@"%@",self.maxtime);
        NSArray *words = [WMWordToip objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.words addObjectsFromArray:words];
        
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
        self.page = page;
        
       
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.footer.hidden = (self.words.count == 0);
        return self.words.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WMAllEssenceCell *cell = [tableView dequeueReusableCellWithIdentifier:allWord];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WMWordToip *word = self.words[indexPath.row];
    
    cell.wordToip = word;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    WMWordToip *toip = self.words[indexPath.row];
    
    return toip.cellHeight;
}


@end
