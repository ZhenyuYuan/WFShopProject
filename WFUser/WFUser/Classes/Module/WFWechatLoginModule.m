//
//  WFWechatLoginModule.m
//  ADSRouter
//
//  Created by Andy on 2018/1/18.
//

#import "WFWechatLoginModule.h"
#import "BeeHive.h"
#import "ADSRouter.h"
#import "WFNetwork.h"
#import "WFWechatLoginService.h"
#import "BHServiceProtocol.h"
#import "BHConfig.h"
#import "BHAppDelegate.h"

#import "WFNetwork.h"

@interface ADSContext : NSObject



//global config
@property(nonatomic, strong) BHConfig *config;

//application appkey
@property(nonatomic, strong) NSString *appkey;
//customEvent>=1000
@property(nonatomic, assign) NSInteger customEvent;

@property(nonatomic, strong) UIApplication *application;

@property(nonatomic, strong) NSDictionary *launchOptions;

@property(nonatomic, strong) NSString *moduleConfigName;

@property(nonatomic, strong) NSString *serviceConfigName;

//3D-Touch model
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 80400
@property (nonatomic, strong) BHShortcutItem *touchShortcutItem;
#endif

//OpenURL model
@property (nonatomic, strong) BHOpenURLItem *openURLItem;

//Notifications Remote or Local
@property (nonatomic, strong) BHNotificationsItem *notificationsItem;

//user Activity Model
@property (nonatomic, strong) BHUserActivityItem *userActivityItem;

+ (instancetype)shareInstance;

- (void)addServiceWithImplInstance:(id)implInstance serviceName:(NSString *)serviceName;

- (id)getServiceInstanceFromServiceName:(NSString *)serviceName;

@end

#define ADS_EXPORT_MODULE()
@interface ADSModuleMediator : BeeHive

////save application global context
//@property(nonatomic, strong) BHContext *context;
//
//@property (nonatomic, assign) BOOL enableException;
//
//+ (instancetype)shareInstance;
//
//+ (void)registerDynamicModule:(Class) moduleClass;
//
//- (id)createService:(Protocol *)proto;
//
////Registration is recommended to use a static way
//- (void)registerService:(Protocol *)proto service:(Class) serviceClass;
//
//+ (void)triggerCustomEvent:(NSInteger)eventType;

@end

@interface WFWechatLoginModule () <BHModuleProtocol>

@end

@implementation WFWechatLoginModule


BH_EXPORT_MODULE()

- (void)modInit:(ADSContext *)context {
    id<WFAPIFactoryProtocol> apiFactory = [[BeeHive shareInstance] createService:@protocol(WFAPIFactoryProtocol)];
    NSString *apiurl = [apiFactory URLWithNameSpace:@"wechat" objId:nil path:@"config"];
    
    id<WFNetworkProtocol> networkService = [[BeeHive shareInstance] createService:@protocol(WFNetworkProtocol)];
    [networkService requestWithUrl:apiurl parameters:nil option:WFRequestOptionGet|WFRequestOptionWithToken complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        [obj.data writeToFile:@"wechat.json" options:NSDataWritingAtomic error:nil];
    }];
}

- (void)modOpenURL:(BHContext *)context {
    NSURL *url = context.openURLItem.openURL;
    if ([url.scheme isEqualToString:@"wxe7798aead7625419"]) {
        NSURLComponents *component = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
        [component.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.name isEqualToString:@"code"]) {
                [[ADSRouter sharedRouter] openUrlString:[NSString stringWithFormat:@"wfshop://wechatAuthorize?code=%@", obj.value]];
            }
        }];
    }
}

@end
