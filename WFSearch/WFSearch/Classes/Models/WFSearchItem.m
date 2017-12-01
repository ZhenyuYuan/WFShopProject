//
//  WFSearchItem.m
//  ADSRouter
//
//  Created by Andy on 2017/10/24.
//

#import "WFSearchItem.h"

@implementation WFSearchItem

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"itemId":@"id",
             @"imgUrl" : @"img_url",
             @"commentCount" : @"comment_count"
             };
}

@end
