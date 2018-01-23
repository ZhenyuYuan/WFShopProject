//
//  WFCouponService.h
//  ADSRouter
//
//  Created by Andy on 2018/1/23.
//

#import <Foundation/Foundation.h>
#import "WFCouponTypes.h"

@class WFCoupon;

@interface WFCouponService : NSObject

- (void)getCouponWithType:(WFCouponType)type page:(NSInteger)page callback:(void(^)(NSArray<WFCoupon*>*coupons))callback;

- (void)getAvailableCouponsWithPage:(NSInteger)page callback:(void(^)(NSArray<WFCoupon*>* coupons))callback;

- (void)getUsedCouponsWithPage:(NSInteger)page callback:(void(^)(NSArray<WFCoupon*>* coupons))callback;

- (void)getExpiredCouponsWithPage:(NSInteger)page callback:(void(^)(NSArray<WFCoupon*>* coupons))callback;

@end
