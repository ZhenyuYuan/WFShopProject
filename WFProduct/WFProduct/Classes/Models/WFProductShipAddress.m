//
//  WFProductShipAddress.m
//  ADSRouter
//
//  Created by Andy on 2017/11/15.
//

#import "WFProductShipAddress.h"

@implementation WFProductShipAddress

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"addressId" : @"id",
             @"receiverName" : @"receiver_name",
             @"receiverPhone" : @"receiver_phone"
             };
}

- (NSString*)address {
    return [NSString stringWithFormat:@"%@,%@%@,%@,%@", _receiverName, _receiverPhone,_province, _city, _detail];
}

- (NSString*)shortAddress {
    return [NSString stringWithFormat:@"%@,%@,%@", _receiverName, _province, _city];
}

- (NSString*)description {
    return [self address];
}

@end
