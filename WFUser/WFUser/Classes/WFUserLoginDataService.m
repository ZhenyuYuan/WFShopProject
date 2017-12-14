//
//  WFUserLoginDataService.m
//  ADSRouter
//
//  Created by Andy on 2017/12/14.
//

#import "WFUserLoginDataService.h"
#import "WFNetwork.h"
#import "WFUserToken.h"
#import "YYModel.h"

@implementation WFUserLoginDataService

- (void)sendSmsWithPhoneNumber:(NSString *)phone callback:(void (^)(BOOL))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"user" objId:nil path:@"/sms/send"];
    NSDictionary *params = @{@"phone":phone};
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:params option:WFRequestOptionPost complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback) {
            callback(obj.code == 0 ? NO : YES);
        }
    }];
}

- (void)verifyCodeWithPhoneNumber:(NSString *)phone code:(NSString *)code callback:(void (^)(WFUserToken *))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"user" objId:nil path:@"/sms/verify"];
    NSDictionary *params = @{@"phone":phone, @"code":code};
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:params option:WFRequestOptionPost complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback) {
            if (obj.code == 1) {
                callback([WFUserToken yy_modelWithJSON:obj.data]);
            } else {
                callback(nil);
            }
        }
    }];
}

- (void)loginWithAccount:(NSString *)account pwd:(NSString *)pwd callback:(void (^)(WFUserToken *))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"user" objId:nil path:@"/login"];
    NSDictionary *params = @{@"account":account, @"pwd":pwd};
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:params option:WFRequestOptionPost complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback) {
            if (obj.code == 1) {
                callback([WFUserToken yy_modelWithJSON:obj.data]);
            } else {
                callback(nil);
            }
        }
    }];

}

@end
