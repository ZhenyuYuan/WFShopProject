//
//  WFOrderShipAddress.h
//  ADSRouter
//
//  Created by Andy on 2017/12/15.
//

#import <Foundation/Foundation.h>

@interface WFOrderShipAddress : NSObject

@property (nonatomic, copy) NSString *addressId;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *detail;

@property (nonatomic, copy) NSString *receiverName;
@property (nonatomic, copy) NSString *receiverPhone;
- (NSString*)address;
@end
