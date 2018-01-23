//
//  WFWechatLoginService.h
//  ADSRouter
//
//  Created by Andy on 2018/1/18.
//

#import <Foundation/Foundation.h>

@class WFWechatAuthorizeObj;
@interface WFWechatLoginService : NSObject

- (void)getWechatUserWithCode:(NSString*)code callback:(void(^)(WFWechatAuthorizeObj* user))callback;

- (void)saveWechatUser:(WFWechatAuthorizeObj*)user;

- (WFWechatAuthorizeObj*)currentUserAuthorizeObj;

- (BOOL)logout;

@end
