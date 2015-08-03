//
//  WMCommentViewController.m
//  百思不得姐
//
//  Created by 王蒙 on 15/8/2.
//  Copyright (c) 2015年 wm. All rights reserved.
//

#import "WMCommentViewController.h"
#import "WMWordToip.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "WMComment.h"
#import "WMUser.h"
#import "WMAllEssenceCell.h"
#import "WMCommentHeaderView.h"
#import "WMCommentCell.h"
@interface WMCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstranint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**最热评论*/
@property (nonatomic,strong) NSArray *hotComments;
/**最新评论*/
@property (nonatomic,strong) NSMutableArray *lastComments;
/**用来保存帖子的评论数据*/
@property (nonatomic,strong)  NSArray *save_cmt;
/** 用来保存页数*/
@property (nonatomic,assign) NSUInteger page;

/**网络请求*/
@property (nonatomic,strong) AFHTTPSessionManager *manage;
@end

@implementation WMCommentViewController

- (AFHTTPSessionManager *)manage{

    if (!_manage) {
        _manage = [AFHTTPSessionManager manager];
    }
    return  _manage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置系统用的方法
    [self settingTableView];
    //设置headerView
    [self settingHeaderView];
    [self setingRefresh];
    
}
#pragma mark - 一些系统设置
static NSString *ID = @"comentCell";
- (void)settingTableView{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithBackGroudImage:@"comment_nav_item_share_icon" highlightedImage:@"comment_nav_item_share_icon_click" targer:nil action:nil];
    self.tableView.backgroundColor = WMGlobalBg;
    
    self.tableView.estimatedRowHeight = 64;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, WMWordCellMargin, 0);

    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WMCommentCell class]) bundle:nil] forCellReuseIdentifier:ID];
    //键盘监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
  //  [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
}
//设置headerView
- (void)settingHeaderView{
    UIView *headerView = [[UIView alloc] init];
    if(self.wordToip.top_cmt){
        self.save_cmt = self.wordToip.top_cmt;
        self.wordToip.top_cmt = nil;
        [self.wordToip setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    WMAllEssenceCell *allCell = [WMAllEssenceCell initWithCell];
    allCell.wordToip = self.wordToip;
    allCell.size = CGSizeMake(WMScreenW, self.wordToip.cellHeight);
    [headerView addSubview:allCell];
    headerView.height = self.wordToip.cellHeight;
    
    self.tableView.tableHeaderView = headerView;
}
//简单的代理通知
- (void)keyboardChange:(NSNotification*)notification{
    CGSize size = [UIScreen mainScreen].bounds.size;
    //键盘显示隐藏的frame
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //修改底部的约束
    self.bottomConstranint.constant = size.height - frame.origin.y;
    //获取键盘升起退出的的动画时间
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
//- (void)tap{
//    [self.view endEditing:YES];
//}
//代理方法销毁注册的通知
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.save_cmt) {
        self.wordToip.top_cmt = self.save_cmt;
        [self.wordToip setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    [self.manage invalidateSessionCancelingTasks:YES];
}
#pragma mark - 设置刷新控件

- (void)setingRefresh{
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self  refreshingAction:@selector(loadNewComments)];
    [self.tableView.header beginRefreshing];
}

#pragma mark - 网络请求

- (void)loadNewComments{
    
    //取消之前的所有网络请求
    [self.manage.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.wordToip.ID;
    params[@"hot"] = @"1";
    
    [self.manage GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]){
            [self.tableView.header endRefreshing];
            return;
        }
        self.hotComments = [WMComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.lastComments = [WMComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
       
        [self.tableView reloadData];
        self.page = 1;
        [self.tableView.header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.header endRefreshing];
    }];
   
}
- (void)loadMoreComments{
    
    //取消之前的所有网络请求
    [self.manage.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSUInteger page = self.page + 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.wordToip.ID;
    params[@"page"] = @(page);
    WMComment *cmt = [self.lastComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manage GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]){
        
            [self.tableView.footer endRefreshing];
            return;
        }
        NSArray *lastCmt = [WMComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.lastComments addObjectsFromArray:lastCmt];
        self.page = page + 1;
        [self.tableView reloadData];
        //控制foot的状态
        NSUInteger total = [responseObject[@"total"]integerValue];
        if (self.lastComments.count >= total) {
            self.tableView.footer.hidden = YES;
        }else{
            [self.tableView.footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.footer endRefreshing];
    }];
    
}



#pragma mark - 为代理方法服务的方法
//根据出来的行数来获取对应的模型--->先得到对应的数组
- (WMComment *)commentInIndexPath:(NSIndexPath *)indexPath{
    return [self commentInSection:indexPath.section][indexPath.row];
}
//根据传来的section来判断是哪个分组
- (NSArray *)commentInSection:(NSUInteger)section{
    if (section == 0) {
        return  self.hotComments.count ? self.hotComments : self.lastComments;
    }
    return self.lastComments;
}
#pragma mark - 代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    NSUInteger hotCount = self.hotComments.count;
    NSUInteger lastCount = self.lastComments.count;
  
    if(hotCount) return 2;
    if(lastCount)return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSUInteger hotCount = self.hotComments.count;
    NSUInteger lastCount = self.lastComments.count;
    self.tableView.footer.hidden = (lastCount == 0);
    if(section == 0){
        return hotCount ? hotCount : lastCount;
    }
    return lastCount;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WMCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    WMComment *cmt = [self commentInIndexPath:indexPath];
    cell.cmt = cmt;
    return cell;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    WMCommentHeaderView *header = [WMCommentHeaderView initHeaderViewWithTableView:tableView];
    //设置header
    NSUInteger hotCount = self.hotComments.count;
    if (section == 0) {
         header.title = hotCount ? @"最热评论":@"最新评论";
    }else{
        header.title = @"最新评论";
    }
    return header;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }else{
       
       
        WMCommentCell *cell = (WMCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
         //当前选中为第一响应者
        
         [cell becomeFirstResponder];
        
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replayHf = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replayHf:)];
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
      
        menu.menuItems = @[ding,replayHf,report];
        
        CGRect rect = CGRectMake(-20, cell.height*0.6, cell.width, cell.height*0.5);
        
      
        [menu setTargetRect:rect inView:cell];
        
        [menu setMenuVisible:YES animated:YES];
    }
}

- (void)ding:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}

- (void)replayHf:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}

- (void)report:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}

@end
