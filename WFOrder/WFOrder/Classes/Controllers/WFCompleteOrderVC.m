//
//  WFCompleteOrderVC.m
//  ADSRouter
//
//  Created by Andy on 2017/11/15.
//

#import "WFCompleteOrderVC.h"
#import "ADSRouter.h"
#import "WFOrderProduct.h"
#import "WFUIComponent.h"
#import "WFOrder.h"
#import "WFOrderAddressCell.h"
#import "WFOrderItemCell.h"
#import "WFOrderDataService.h"
#import "YYModel.h"
#import "WFSelectOrderShipAddressVC.h"
#import "WFOrderSelectDeliverTypeCell.h"
#import "WFOrderSelectCouponCell.h"
#import "WFCouponVC.h"
#import "WFCoupon.h"

@interface WFCompleteOrderVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *totalFeeLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkoutBtn;

@property (nonatomic, strong) WFCoupon *coupon;

@property (nonatomic, strong) NSArray<WFOrderProduct*> *orderProducts;
@property (nonatomic, assign) CGFloat totalFee;

@property (nonatomic, strong) WFOrderDataService *orderService;
@property (nonatomic, strong) WFOrderShipAddress *shipAddress;

@end

@implementation WFCompleteOrderVC

ADS_REQUEST_MAPPING(WFCompleteOrderVC, "wfshop://completeOrder")
ADS_STORYBOARD_IN_BUNDLE("WFOrder", "WFCompleteOrderVC", "WFOrder")
ADS_PARAMETER_MAPPING(WFCompleteOrderVC, itemsStr, "itemsStr")
ADS_HIDE_BOTTOM_BAR

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self loadData];
}

- (void)setUpUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"填写订单";
    _totalFeeLabel.textColor = [UIColor wf_redColor];
    [_checkoutBtn setBackgroundColor:[UIColor wf_mainColor]];
    [_checkoutBtn addTarget:self action:@selector(checkout) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    _totalFeeLabel.text = [NSString stringWithFormat:@"实付款:￥ %.2f", _totalFee];
}

- (void)loadData {
    __weak typeof(self) weakSelf = self;
    [self.orderService getUserDefaultShipAddress:^(WFOrderShipAddress *shipAddress) {
        weakSelf.shipAddress = shipAddress;
        [weakSelf.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _shipAddress ? 1 : 0;
    } else if (section == 1) {
        return 2;
    } else {
        return _orderProducts.count;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [_tableView dequeueReusableCellWithIdentifier:[WFOrderAddressCell wf_reuseIdentifier]];
        ((WFOrderAddressCell*)cell).address = _shipAddress;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell = [_tableView dequeueReusableCellWithIdentifier:[WFOrderSelectDeliverTypeCell wf_reuseIdentifier]];
        } else {
            cell = [_tableView dequeueReusableCellWithIdentifier:[WFOrderSelectCouponCell wf_reuseIdentifier]];
            ((WFOrderSelectCouponCell*)cell).coupon = _coupon;
        }
    } else {
        cell = [_tableView dequeueReusableCellWithIdentifier:[WFOrderItemCell wf_reuseIdentifier]];
        ((WFOrderItemCell*)cell).product = _orderProducts[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        WFSelectOrderShipAddressVC *vc = [[UIStoryboard storyboardWithName:@"WFOrder" bundle:WFGetBundle(@"WFOrder")] instantiateViewControllerWithIdentifier:@"WFSelectOrderShipAddressVC"];
        vc.selectedAddress = _shipAddress;
        __weak typeof(self) weakSelf = self;
        vc.didSelectShipAddress = ^(WFOrderShipAddress *address) {
            weakSelf.shipAddress = address;
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSLog(@"选择配送方式");
        } else {
            __weak typeof(self) weakSelf = self;
            WFCouponVC *vc = [WFCouponVC vcWithCouponType:WFCouponTypeOrderAvailable];
            vc.didSelectCoupon = ^(WFCoupon *coupon) {
                weakSelf.coupon = coupon;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        [[ADSRouter sharedRouter] openUrlString:[NSString stringWithFormat:@"wfshop://product?productId=%@", _orderProducts[indexPath.row].productId]];
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return @"商品";
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return .1f;
    }
    return 10.f;
}

- (void)checkout {
    MBProgressHUD *hud = WFShowProgressHud(@"正在创建订单...", self.view, 1);
    [self.orderService createOrder:nil callback:^(WFOrder *order) {
        [[ADSRouter sharedRouter] openUrlString:[NSString stringWithFormat:@"wfshop://pay?orderId=%@", order.orderId]];
        [hud hideAnimated:YES];
    }];
}

- (WFOrderDataService*)orderService {
    if (!_orderService) {
        _orderService = [WFOrderDataService new];
    }
    return _orderService;
}

- (void)setItemsStr:(NSString *)itemsStr {
    _itemsStr = itemsStr;
    NSData *data = [[NSData alloc] initWithBase64EncodedString:itemsStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *jsonStr =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    _orderProducts = [NSArray yy_modelArrayWithClass:[WFOrderProduct class] json:jsonStr];
    
    [_orderProducts enumerateObjectsUsingBlock:^(WFOrderProduct * _Nonnull product, NSUInteger idx, BOOL * _Nonnull stop) {
        self.totalFee += product.amount * product.price;
    }];
}


@end
