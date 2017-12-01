//
//  WFCategoryService.m
//  ADSRouter
//
//  Created by Andy on 2017/10/18.
//

#import "WFCategoryService.h"
#import "BeeHive.h"
#import "WFCategoryProtocol.h"
#import "WFCatagoryVC.h"

@interface WFCategoryService () <WFCategoryProtocol>
@end
@implementation WFCategoryService

+ (void)load {
    [[BeeHive shareInstance] registerService:@protocol(WFCategoryProtocol) service:[self class]];
}

- (UIViewController*)categoryVC {
    return [WFCatagoryVC new];
}

@end
