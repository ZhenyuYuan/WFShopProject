//
//  WFOrderDataService.h
//  ADSRouter
//
//  Created by Andy on 2017/11/21.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    WFUserOrderListTypeAll,
    WFUserOrderListTypeUnpay,
    WFUserOrderListTypeUncheck,
    WFUserOrderListTypeUncomment,
    WFUserOrderListTypeRepair,
} WFUserOrderListType;


@class WFOrder, WFOrderShipAddress,WFOrderProduct;
@interface WFOrderDataService : NSObject

- (void)getOrdersWithOrderType:(WFUserOrderListType)type callback:(void(^)(NSArray<WFOrder*>*orders))callback;

- (void)getUserDefaultShipAddress:(void(^)(WFOrderShipAddress *shipAddress))callback;

- (void)createOrder:(NSArray<WFOrderProduct*>*)products callback:(void(^)(WFOrder* order))callback;

@end
