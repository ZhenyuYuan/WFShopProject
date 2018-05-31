//
//  WFCartDataService.h
//  ADSRouter
//
//  Created by Andy on 2017/11/23.
//

#import <Foundation/Foundation.h>

@class WFCartItemGroup;
@interface WFCartDataService : NSObject

- (void)getCartDataWithUserId:(NSString*)userId callback:(void(^)(NSArray<WFCartItemGroup*> *cartGroups))callback;

- (NSArray*)parseCartData:(id)jsonData;

- (void)modifyCartWithItermId:(NSString*)itermId amount:(NSInteger)amount callback:(void(^)(BOOL success))callback;

- (CGFloat)calculateTotalAmount:(NSArray<WFCartItemGroup*>*)groups;

@end
