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
#import "WFLaunchAdProtocol.h"
#import "UIColor+WFColor.h"
#import "ADSRouter.h"
#import "WFNotFoundVC.h"
#import "WXApi.h"
#import "ADSRouter.h"
#import "QTouchposeApplication.h"


@interface UIWindow (WFShakeMotion)
@end

@implementation UIWindow (WFShakeMotion)

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [[ADSRouter sharedRouter] openUrlString:@"wfshop://debug"];
    }
}

@end

@interface AppDelegate () <WXApiDelegate>

@end

@implementation AppDelegate
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [BHContext shareInstance].application = application;
    [BHContext shareInstance].launchOptions = launchOptions;
    [BHContext shareInstance].moduleConfigName = @"BeeHive.bundle/BeeHive";//可选，默认为BeeHive.bundle/BeeHive.plist
    [BHContext shareInstance].serviceConfigName = @"BeeHive.bundle/BHService";
    
    [BeeHive shareInstance].enableException = YES;
    [[BeeHive shareInstance] setContext:[BHContext shareInstance]];

    
    [[ADSRouter sharedRouter] setRouteMismatchCallback:^(ADSURL *url) {
        NSLog(@"mismatch url:%@", url.absoluteString);
        [[ADSRouter sharedRouter] openUrlString:[NSString stringWithFormat:@"wfshop://notfound?url=%@", url.absoluteString]];
    }];
    
    
    [WXApi registerApp:@"wxe7798aead7625419"];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor blackColor];
    id<WFAppLaunchServiceProtocol> appLaunchService = [[BeeHive shareInstance] createService:@protocol(WFAppLaunchServiceProtocol)];
    UIViewController *rootVC = [appLaunchService rootVC];
    
    id<WFLaunchAdProtocol> launchAdService = [[BeeHive shareInstance] createService:@protocol(WFLaunchAdProtocol)];
    UIViewController *adVc = [launchAdService launchAdVC:^{
        self.window.rootViewController = rootVC;
    }];
    self.window.rootViewController = adVc;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.window.rootViewController != rootVC) {
            self.window.rootViewController = rootVC;
        }
    });
    self.window.tintColor = [UIColor wf_mainColor];
    [self.window makeKeyAndVisible];
    
    QTouchposeApplication *touchposeApplication = (QTouchposeApplication *)application;
    touchposeApplication.alwaysShowTouches = YES;
    touchposeApplication.showTouchesWhenKeyboardShown = YES;
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [super application:app openURL:url options:options];
    NSLog(@"微信登录回调");
    return [WXApi handleOpenURL:url delegate:self];
}

-(void) onReq:(BaseReq*)req {
    
}

-(void) onResp:(BaseResp*)resp {
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp* response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                [[ADSRouter sharedRouter] openUrlString:@"wfshop://wechatPayResult?result=success"];
                break;
            default:
                [[ADSRouter sharedRouter] openUrlString:@"wfshop://wechatPayResult?result=fail"];
                break;
        }
    }
}

@end
