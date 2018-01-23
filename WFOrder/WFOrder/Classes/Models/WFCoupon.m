//
//  WFCoupon.m
//  ADSRouter
//
//  Created by Andy on 2018/1/23.
//

#import "WFCoupon.h"

@implementation WFCoupon
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"couponId" : @"coupon_id",
             @"shopName":@"shop_name"
             };
}
@end
