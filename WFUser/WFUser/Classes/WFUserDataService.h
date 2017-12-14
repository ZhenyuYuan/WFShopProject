//
//  WFUserDataService.h
//  ADSRouter
//
//  Created by Andy on 2017/11/20.
//

#import <Foundation/Foundation.h>

@class WFUserNormalFunctionGroup, WFUser;

@interface WFUserDataService : NSObject

- (void)getFunctions:(void(^)(NSArray<WFUserNormalFunctionGroup*>* funcGroups)) callback;

- (void)getUser:(void(^)(WFUser *user))callback;

@end
