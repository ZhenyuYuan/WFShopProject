//
//  WFOrder.h
//  ADSRouter
//
//  Created by Andy on 2017/11/21.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    WFOrderStateUnpayed = 0,
    WFOrderStateUncheck,
    WFOrderStateUncomment,
    WFOrderStateRepair
} WFOrderState;

@class WFOrderProduct;
@interface WFOrder : NSObject

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, assign) NSInteger prodcutCount;
@property (nonatomic, strong) NSArray<WFOrderProduct*> *products;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) CGFloat cost;

@property (nonatomic, assign) WFOrderState orderState;

@end