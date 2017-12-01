//
//  WFUserOrderListVC.m
//  ADSRouter
//
//  Created by Andy on 2017/11/21.
//

#import "WFUserOrderListVC.h"
#import "WFUIComponent.h"
#import "Masonry.h"
#import "WFOrderDataService.h"
#import "WFOrder.h"
//#import "UITableView+ASDataDrivenLayout.h"


typedef enum : NSUInteger {
    WFPageStateNormal,
    WFPageStateNoData,
} WFPageSate;

@interface WFUserOrderListVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) WFUserOrderListType listType;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) WFPageSate pageSate;

@property (nonatomic, strong) WFOrderDataService *orderDataService;

@property (nonatomic, strong) NSArray<WFOrder*> *orders;

@end

@implementation WFUserOrderListVC

- (instancetype)initWithUserId:(NSString *)userId type:(WFUserOrderListType)type {
    self = [super init];
    if (self) {
        _listType = type;
        _userId = userId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self loadData];
}

- (void)setUpUI {
    self.view.backgroundColor = [UIColor wf_mainBackgroundColor];
    
    [self setUpDefaultText];
    
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
}

- (void)loadData {
    __weak typeof(self) weakSelf = self;
    _orderDataService = [WFOrderDataService new];
    [_orderDataService getOrdersWithUserId:@"" callback:^(NSArray<WFOrder *> *orders) {
        weakSelf.orders = orders;
        //[weakSelf.tableView reloadData];
    }];
}

- (void)setUpDefaultText {
    UILabel *label = [UILabel new];
    label.text = @"此处没有订单";
    label.textColor = [UIColor wf_placeHolderColor];
    label.font = [UIFont wf_pfr15];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY);
        make.left.right.mas_equalTo(self.view);
    }];
}

- (void)setOrders:(NSArray<WFOrder *> *)orders {
    _orders = orders;
    if (orders && orders.count != 0) {
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    } else {
        self.tableView.hidden = YES;
    }
}

- (void)setPageSate:(WFPageSate)pageSate {
    _tableView.hidden = (pageSate == WFPageStateNoData);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _orders.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"订单%@", _orders[indexPath.row].orderId];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
