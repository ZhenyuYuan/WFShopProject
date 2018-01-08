//
//  WFTestUserService.m
//  ADSRouter
//
//  Created by Andy on 2017/12/18.
//

#import "WFTestUserService.h"
#import "WFUserProtocol.h"
#import "BeeHive.h"
#import "WFHelpers.h"

@interface WFTestUserService () <WFUserProtocol>
@end

@implementation WFTestUserService

+ (void)load {
#ifdef DEBUG
  //  [[BeeHive shareInstance] registerService:@protocol(WFUserProtocol) service:self.class];
#endif
}

- (BOOL)isLogined {
    return YES;
}

- (UIViewController*)userVC {
    return [[UIStoryboard storyboardWithName:@"WFUser" bundle:WFGetBundle(@"WFUser")] instantiateViewControllerWithIdentifier:@"WFMeVC"];
}

@end
