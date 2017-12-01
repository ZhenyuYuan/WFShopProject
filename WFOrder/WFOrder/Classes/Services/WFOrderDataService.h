//
//  WFOrderDataService.h
//  ADSRouter
//
//  Created by Andy on 2017/11/21.
//

#import <Foundation/Foundation.h>

@class WFOrder;
@interface WFOrderDataService : NSObject

- (void)getOrdersWithUserId:(NSString*)userId callback:(void(^)(NSArray<WFOrder*>*orders))callback;

@end
