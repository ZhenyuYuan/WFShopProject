//
//  WFCartService.m
//  ADSRouter
//
//  Created by Andy on 2017/11/23.
//

#import "WFCartService.h"
#import "BeeHive.h"
#import "WFCartProtocol.h"
#import "WFHelpers.h"
@implementation WFCartService

+ (void)load {
    [[BeeHive shareInstance] registerService:@protocol(WFCartProtocol) service:self.class];
}

- (UIViewController*)cartVC {
    return [[UIStoryboard storyboardWithName:@"WFCart" bundle:WFGetBundle(@"WFCart")] instantiateViewControllerWithIdentifier:@"WFCartVC"];
}

@end
