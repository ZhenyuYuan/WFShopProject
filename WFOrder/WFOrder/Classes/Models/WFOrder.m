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


- (NSString*)orderStateStr {
    NSString *state = @"未知";
    switch (_state) {
        case WFOrderStateDone:
            state = @"完成";
            break;
        case WFOrderStateRepair:
            state = @"返修中";
            break;
        case WFOrderStateUncheck:
            state = @"未确认收货";
            break;
        case WFOrderStateUnpayed:
            state = @"未支付";
            break;
        case WFOrderStateUncomment:
            state = @"待评价";
            break;
        default:
            break;
    }
    return state;
}

@end
