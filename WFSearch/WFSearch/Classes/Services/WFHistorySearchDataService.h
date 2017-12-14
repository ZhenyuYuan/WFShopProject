//
//  WFHistorySearchDataService.h
//  ADSRouter
//
//  Created by Andy on 2017/12/13.
//

#import <Foundation/Foundation.h>

@class WFHistorySearchItem;
@interface WFHistorySearchDataService : NSObject

- (void)addHistorySearch:(NSString*)query;

- (void)getHistorySearchItems:(void(^)(NSArray<WFHistorySearchItem*>*))callback;

- (void)deleteHistorySearchItem:(WFHistorySearchItem*)historySearchItem;

- (void)deleteAll;

@end
