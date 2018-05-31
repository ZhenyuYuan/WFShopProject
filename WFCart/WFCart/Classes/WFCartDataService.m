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
#import "WFNetwork.h"

@implementation WFCartDataService

- (void)getCartDataWithUserId:(NSString *)userId callback:(void (^)(NSArray<WFCartItemGroup*>* cartGroups))callback {
//    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"cart" objId:nil path:nil];
//    [WFNetworkExecutor requestWithUrl:apiUrl parameters:nil option:WFRequestOptionGet|WFRequestOptionWithToken complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
//        if (callback) {
//            callback([NSArray yy_modelArrayWithClass:[WFCartItemGroup class] json:obj.data]);
//        }
//    }];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cart" ofType:@"json"];
    NSString *json = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray<WFCartItemGroup*> *cartItems = [self parseCartData:[NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:NULL]];
        callback(cartItems);
        
    });
}

- (NSArray*)parseCartData:(id)jsonData {
    NSMutableArray *cartItems = [NSMutableArray array];
    for (id cart in jsonData[@"data"]) {
        [cartItems addObject:[WFCartItemGroup yy_modelWithJSON:cart]];
    }
    return cartItems.copy;
}

- (void)modifyCartWithItermId:(NSString *)itermId amount:(NSInteger)amount callback:(void (^)(BOOL))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"cart/modify" objId:itermId path:nil];
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:@{@"amount":@(amount)} option:WFRequestOptionPost|WFRequestOptionWithToken complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback) {
            callback(YES);
        }
    }];
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
