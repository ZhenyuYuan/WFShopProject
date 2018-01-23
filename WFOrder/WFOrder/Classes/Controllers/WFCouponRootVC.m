//
//  WFCouponRootVC.m
//  ADSRouter
//
//  Created by Andy on 2018/1/23.
//

#import "WFCouponRootVC.h"
#import "WFUIComponent.h"
#import "WFCouponVC.h"
#import "ADSRouter.h"

static const CGFloat kMenuHeight = 50.f;

@interface WFCouponRootVC ()

@property (nonatomic, strong) NSArray<NSString*> *couponTypes;

@end

@implementation WFCouponRootVC

ADS_REQUEST_MAPPING(WFCouponRootVC, "wfshop://coupon")
ADS_HIDE_BOTTOM_BAR

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setUpMenu];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUpMenu];
    }
    return self;
}



- (void)setUpMenu {
    _couponTypes = @[@"未使用", @"已使用", @"已过期"];
    self.titleSizeSelected = self.titleSizeNormal;
    self.titleColorNormal = [UIColor wf_placeHolderColor];
    self.titleColorSelected = [UIColor wf_mainColor];
    self.menuHeight = kMenuHeight;
    self.menuBGColor = [UIColor whiteColor];
    self.menuViewStyle = WMMenuViewStyleLine;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return _couponTypes.count;
}

- (NSString*)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return _couponTypes[index];
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    if (index == 0) {
        return [WFCouponVC vcWithCouponType:WFCouponTypeAvailable];
    }
    if (index == 1) {
        return [WFCouponVC vcWithCouponType:WFCouponTypeUsed];
    }
    if (index == 2) {
        return [WFCouponVC vcWithCouponType:WFCouponTypeExpired];
    }
    return [UIViewController new];
}

@end
