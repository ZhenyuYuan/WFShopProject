//
//  WFUserCenter.m
//  ADSRouter
//
//  Created by Andy on 2017/12/14.
//

#import "WFUserCenter.h"
#import "WFUserToken.h"
#import "WFWechatLoginService.h"
#import "WFWechatUserService.h"
#import "WFWechatAuthorizeObj.h"

@interface WFUserCenter()

@property (nonatomic, strong) WFUserToken *userToken;
@property (nonatomic, strong) WFWechatLoginService *loginService;
@property (nonatomic, strong) WFWechatUserService *wechatUserService;

@end

@implementation WFUserCenter

+ (instancetype)sharedCenter {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [WFUserCenter new];
    });
    return instance;
}

- (BOOL)isUserLogined {
//    return YES;
    return self.loginService.currentUserAuthorizeObj;
}

- (void)getCurrentUser:(void (^)(WFWechatUser *))callback {
    WFWechatAuthorizeObj *authorize = [self.loginService currentUserAuthorizeObj];
    [self.wechatUserService getWechatUserWithAccessToken:authorize.accessToken openId:authorize.openId callback:^(WFWechatUser *user) {
        if (callback) {
            callback(user);
        }
    }];
}

- (BOOL)logout {
    return [self.loginService logout];
}


- (WFWechatLoginService*)loginService {
    if (!_loginService) {
        _loginService = [WFWechatLoginService new];
    }
    return _loginService;
}

- (WFWechatUserService *)wechatUserService {
    if (!_wechatUserService) {
        _wechatUserService = [WFWechatUserService new];
    }
    return _wechatUserService;
}

@end
