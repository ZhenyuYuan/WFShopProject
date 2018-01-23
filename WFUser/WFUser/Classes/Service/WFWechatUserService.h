//
//  WFWechatUserService.h
//  ADSRouter
//
//  Created by Andy on 2018/1/19.
//

#import <Foundation/Foundation.h>

@class WFWechatUser;
@interface WFWechatUserService : NSObject

- (void)getWechatUserWithAccessToken:(NSString*)accessToken openId:(NSString*)openId callback:(void(^)(WFWechatUser *user)) callback;

@end
