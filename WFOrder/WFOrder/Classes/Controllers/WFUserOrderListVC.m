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
//#import "UITableView+ASDataDrivenLayout.h"


typedef enum : NSUInteger {
    WFPageStateNormal,
    WFPageStateNoData,
} WFPageSate;

@interface WFUserOrderListVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *userId;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) WFPageSate pageSate;

@property (nonatomic, strong) WFOrderDataService *orderDataService;

@property (nonatomic, strong) NSArray<WFOrder*> *orders;

@end

@implementation WFUserOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self loadData];
}

- (void)setUpUI {
    self.view.backgroundColor = [UIColor wf_mainBackgroundColor];
    
    [self setUpDefaultText];

    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)loadData {
    __weak typeof(self) weakSelf = self;
    _orderDataService = [WFOrderDataService new];
    [_orderDataService getOrdersWithOrderType:_listType callback:^(NSArray<WFOrder *> *orders) {
        weakSelf.orders = orders;
        [weakSelf.tableView reloadData];
    }];
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

- (void)setOrders:(NSArray<WFOrder *> *)orders {
    _orders = orders;
    if (orders && orders.count != 0) {
        self.tableView.hidden = NO;
    } else {
        self.tableView.hidden = YES;
    }
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
    return 100.f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WFOrderListHeader *header = [WFGetBundle(@"WFOrder") loadNibNamed:@"WFOrderListHeader" owner:nil options:nil].firstObject;
    header.order = _orders[section];
    return header;
}

@end
