//
//  WFUserOrderVC.m
//  ADSRouter
//
//  Created by Andy on 2017/11/18.
//

#import "WFUserOrderRootVC.h"
#import "ADSRouter.h"
#import "WFUIComponent.h"
#import "WFUserOrderListVC.h"

const NSInteger kAllOrderIdx = 0;
const NSInteger kUnpayOrderIdx = 1;
const NSInteger kUncheckOrderIdx = 2;
const NSInteger kUncommentOrderIdx = 3;
const NSInteger kRepairOrderIdx = 4;

const CGFloat kMenuHeight = 50.f;


@interface WFUserOrderRootVC ()

@property (nonatomic,strong) NSArray<NSString*> *orderTypes;

@end

@implementation WFUserOrderRootVC

ADS_REQUEST_MAPPING(WFUserOrderRootVC, "wfshop://showOrders")
ADS_PARAMETER_MAPPING(WFUserOrderRootVC, selectedIdx, "selected_idx")

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUpMenu];
    }
    return self;
}

- (void)setUpMenu {
    _orderTypes = @[@"全部", @"待支付", @"待收货", @"待评价", @"退换修"];
    self.titleSizeSelected = self.titleSizeNormal;
    self.titleColorNormal = [UIColor wf_placeHolderColor];
    self.titleColorSelected = [UIColor wf_mainColor];
    self.menuHeight = kMenuHeight;
    self.menuBGColor = [UIColor whiteColor];
    self.menuViewStyle = WMMenuViewStyleLine;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self loadData];
    
}

- (void)setUpUI {
    self.view.backgroundColor = [UIColor wf_mainBackgroundColor];
    
    
    [self setSelectIndex:_selectedIdx];
    
    [self setUpNavi];
}

- (void)setUpNavi {
    self.title = @"商品订单";
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search" inBundle:WFGetBundle(@"WFOrder") compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(searchBtnClicked)];
    UIBarButtonItem *cartBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cart" inBundle:WFGetBundle(@"WFOrder") compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(cartBtnClicked)];
    cartBtn.target = self;
    self.navigationItem.rightBarButtonItems = @[searchBtn, cartBtn];
}

- (void)loadData {

}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return _orderTypes.count;
}

- (NSString*)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return _orderTypes[index];
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    UIViewController *vc;
    switch (index) {
        case kAllOrderIdx:
            vc = [self getOrderListWithType:WFUserOrderListTypeAll];
            break;
        case kUnpayOrderIdx:
            vc = [self getOrderListWithType:WFUserOrderListTypeUnpay];
            break;
        case kUncheckOrderIdx:
            vc = [self getOrderListWithType:WFUserOrderListTypeUncheck];
            break;
        case kUncommentOrderIdx:
            vc = [self getOrderListWithType:WFUserOrderListTypeUncomment];
            break;
        case kRepairOrderIdx:
            vc = [self getOrderListWithType:WFUserOrderListTypeRepqair];
            break;
        default:
            break;
    }
    return vc;
}

- (void)searchBtnClicked {
    NSLog(@"search order");
}

- (void)cartBtnClicked {
    [[ADSRouter sharedRouter] openUrlString:@"wfshop://cart"];
}

- (WFUserOrderListVC*)getOrderListWithType:(WFUserOrderListType)type {
    return [[WFUserOrderListVC alloc] initWithUserId:@"" type:type];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
