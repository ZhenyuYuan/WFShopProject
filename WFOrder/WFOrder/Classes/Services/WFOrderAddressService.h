//
//  WFOrderAddressService.h
//  ADSRouter
//
//  Created by Andy on 2017/12/18.
//

#import <Foundation/Foundation.h>

@class WFOrderShipAddress;
@interface WFOrderAddressService : NSObject

- (void)getAddress:(void(^)(NSArray<WFOrderShipAddress*> *addressArr)) callback;

- (void)delAddress:(WFOrderShipAddress*)address callback:(void(^)(BOOL success)) callback;

- (void)addAddress:(WFOrderShipAddress*)address callback:(void(^)(BOOL success)) callback;

@end
