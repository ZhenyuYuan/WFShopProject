//
//  WFProductFeatureOption.m
//  ADSRouter
//
//  Created by Andy on 2017/11/14.
//

#import "WFProductFeatureOption.h"

@implementation WFProductFeatureOption

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"optionId" : @"id",
             @"name" : @"option_name"
             };
}


@end
