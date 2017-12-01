//
//  WFUserNormalFunctionGroup.m
//  ADSRouter
//
//  Created by Andy on 2017/11/20.
//

#import "WFUserNormalFunctionGroup.h"
#import "WFUserNormalFunction.h"

@implementation WFUserNormalFunctionGroup

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"functions" : [WFUserNormalFunction class]};
}

@end
