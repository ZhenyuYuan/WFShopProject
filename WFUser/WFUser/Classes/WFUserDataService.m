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
#import "WFNetwork.h"
#import "WFUser.h"

@implementation WFUserDataService

- (void)getFunctions:(void (^)(NSArray<WFUserNormalFunctionGroup *> *funcGroups))callback {
    NSString *filePath = [WFGetBundle(@"WFUser") pathForResource:@"normalFunctions" ofType:@"plist"];
    NSArray<WFUserNormalFunctionGroup*> *funcGroups = [NSArray yy_modelArrayWithClass:[WFUserNormalFunctionGroup class] file:filePath];
    if (callback) {
        callback(funcGroups);
    }
}

- (void)getUser:(void (^)(WFUser *))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"user" objId:nil path:nil];
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:nil option:WFRequestOptionGet|WFRequestOptionWithToken complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        callback([WFUser yy_modelWithJSON:obj.data]);
    }];
}

@end
