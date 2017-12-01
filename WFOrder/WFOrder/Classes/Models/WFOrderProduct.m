//
//  WFOrderProduct.m
//  ADSRouter
//
//  Created by Andy on 2017/11/21.
//

#import "WFOrderProduct.h"

@implementation WFOrderProduct

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"productId" : @"id"
             };
}

@end
