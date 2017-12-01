//
//  WFProductShop.m
//  WFProduct
//
//  Created by Andy on 2017/11/16.
//

#import "WFProductShop.h"

@implementation WFProductShop

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"shopId" : @"id",
             @"name" : @"shop_name",
             @"coverImg" : @"cover_img",
             @"subTitle" :@"sub_title"
             };
}

@end
