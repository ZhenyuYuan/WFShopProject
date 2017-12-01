//
//  WFUserDataService.m
//  ADSRouter
//
//  Created by Andy on 2017/11/20.
//

#import "WFUserDataService.h"
#import "YYModel.h"
#import "WFHelpers.h"
#import "WFUserNormalFunctionGroup.h"

@implementation WFUserDataService

- (void)getFunctions:(void (^)(NSArray<WFUserNormalFunctionGroup *> *funcGroups))callback {
    NSString *filePath = [WFGetBundle(@"WFUser") pathForResource:@"normalFunctions" ofType:@"plist"];
    NSArray<WFUserNormalFunctionGroup*> *funcGroups = [NSArray yy_modelArrayWithClass:[WFUserNormalFunctionGroup class] file:filePath];
    if (callback) {
        callback(funcGroups);
    }
}

@end
