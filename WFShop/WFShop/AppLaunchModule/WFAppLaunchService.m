//
//  WFAppLaunchService.m
//  WFShop
//
//  Created by Andy on 2017/10/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFAppLaunchService.h"
#import "WFAppLaunchServiceProtocol.h"
#import "BeeHive.h"
#import "WFHomePageProtocol.h"
#import "WFCategoryProtocol.h"
#import "WFCartProtocol.h"
#import "WFUserProtocol.h"
#import <UIKit/UIKit.h>

@interface WFAppLaunchService () <WFAppLaunchServiceProtocol>
@end

@implementation WFAppLaunchService

+ (void)load {
    [[BeeHive shareInstance] registerService:@protocol(WFAppLaunchServiceProtocol) service:[self class]];
}

- (UIViewController*)rootVC {
    id<WFHomePageProtocol> homepageService = [[BeeHive shareInstance] createService:@protocol(WFHomePageProtocol)];
    id<WFCategoryProtocol> categoryService = [[BeeHive shareInstance] createService:@protocol(WFCategoryProtocol)];
    id<WFUserProtocol> userService = [[BeeHive shareInstance] createService:@protocol(WFUserProtocol)];
    id<WFCartProtocol> cartService = [[BeeHive shareInstance] createService:@protocol(WFCartProtocol)];
    
    // Homepage
    UIViewController *homepageVC = [homepageService homepageVC];
    if (![homepageVC isMemberOfClass:[UINavigationController class]]) {
        homepageVC = [[UINavigationController alloc] initWithRootViewController:homepageVC];
    }
    UITabBarItem *homeTab = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"home"] selectedImage:[UIImage imageNamed:@"home-fill"]];
    homepageVC.tabBarItem = homeTab;

    // category
    UITabBarItem *catagoryTab = [[UITabBarItem alloc] initWithTitle:@"分类" image:[UIImage imageNamed:@"catagory"] selectedImage:[UIImage imageNamed:@"catagory-fill"]];
    UIViewController *catagoryVC = [categoryService categoryVC];
    if (![catagoryVC isMemberOfClass:[UINavigationController class]]) {
        catagoryVC = [[UINavigationController alloc] initWithRootViewController:catagoryVC];
    }
    catagoryVC.tabBarItem = catagoryTab;
    
    // cart
    UITabBarItem *cartTab = [[UITabBarItem alloc] initWithTitle:@"购物车" image:[UIImage imageNamed:@"cart"] selectedImage:[UIImage imageNamed:@"cart-fill"]];
    UIViewController *cartVC = [cartService cartVC];
    if (![cartVC isMemberOfClass:[UINavigationController class]]) {
        cartVC = [[UINavigationController alloc] initWithRootViewController:cartVC];
    }
    cartVC.tabBarItem = cartTab;
    
    // user
    UITabBarItem *userTab = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"user"] selectedImage:[UIImage imageNamed:@"user-fill"]];
    UIViewController *userVC = [userService userVC];
    if (![userVC isMemberOfClass:[UINavigationController class]]) {
        userVC = [[UINavigationController alloc] initWithRootViewController:userVC];
    }
    userVC.tabBarItem = userTab;
    
    UITabBarController *rootVC = [UITabBarController new];
    rootVC.viewControllers = @[homepageVC, catagoryVC, cartVC, userVC];
//    rootVC.viewControllers = @[catagoryVC, cartVC, userVC];
    return rootVC;
}

@end
