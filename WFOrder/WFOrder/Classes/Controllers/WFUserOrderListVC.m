//
//  WFUserOrderListVC.m
//  ADSRouter
//
//  Created by Andy on 2017/11/21.
//

#import "WFUserOrderListVC.h"
#import "WFUIComponent.h"
#import "Masonry.h"
#import "WFOrder.h"
#import "WFOrderListCell.h"
#import "WFOrderListHeader.h"
#import "WFOrderFooter.h"
#import "MJRefresh.h"
#import "ADSRouter.h"


typedef enum : NSUInteger {
    WFPageStateNormal,
    WFPageStateNoData,
} WFPageSate;

@interface WFUserOrderListVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *userId;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) WFPageSate pageSate;

@property (nonatomic, strong) WFOrderDataService *orderDataService;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray<WFOrder*> *orders;

@end

@implementation WFUserOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _tableView.hidden = !_orders ||  _orders.count == 0;
}

- (void)setUpUI {
    self.view.backgroundColor = [UIColor wf_mainBackgroundColor];
    
    [self setUpDefaultText];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    __weak typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf loadNextPage];
    }];
}

- (void)loadData {
    __weak typeof(self) weakSelf = self;
    _page = 1;
    _orders = [NSMutableArray array];
    [self.orderDataService getOrdersWithOrderType:_listType page:_page callback:^(NSArray<WFOrder *> *orders) {
        [weakSelf addOrders:orders];
    }];
}

- (void)loadNextPage {
    __weak typeof(self) weakSelf = self;
    ++_page;
    [self.orderDataService getOrdersWithOrderType:_listType page:_page callback:^(NSArray<WFOrder *> *orders) {
        [weakSelf addOrders:orders];
    }];
}

- (void)addOrders:(NSArray<WFOrder *>*) orders {
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
    [_orders addObjectsFromArray:orders];
    [_tableView reloadData];
    if (_orders.count != 0)
        _tableView.hidden = NO;

}



- (void)setUpDefaultText {
    UILabel *label = [UILabel new];
    label.text = @"此处没有订单";
    label.textColor = [UIColor wf_placeHolderColor];
    label.font = [UIFont wf_pfr15];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view insertSubview:label belowSubview:_tableView];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY);
        make.left.right.mas_equalTo(self.view);
    }];
}

- (void)setPageSate:(WFPageSate)pageSate {
    _tableView.hidden = (pageSate == WFPageStateNoData);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _orders.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _orders[section].products.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WFOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:[WFOrderListCell wf_reuseIdentifier] forIndexPath:indexPath];
    cell.product = _orders[indexPath.section].products[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return .01f;
    }
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    WFOrderListFooter *footer = [self footerFactory:section];
    CGSize size = [footer systemLayoutSizeFittingSize:CGSizeMake(CGRectGetWidth(self.tableView.frame), 1.f) withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
    return size.height;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    WFOrderListFooter *footer = [self footerFactory:section];
    return footer;
}

- (WFOrderListFooter*)footerFactory:(NSInteger)section {
    WFOrder *order = _orders[section];
    __block WFOrderListFooter *footer;
    __weak typeof(self) weakSelf = self;
    if (order.orderState == WFOrderStateUnpayed) {
        footer = [WFUnpayOrderFooter new];
        footer.leftBtnClickedBlk = ^{
            [[ADSRouter sharedRouter] openUrlString:[NSString stringWithFormat:@"wfshop://pay?orderId=%@", weakSelf.orders[section].orderId]];
        };
        footer.rightBtnClickedBlk = ^{
            WFAskSomething(@"", @"请确认取消订单", weakSelf, ^{
                [weakSelf.orderDataService deleteOrder:weakSelf.orders[section].orderId callback:^(BOOL success) {
                    WFShowHud(@"取消成功", weakSelf.view, 1);
                    [weakSelf loadData];
                }];
            }, nil);
        };
    } else if (order.orderState == WFOrderStateUncheck) {
        __weak typeof(self) weakSelf = self;
        footer = [WFUncheckOrderFooter new];
        footer.leftBtnClickedBlk = ^{
            WFAskSomething(@"", @"请确认已经收到货品", weakSelf, ^{
                [weakSelf.orderDataService confirmOrder:weakSelf.orders[section].orderId callback:^(BOOL success) {
                    WFShowHud(@"确认成功", weakSelf.view, 1);
                    [weakSelf loadData];
                }];
            }, nil);
        };
    } else if (order.orderState == WFOrderStateUncomment) {
        footer = [WFUncommentOrderFooter new];
        footer.leftBtnClickedBlk = ^{
            [[ADSRouter sharedRouter] openUrlString:[NSString stringWithFormat:@"wfshop://comment?orderId=%@", weakSelf.orders[section].orderId]];
        };
        footer.rightBtnClickedBlk = ^{
            [weakSelf.orderDataService deleteOrder:weakSelf.orders[section].orderId callback:^(BOOL success) {
                WFShowHud(@"删除成功", weakSelf.view, 1);
                [weakSelf loadData];
            }];
        };
    } else {
        footer = [WFRepairOrderFooter new];
        footer.rightBtnClickedBlk = ^{
            [[ADSRouter sharedRouter] openUrlString:[NSString stringWithFormat:@"wfshop://repair?orderId=%@", weakSelf.orders[section].orderId]];
        };
    }
    footer.detailLabel.text = [NSString stringWithFormat:@"共%ld件商品 实付款: ￥%.2f", _orders[section].productCount, _orders[section].cost];
    return footer;
}

- (WFOrderDataService*)orderDataService {
    if (!_orderDataService) {
        _orderDataService = [WFOrderDataService new];
    }
    return _orderDataService;
}


@end
