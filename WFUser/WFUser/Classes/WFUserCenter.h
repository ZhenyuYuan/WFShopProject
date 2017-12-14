//
//  WFUserCenter.h
//  ADSRouter
//
//  Created by Andy on 2017/12/14.
//

#import <Foundation/Foundation.h>

@class WFUserToken;
@interface WFUserCenter : NSObject

+ (instancetype)sharedCenter;

- (BOOL)isUserLogined;

- (void)setUserToken:(WFUserToken*)userToken;

@end
