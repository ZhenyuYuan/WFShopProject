//
//  WFGridLayoutRow.m
//  WFGridLayout
//
//  Created by Andy on 2017/6/21.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFGridViewData.h"

@implementation WFGridViewData

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"imgUrl" : @"img_url",@"actionUrl":@"action_url"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"cells" : [WFGridViewData class]};
}

@end
