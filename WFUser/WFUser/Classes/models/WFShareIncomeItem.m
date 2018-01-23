//
//  WFShareIncomeItem.m
//  ADSRouter
//
//  Created by Andy on 2018/1/22.
//

#import "WFShareIncomeItem.h"

@implementation WFShareIncomeItem

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"itemId" : @"item_id",
             @"createdAt":@"created_at",
             @"user":@"user_id",
             @"productName":@"product_name",
             @"shopName":@"shop_name",
             @"shareAmount":@"share_amount"
             };
}

@end
