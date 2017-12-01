//
//  DCClassGoodsItem.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "WFCategoryItem.h"

@implementation WFCategoryItem

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"imgUrl" : @"img_url"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"children" : [WFCategoryItem class]};
}

@end
