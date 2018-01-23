//
//  WFUserDataService.h
//  ADSRouter
//
//  Created by Andy on 2017/11/20.
//

#import <Foundation/Foundation.h>

@class WFUserNormalFunctionGroup, WFUser, WFShareIncomeItem;

@interface WFUserDataService : NSObject

- (void)getFunctions:(void(^)(NSArray<WFUserNormalFunctionGroup*>* funcGroups)) callback;

- (void)getUser:(void(^)(WFUser *user))callback;

- (void)getTodayShare:(void(^)(double sum))callback;

- (void)getTodayShareList:(NSInteger)page callback:(void(^)(NSArray<WFShareIncomeItem*> *items))callback;

@end
