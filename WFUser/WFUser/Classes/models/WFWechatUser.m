//
//  WFWechatUser.m
//  ADSRouter
//
//  Created by Andy on 2018/1/19.
//

#import "WFWechatUser.h"


@implementation WFWechatUser

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"openId" : @"openid",
             @"nickName":@"nickname",
             @"headImgUrl":@"headimgurl",
             @"unionId":@"union_id"
             };
}

@end
