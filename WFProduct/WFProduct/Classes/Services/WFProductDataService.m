//
//  WFProductDataService.m
//  WFProduct
//
//  Created by Andy on 2017/11/14.
//

#import "WFProductDataService.h"
#import "YYModel.h"
#import "WFNetwork.h"
#import "WFProduct.h"
#import "WFProductModels.h"
#import "MJExtension.h"
#import "WFHelpers.h"
#import "WFNetwork.h"
#import "WFUserCenter.h"

@implementation WFProductDataService

- (void)collectProduct:(NSString *)productId callback:(void (^)(BOOL))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"collection" objId:nil path:[NSString stringWithFormat:@"add/%@", productId]];
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:nil option:WFRequestOptionPost|WFRequestOptionWithToken complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback) {
            callback(obj.code == 1 ? YES : NO);
        }
    }];
    
}

- (void)getProductIdWithFeatures:(NSArray<WFProductDetailFeature *> *)features productGroupId:(NSString *)productGroupId callback:(void (^)(NSString *))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"product" objId:nil path:@"id"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:params option:WFRequestOptionGet complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback && obj.code == 1) {
            callback(obj.data[@"product_id"]);
        }
    }];
}

- (void)getProductWithProductId:(NSString *)productId callback:(void (^)(WFProduct *))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"product" objId:productId path:nil];
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:nil option:WFRequestOptionGet complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback) {
            callback([WFProduct yy_modelWithJSON:obj.data]);
        }
    }];
}

- (void)getProductFeatureWithProductId:(NSString*)productId callback:(void (^)(NSArray<WFProductDetailFeature *> *))callback {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"product_feature" ofType:@"json"];
    NSString *json = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *features = [self parseFeatures:json];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (callback) {
            callback(features);
        }
    });
}

- (NSArray<WFProductDetailFeature*>*)parseFeatures:(id)response {
    NSMutableArray *features = [NSMutableArray array];
    WFNetworkResponse *responseEntity = [WFNetworkResponse yy_modelWithJSON:response];
    for (id feature in responseEntity.data) {
        [features addObject:[WFProductDetailFeature yy_modelWithJSON:feature]];
    }
    return features;
}

- (void)getShipAddressWithUserId:(NSString *)userId callback:(void (^)(NSArray<WFProductShipAddress *> *))callback {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"user_ship_address" ofType:@"json"];
    NSString *json = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *shipAddressArr = [self parseAddressArr:json];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (callback) {
            callback(shipAddressArr);
        }
    });
}

- (NSArray<WFProductShipAddress*>*)parseAddressArr:(id)response {
    NSMutableArray *addressArr = [NSMutableArray array];
    WFNetworkResponse *responseEntity = [WFNetworkResponse yy_modelWithJSON:response];
    for (id address in responseEntity.data) {
        [addressArr addObject:[WFProductShipAddress yy_modelWithJSON:address]];
    }
    return addressArr;
}

- (void)getShopWithShopId:(NSString *)shopId callback:(void (^)(WFProductShop *))callback {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shop" ofType:@"json"];
    NSString *json = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    WFProductShop *shop = [self parseShop:json];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (callback) {
            callback(shop);
        }
    });
}

- (WFProductShop*)parseShop:(id)response {
    WFNetworkResponse *responseEntity = [WFNetworkResponse yy_modelWithJSON:response];
    WFProductShop *shop;
    shop = [WFProductShop yy_modelWithJSON:responseEntity.data];
    return shop;
}

- (BOOL)isAllFeaturesSelected:(NSArray<WFProductDetailFeature *> *)features {
    __block BOOL allSelected = YES;
    [features enumerateObjectsUsingBlock:^(WFProductDetailFeature * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __block BOOL isSelected = NO;
        [obj.options enumerateObjectsUsingBlock:^(WFProductFeatureOption * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isSelected) {
                isSelected = YES;
                *stop = YES;
            }
        }];
        if (!isSelected) {
            allSelected = NO;
            *stop = YES;
        }
    }];
    return allSelected;
}

- (void)getShareItems:(void (^)(NSArray<WFProductShareItem *> *))callback {
    NSBundle *bundle = WFGetBundle(@"WFProduct");
    NSString *plistPath = [bundle pathForResource:@"shareItems" ofType:@"plist"];
    NSArray<WFProductShareItem*> *productItems = [WFProductShareItem mj_objectArrayWithFile:plistPath];
    if (callback) {
        callback(productItems);
    }
}

- (void)getProductCommentWithProductId:(NSString *)productId page:(NSInteger)page callback:(void (^)(NSArray<WFProductComment *> *))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"product" objId:productId path:@"comment"];
    NSDictionary *params = @{@"page": @(page)};
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:params option:WFRequestOptionGet complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        NSArray<WFProductComment*> *comments = [NSArray yy_modelArrayWithClass:[WFProductComment class] json:obj.data];
        callback(comments);
    }];
}

- (void)addProductToCart:(NSString *)productId amount:(NSInteger)amount callback:(void (^)(BOOL))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"cart" objId:nil path:[NSString stringWithFormat:@"add/%@", productId]];
    NSDictionary *params = @{@"amount":@(amount)};
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:params option:WFRequestOptionPost|WFRequestOptionWithToken complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback) {
            callback(obj.code == 1 ? YES : NO);
        }
    }];
}


@end
