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

- (CGFloat)calculateTotalAmount:(NSArray<WFCartItemGroup*>*)groups;

@end
