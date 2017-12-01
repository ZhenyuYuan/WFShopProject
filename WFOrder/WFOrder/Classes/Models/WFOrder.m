//
//  WFOrder.m
//  ADSRouter
//
//  Created by Andy on 2017/11/21.
//

#import "WFOrder.h"
#import "WFOrderProduct.h"
@implementation WFOrder

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"orderId" : @"id",
             @"productCount":@"product_count"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"products" : [WFOrderProduct class]};
}

- (WFOrderState)orderState {
    return _state;
}

@end
