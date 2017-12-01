//
//  WFBanner.m
//  ADSRouter
//
//  Created by Andy on 2017/10/13.
//

#import "WFBanner.h"

@implementation WFBannerImage

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"imgUrl" : @"img_url",@"actionUrl":@"action_url"};
}

@end

@implementation WFBanner

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"images" : [WFBannerImage class]};
}

@end
