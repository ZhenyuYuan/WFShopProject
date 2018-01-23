//
//  WFWechatUser.m
//  ADSRouter
//
//  Created by Andy on 2018/1/19.
//

#import "WFWechatAuthorizeObj.h"

@implementation WFWechatAuthorizeObj

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"openId" : @"openid",
             @"accessToken":@"access_token",
             @"refreshToken":@"refresh_token",
             @"unionId":@"union_id"
             };
}

+ (NSString *)primaryKey {
    return @"openId";
}

@end
