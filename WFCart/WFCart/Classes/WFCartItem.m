//
//  WFCartItem.m
//  ADSRouter
//
//  Created by Andy on 2017/11/22.
//

#import "WFCartItem.h"

@implementation WFCartShop

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"shopId" : @"id",
             @"name" : @"shop_name",
             };
}

@end

@implementation WFCartProduct

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"productId" : @"id",
             @"coverImg":@"cover_img",
             };
}

@end

@implementation WFCartItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"itemId" : @"id"
             };
}
@end

@implementation WFCartItemGroup

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"cartItems" : [WFCartItem class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cartItems" : @"cart_items"
             };
}

@end


