//
//  WFOrderDataService.m
//  ADSRouter
//
//  Created by Andy on 2017/11/21.
//

#import "WFOrderDataService.h"
#import "WFOrderModels.h"
#import "YYModel.h"
#import "WFHelpers.h"
#import "WFNetwork.h"
#import "WFOrderShipAddress.h"
#import "WFProduct.h"

@implementation WFOrderDataService

- (void)getOrdersWithOrderType:(WFUserOrderListType)type page:(NSInteger)page callback:(void (^)(NSArray<WFOrder *> *))callback {
//    NSString *typeStr = @"all";
//    switch (type) {
//        case WFUserOrderListTypeAll:
//            typeStr = @"all";
//            break;
//        case WFUserOrderListTypeUnpay:
//            typeStr = @"unpay";
//            break;
//        case WFUserOrderListTypeUncheck:
//            typeStr = @"uncheck";
//            break;
//        case WFUserOrderListTypeUncomment:
//            typeStr = @"uncomment";
//            break;
//        case WFUserOrderListTypeRepair:
//            typeStr = @"repair";
//            break;
//        default:
//            break;
//    }
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"order" objId:nil path:nil];
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:@{@"type":@(type),@"page":@(page)} option:WFRequestOptionGet|WFRequestOptionWithToken complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback) {
            callback([NSArray yy_modelArrayWithClass:[WFOrder class] json:obj.data]);
        }
    }];
}

- (void)getUserDefaultShipAddress:(void (^)(WFOrderShipAddress *))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"user" objId:nil path:@"/shipaddress/default"];
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:nil option:WFRequestOptionGet complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback) {
            callback([WFOrderShipAddress yy_modelWithJSON:obj.data]);
        }
    }];
}

- (void)createOrder:(NSArray<WFOrderProduct *> *)products callback:(void (^)(WFOrder *))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"order" objId:nil path:@"create"];
    NSMutableArray *ids = [NSMutableArray array];
    NSMutableArray *amounts = [NSMutableArray array];
    [products enumerateObjectsUsingBlock:^(WFOrderProduct * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [ids addObject:obj.productId];
        [amounts addObject:@(obj.amount)];
    }];
    
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:@{@"products":ids, @"amounts":amounts} option:WFRequestOptionWithToken|WFRequestOptionPost complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback) {
            callback([WFOrder yy_modelWithJSON:obj.data]);
        }
    }];
}

- (void)uploadImage:(UIImage *)image name:(NSString*)name callback:(void (^)(NSString *))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"image" objId:nil path:nil];
    [WFNetworkExecutor uploadImageWithUrl:apiUrl image:image name:name option:WFRequestOptionPost|WFRequestOptionWithToken progress:^(NSProgress *uploadProgress) {
        NSLog(@"%f", uploadProgress.fractionCompleted);
    } complete:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (callback) {
            callback(responseObject[@"data"]);
        }
    }];
    
}
- (void)confirmOrder:(NSString *)orderId callback:(void (^)(BOOL))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"order" objId:orderId path:@"confirm"];
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:nil option:WFRequestOptionPost complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback) {
            callback(YES);
        }
    }];
}

- (void)deleteOrder:(NSString *)orderId callback:(void (^)(BOOL))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"order" objId:orderId path:@"delete"];
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:nil option:WFRequestOptionPost complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback) {
            callback(YES);
        }
    }];
}

- (void)commentOrder:(NSString *)orderId callback:(void (^)(BOOL))callback {
    NSString *apiurl = [WFAPIFactory URLWithNameSpace:@"order" objId:orderId path:@"comment"];
    [WFNetworkExecutor requestWithUrl:apiurl parameters:@{} option:WFRequestOptionPost|WFRequestOptionWithToken complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        callback(YES);
    }];
}
@end
