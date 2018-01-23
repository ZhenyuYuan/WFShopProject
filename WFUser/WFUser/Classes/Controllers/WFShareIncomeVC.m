//
//  WFShareIncomeVC.m
//  ADSRouter
//
//  Created by Andy on 2018/1/20.
//

#import "WFShareIncomeVC.h"
#import "ADSRouter.h"
#import "MJRefresh.h"
#import "WFShareIncomeHeader.h"
#import "WFShareIncomeItemCell.h"
#import "WFUIComponent.h"
#import "WFShareIncomeItem.h"
#import "WFUserDataService.h"

@interface WFShareIncomeVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) WFUserDataService *userDataService;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) double sum;
@property (nonatomic, strong) NSMutableArray<WFShareIncomeItem*> *items;

@end

@implementation WFShareIncomeVC

ADS_REQUEST_MAPPING(WFShareIncomeVC, "wfshop://shareIncome")
ADS_PARAMETER_MAPPING(WFShareIncomeVC, shareType, "shareType")
ADS_STORYBOARD_IN_BUNDLE("WFUser", "WFShareIncomeVC", "WFUser")
ADS_HIDE_BOTTOM_BAR
ADS_SUPPORT_FLY

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.tableFooterView = [UIView new];
    __weak typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf loadNextPage];
    }];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpTitle];
    [self.tableView reloadData];
}

- (void)loadData {
    __weak typeof(self) weakSelf = self;
    [self.userDataService getTodayShare:^(double sum) {
        weakSelf.sum = sum;
        [weakSelf.tableView reloadData];
    }];
    
    _items = [NSMutableArray array];
    _page = 1;
    [self.userDataService getTodayShareList:_page callback:^(NSArray<WFShareIncomeItem *> *items) {
        [weakSelf.items addObjectsFromArray:items];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

- (void)loadNextPage {
    __weak typeof(self) weakSelf = self;
    ++_page;
    [self.userDataService getTodayShareList:_page callback:^(NSArray<WFShareIncomeItem *> *items) {
        [weakSelf.items addObjectsFromArray:items];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return _items.count;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
       cell = [tableView dequeueReusableCellWithIdentifier:[WFShareIncomeHeader wf_reuseIdentifier] forIndexPath:indexPath];
        switch (_shareType) {
            case WFShareIncomeTypeDaily:
                ((WFShareIncomeHeader*)cell).leftText = @"今日分成总额";
                ((WFShareIncomeHeader*)cell).detailText = [NSString stringWithFormat:@"￥%.2f", _sum];
                break;
            case WFShareIncomeTypeTotal:
                ((WFShareIncomeHeader*)cell).leftText = @"累计分成总额";
                ((WFShareIncomeHeader*)cell).detailText = [NSString stringWithFormat:@"￥%.2f", _sum];
                break;
            case WFShareIncomeTypeUnshare:
                ((WFShareIncomeHeader*)cell).leftText = @"待分成订单数量";
                ((WFShareIncomeHeader*)cell).detailText = [NSString stringWithFormat:@"%.0f单", _sum];
                break;
            default:
                break;
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:[WFShareIncomeItemCell wf_reuseIdentifier] forIndexPath:indexPath];
        ((WFShareIncomeItemCell*)cell).item = _items[indexPath.row];
    }
    return cell;
    
}

- (void)setUpTitle {
    switch (_shareType) {
        case WFShareIncomeTypeDaily:
            self.title = @"日分成";
            break;
        case WFShareIncomeTypeTotal:
            self.title = @"总分成";
            break;
        case WFShareIncomeTypeUnshare:
            self.title = @"待分成";
            break;
        default:
            break;
    }
}

- (WFUserDataService *)userDataService {
    if (!_userDataService) {
        _userDataService = [WFUserDataService new];
    }
    return _userDataService;
}



@end
