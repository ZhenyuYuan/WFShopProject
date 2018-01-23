//
//  WFUserCenter.h
//  ADSRouter
//
//  Created by Andy on 2017/12/14.
//

#import <Foundation/Foundation.h>

@class WFUserToken,WFWechatUser;
@interface WFUserCenter : NSObject

+ (instancetype)sharedCenter;

- (BOOL)isUserLogined;

- (void)setUserToken:(WFUserToken*)userToken;

- (void)getCurrentUser:(void(^)(WFWechatUser*user))callback;

- (BOOL)logout;

@end
