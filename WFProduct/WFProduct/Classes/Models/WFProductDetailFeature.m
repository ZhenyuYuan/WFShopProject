//
//  WFProductDetailFeature.m
//  ADSRouter
//
//  Created by Andy on 2017/11/13.
//

#import "WFProductDetailFeature.h"
#import "WFProductFeatureOption.h"

@implementation WFProductDetailFeature

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"options" : [WFProductFeatureOption class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"name" : @"feature_name",
             @"featureId":@"id"
             };
}

@end
