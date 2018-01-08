//
//  WFProductCommentVC.m
//  ADSRouter
//
//  Created by Andy on 2017/11/7.
//

#import "WFProductCommentVC.h"
#import "WFProductCommentCell.h"
#import "WFUIComponent.h"
#import "WFProductComment.h"
#import "WFProductDataService.h"
#import "MJRefresh.h"

@interface WFProductCommentVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) WFProductDataService *dataService;
@property (nonatomic, strong) NSMutableArray<WFProductComment*> *comments;

@end

@implementation WFProductCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    __weak typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadCommentNextPage];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)loadData {
    _page = 1;
    _dataService = [WFProductDataService new];
    _comments = [NSMutableArray array];
    [self loadCommentNextPage];
}

- (void)loadCommentNextPage {
    __weak typeof(self) weakSelf = self;
    [_dataService getProductCommentWithProductId:_productId page:_page callback:^(NSArray<WFProductComment *> *comments) {
        ++weakSelf.page;
        [weakSelf.comments addObjectsFromArray:comments];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _comments.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WFProductCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:[WFProductCommentCell wf_reuseIdentifier] forIndexPath:indexPath];
    cell.productComment = _comments[indexPath.row];
    return cell;
}

- (void)setProductId:(NSString *)productId {
    _productId = productId;
    [self loadData];
}
@end
