//
//  WFHomePageService.m
//  WFShop
//
//  Created by Andy on 2017/10/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFHomePageService.h"
#import "WFHomePageProtocol.h"
#import "WFHomePageVC.h"
#import "BeeHive.h"
#import <UIKit/UIKit.h>

@interface WFHomePageService () <WFHomePageProtocol>
@end

@implementation WFHomePageService

+ (void)load {
    [[BeeHive shareInstance] registerService:@protocol(WFHomePageProtocol) service:self.class];
}

- (UIViewController*)homepageVC {
    return [WFHomePageVC new];
}

@end
