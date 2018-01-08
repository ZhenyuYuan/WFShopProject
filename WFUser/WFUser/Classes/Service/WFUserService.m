//
//  WFUserService.m
//  ADSRouter
//
//  Created by Andy on 2017/11/17.
//

#import "WFUserService.h"
#import "WFUserProtocol.h"
#import "BeeHive.h"
#import "WFMeVC.h"
#import "WFHelpers.h"
#import "WFUserCenter.h"

@interface WFUserService () <WFUserProtocol>
@end

@implementation WFUserService

+ (void)load {
//#ifndef DEBUG
    [[BeeHive shareInstance] registerService:@protocol(WFUserProtocol) service:self.class];
//#endif
}

- (BOOL)isLogined {
    return [[WFUserCenter sharedCenter] isUserLogined];
}


- (UIViewController*)userVC {
    return [[UIStoryboard storyboardWithName:@"WFUser" bundle:WFGetBundle(@"WFUser")] instantiateViewControllerWithIdentifier:@"WFMeVC"];
}

@end
