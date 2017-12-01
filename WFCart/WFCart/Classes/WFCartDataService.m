//
//  WFCartDataService.m
//  ADSRouter
//
//  Created by Andy on 2017/11/23.
//

#import "WFCartDataService.h"
#import "WFNetwork.h"
#import "YYModel.h"
#import "WFCartItem.h"

@implementation WFCartDataService

- (void)getCartDataWithUserId:(NSString *)userId callback:(void (^)(NSArray<WFCartItemGroup*>* cartGroups))callback {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cart" ofType:@"json"];
    NSString *json = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    WFNetworkResponse *responseEntity = [WFNetworkResponse yy_modelWithJSON:json];
    NSArray<WFCartItemGroup*> *cartGroups = [NSArray yy_modelArrayWithClass:[WFCartItemGroup class] json:responseEntity.data];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (callback) {
            callback(cartGroups);
        }
    });
}

- (CGFloat)calculateTotalAmount:(NSArray<WFCartItemGroup *> *)groups {
    __block CGFloat res = 0;
    [groups enumerateObjectsUsingBlock:^(WFCartItemGroup * _Nonnull group, NSUInteger idx, BOOL * _Nonnull stop) {
        [group.cartItems enumerateObjectsUsingBlock:^(WFCartItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
            if (item.isSelected) {
                res += item.amount * item.product.price;
            }
        }];
    }];
    return res;
}


@end
