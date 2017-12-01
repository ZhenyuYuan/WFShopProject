//
//  WFUserOrderListVC.h
//  ADSRouter
//
//  Created by Andy on 2017/11/21.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WFUserOrderListTypeAll,
    WFUserOrderListTypeUnpay,
    WFUserOrderListTypeUncheck,
    WFUserOrderListTypeUncomment,
    WFUserOrderListTypeRepqair,
} WFUserOrderListType;

@interface WFUserOrderListVC : UIViewController

- (instancetype)initWithUserId:(NSString*)userId type:(WFUserOrderListType)type;

@end
