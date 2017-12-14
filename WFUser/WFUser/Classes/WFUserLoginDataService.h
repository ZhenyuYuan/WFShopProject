//
//  WFUserLoginDataService.h
//  ADSRouter
//
//  Created by Andy on 2017/12/14.
//

#import <Foundation/Foundation.h>

@class WFNetworkResponseObj, WFUserToken;
@interface WFUserLoginDataService : NSObject

- (void)sendSmsWithPhoneNumber:(NSString*)phone callback:(void(^)(BOOL))callback;

- (void)verifyCodeWithPhoneNumber:(NSString*)phone code:(NSString*)code callback:(void(^)(WFUserToken *userToken))callback;

- (void)loginWithAccount:(NSString*)account pwd:(NSString*)pwd callback:(void(^)(WFUserToken *userToken))callback;

@end
