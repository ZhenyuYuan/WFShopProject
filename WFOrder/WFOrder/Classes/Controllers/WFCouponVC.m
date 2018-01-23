//
//  WFCouponVC.m
//  ADSRouter
//
//  Created by Andy on 2018/1/23.
//

#import "WFCouponVC.h"
#import "WFCouponCell.h"
#import "WFCouponService.h"
#import "WFCoupon.h"
#import "MJRefresh.h"
#import "WFHelpers.h"
#import "WFUIComponent.h"

@interface WFCouponVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) WFCouponService *couponService;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray<WFCoupon*> *coupons;

@property (nonatomic, assign) WFCouponType type;

@end

@implementation WFCouponVC

+ (instancetype)vcWithCouponType:(WFCouponType)type {
    WFCouponVC *vc = [[UIStoryboard storyboardWithName:@"WFOrder" bundle:WFGetBundle(@"WFOrder")] instantiateViewControllerWithIdentifier:@"WFCouponVC"];
    vc.type = type;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self loadData];
}

- (void)setUpUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    __weak typeof(self) weakSelf = self;
    _tableview.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    _tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf nextPage];
    }];
    
}

- (void)loadData {
    _page = 1;
    _coupons = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    [self.couponService getCouponWithType:_type page:_page callback:^(NSArray<WFCoupon *> *coupons) {
        [weakSelf.coupons addObjectsFromArray:coupons];
        [_tableview.mj_header endRefreshing];
        [_tableview.mj_footer endRefreshing];
        [_tableview reloadData];
    }];
    
    
}

- (void)nextPage {
    ++_page;
    __weak typeof(self) weakSelf = self;
    [self.couponService getCouponWithType:_type page:_page callback:^(NSArray<WFCoupon *> *coupons) {
        [weakSelf.coupons addObjectsFromArray:coupons];
        [_tableview.mj_header endRefreshing];
        [_tableview.mj_footer endRefreshing];
        [_tableview reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _coupons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WFCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:[WFCouponCell wf_reuseIdentifier] forIndexPath:indexPath];
    cell.coupon = _coupons[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_type == WFCouponTypeOrderAvailable) {
        if (_didSelectCoupon) _didSelectCoupon(_coupons[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (WFCouponService *)couponService {
    if (!_couponService) {
        _couponService = [WFCouponService new];
    }
    return _couponService;
}

@end
