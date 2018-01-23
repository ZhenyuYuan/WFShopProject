//
//  WFCoupon.h
//  ADSRouter
//
//  Created by Andy on 2018/1/23.
//

#import <Foundation/Foundation.h>
#import "WFCouponTypes.h"
@interface WFCoupon : NSObject

@property (nonatomic, copy) NSString *couponId;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, assign) WFCouponType state;

@end
