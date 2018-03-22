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

- (void)getOrdersWithOrderType:(WFUserOrderListType)type page:(NSInteger)page callback:(void(^)(NSArray<WFOrder*>*orders))callback;

- (void)getUserDefaultShipAddress:(void(^)(WFOrderShipAddress *shipAddress))callback;

- (void)createOrder:(NSArray<WFOrderProduct*>*)products callback:(void(^)(WFOrder* order))callback;

- (void)uploadImage:(UIImage*)image name:(NSString*)name callback:(void(^)(NSString *imgUrl))callback;

- (void)confirmOrder:(NSString*)orderId callback:(void(^)(BOOL success))callback;

- (void)deleteOrder:(NSString*)orderId callback:(void(^)(BOOL success))callback;

- (void)commentOrder:(NSString*)orderId callback:(void(^)(BOOL success))callback;

@end
