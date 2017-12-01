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


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
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
    
    
    NSLog(@"%@", [NSBundle bundleForClass:[WFNotFoundVC class]].bundlePath);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [[ADSRouter sharedRouter] openUrl:url];
    return YES;
}

@end
