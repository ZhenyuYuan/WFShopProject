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

@interface WFWechatLoginModule () <BHModuleProtocol>

@end

@implementation WFWechatLoginModule

@BeeHiveMod(WFWechatLoginModule)

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
