//
//  WFWechatLoginService.m
//  ADSRouter
//
//  Created by Andy on 2018/1/18.
//

#import "WFWechatLoginService.h"
#import "WFNetwork.h"
#import "WFWechatAuthorizeObj.h"
#import "YYModel.h"
#import "Realm.h"

@implementation WFWechatLoginService

- (void)getWechatUserWithCode:(NSString *)code callback:(void (^)(WFWechatAuthorizeObj *))callback {
    NSDictionary *params = @{
                             @"appid":@"wxe7798aead7625419",
                             @"secret":@"d8dfb107972ae477b58f9a600c989541",
                             @"code":code,
                             @"grant_type":@"authorization_code"
                             };
    [WFNetworkExecutor outRequestWithUrl:@"https://api.weixin.qq.com/sns/oauth2/access_token" parameters:params option:WFRequestOptionGet complete:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        WFWechatAuthorizeObj *wechatUser = [WFWechatAuthorizeObj yy_modelWithJSON:responseObject];
        if (callback) {
            callback(wechatUser);
        }
    }];
}

- (void)saveWechatUser:(WFWechatAuthorizeObj *)user {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:user];
    [realm commitWriteTransaction];
}

- (WFWechatAuthorizeObj*)currentUserAuthorizeObj {
    return [WFWechatAuthorizeObj allObjects].firstObject;
}

- (BOOL)logout {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObject:[WFWechatAuthorizeObj allObjects].firstObject];
    [realm commitWriteTransaction];
    return YES;
}

@end
