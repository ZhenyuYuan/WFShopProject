//
//  WFOrderShipAddress.m
//  ADSRouter
//
//  Created by Andy on 2017/12/15.
//

#import "WFOrderShipAddress.h"

@implementation WFOrderShipAddress

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"addressId" : @"id",
             @"receiverName" : @"receiver_name",
             @"receiverPhone" : @"receiver_phone"
             };
}

- (NSString*)address {
    return [NSString stringWithFormat:@"%@,%@,%@", _province, _city, _detail];
}


@end
