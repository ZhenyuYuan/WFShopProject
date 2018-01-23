//
//  WFCouponVC.h
//  ADSRouter
//
//  Created by Andy on 2018/1/23.
//

#import <UIKit/UIKit.h>
#import "WFCouponTypes.h"
#import "WFCoupon.h"


@interface WFCouponVC : UIViewController

@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, copy) void(^didSelectCoupon)(WFCoupon *coupon);

+ (instancetype)vcWithCouponType:(WFCouponType)type;
@end
