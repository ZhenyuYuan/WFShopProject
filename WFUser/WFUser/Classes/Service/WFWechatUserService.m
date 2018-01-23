//
//  WFWechatUserService.m
//  ADSRouter
//
//  Created by Andy on 2018/1/19.
//

#import "WFWechatUserService.h"
#import "WFWechatUser.h"
#import "WFNetwork.h"
#import "WXApi.h"
#import "YYModel.h"

@implementation WFWechatUserService

- (void)getWechatUserWithAccessToken:(NSString *)accessToken openId:(NSString *)openId callback:(void (^)(WFWechatUser *))callback {
    [WFNetworkExecutor outRequestWithUrl:@"https://api.weixin.qq.com/sns/userinfo" parameters:@{@"access_token":accessToken,@"openid":openId} option:WFRequestOptionGet complete:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (callback) {
            callback([WFWechatUser yy_modelWithJSON:responseObject]);
        }
    }];
}

@end
