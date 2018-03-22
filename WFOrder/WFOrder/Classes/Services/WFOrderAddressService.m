//
//  WFOrderAddressService.m
//  ADSRouter
//
//  Created by Andy on 2017/12/18.
//

#import "WFOrderAddressService.h"
#import "WFNetwork.h"
#import "YYModel.h"
#import "WFOrderShipAddress.h"

@implementation WFOrderAddressService

- (void)getAddress:(void (^)(NSArray<WFOrderShipAddress *> *))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"user" objId:nil path:@"shipaddress"];
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:nil option:WFRequestOptionGet complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback) {
            callback([NSArray yy_modelArrayWithClass:[WFOrderShipAddress class] json:obj.data]);
        }
    }];
}

- (void)delAddress:(WFOrderShipAddress *)address callback:(void (^)(BOOL))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"user/shipaddress/delete" objId:address.addressId path:nil];
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:nil option:WFRequestOptionPost complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback) {
            callback(obj.code == 1);
        }
    }];
}

- (void)addAddress:(WFOrderShipAddress *)address callback:(void (^)(BOOL))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"user" objId:nil path:@"shipaddress/add"];
    NSDictionary *params = @{@"receiver_name":address.receiverName,
                             @"receiver_phone":address.receiverPhone,
                             @"province":address.province,
                             @"city":address.city,
                             @"detail":address.detail
                             };
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:params option:WFRequestOptionPost|WFRequestOptionWithToken complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback) {
            callback(obj.code == 1);
        }
    }];
}

@end
