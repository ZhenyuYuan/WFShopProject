//
//  AppDelegate.m
//  WFShop
//
//  Created by Andy on 2017/10/11.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "AppDelegate.h"
#import "BeeHive.h"
#import "WFAppLaunchServiceProtocol.h"
#import "UIColor+WFColor.h"
#import "ADSRouter.h"
#import "WFNotFoundVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [BHContext shareInstance].application = application;
    [BHContext shareInstance].launchOptions = launchOptions;
//    [BHContext shareInstance].moduleConfigName = @"BeeHive.bundle/BeeHive";//可选，默认为BeeHive.bundle/BeeHive.plist
//    [BHContext shareInstance].serviceConfigName = @"BeeHive.bundle/BHService";
    
    [BeeHive shareInstance].enableException = YES;
    [[BeeHive shareInstance] setContext:[BHContext shareInstance]];

    
    [[ADSRouter sharedRouter] setRouteMismatchCallback:^(ADSURL *url) {
        NSLog(@"mismatch url:%@", url.absoluteString);
        [[ADSRouter sharedRouter] openUrlString:[NSString stringWithFormat:@"wfshop://notfound?url=%@", url.absoluteString]];
    }];
    id<WFAppLaunchServiceProtocol> appLaunchService = [[BeeHive shareInstance] createService:@protocol(WFAppLaunchServiceProtocol)];
    UIViewController *rootVC = [appLaunchService rootVC];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = rootVC;
    self.window.tintColor = [UIColor wf_mainColor];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
