//
//  WFCouponService.m
//  ADSRouter
//
//  Created by Andy on 2018/1/23.
//

#import "WFCouponService.h"
#import "YYModel.h"
#import "WFNetwork.h"
#import "WFCoupon.h"

@implementation WFCouponService

- (void)getCouponWithType:(WFCouponType)type page:(NSInteger)page callback:(void (^)(NSArray<WFCoupon *> *))callback {
    NSString *apiUrl;
    switch (type) {
        case WFCouponTypeAvailable:
            apiUrl = [WFAPIFactory URLWithNameSpace:@"/coupon" objId:nil path:@"available"];
            break;
        case WFCouponTypeUsed:
            apiUrl = [WFAPIFactory URLWithNameSpace:@"/coupon" objId:nil path:@"used"];
            break;
        case WFCouponTypeExpired:
            apiUrl = [WFAPIFactory URLWithNameSpace:@"/coupon" objId:nil path:@"expired"];
            break;
        default:
            apiUrl = [WFAPIFactory URLWithNameSpace:@"/coupon" objId:nil path:@""];
            break;
    }
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:@{@"page":@(page)} option:WFRequestOptionGet|WFRequestOptionWithToken complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback) {
            callback([NSArray yy_modelArrayWithClass:[WFCoupon class] json:obj.data]);
        }
    }];
}
- (void)getAvailableCouponsWithPage:(NSInteger)page callback:(void (^)(NSArray<WFCoupon *> *))callback {
    
}

- (void)getUsedCouponsWithPage:(NSInteger)page callback:(void (^)(NSArray<WFCoupon *> *))callback {
    
}

- (void)getExpiredCouponsWithPage:(NSInteger)page callback:(void (^)(NSArray<WFCoupon *> *))callback {
    
    
}
@end
