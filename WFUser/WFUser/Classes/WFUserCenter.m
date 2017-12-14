//
//  WFUserCenter.m
//  ADSRouter
//
//  Created by Andy on 2017/12/14.
//

#import "WFUserCenter.h"
#import "WFUserToken.h"

@interface WFUserCenter()

@property (nonatomic, strong) WFUserToken *userToken;

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
    return _userToken != nil;
}

@end
