//
//  WFWechatUser.h
//  ADSRouter
//
//  Created by Andy on 2018/1/19.
//

#import <Realm/Realm.h>
#import <Foundation/Foundation.h>

@interface WFWechatAuthorizeObj : RLMObject

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, copy) NSString *unionId;
@property (nonatomic, copy) NSString *openId;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, assign) NSInteger updatedAt;

@end
