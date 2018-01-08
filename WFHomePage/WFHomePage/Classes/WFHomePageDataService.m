//
//  WFHomePageDataService.m
//  ADSRouter
//
//  Created by Andy on 2017/10/13.
//

#import "WFHomePageDataService.h"
#import "BeeHive.h"
#import "YYModel.h"
#import "WFNetwork.h"

@implementation WFHomePageDataService

- (void)getHomePageRows:(void (^)(NSArray<WFHomePageRow *> *))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"homepage" objId:nil path:nil];
    __weak typeof(self) weakSelf = self;
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:nil option:WFRequestOptionGet complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        __strong typeof(self) sSelf = weakSelf;
        if (sSelf && callback) {
            callback([weakSelf parseRowData:obj.data]);
        }
    }];
}

- (void)getShopHomePageRowsWithShopId:(NSString *)shopId callback:(void (^)(NSArray<WFHomePageRow *> *))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"shop" objId:shopId path:@"homepage"];
    __weak typeof(self) weakSelf = self;
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:nil option:WFRequestOptionGet complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        __strong typeof(self) sSelf = weakSelf;
        if (sSelf && callback) {
            callback([weakSelf parseRowData:obj.data]);
        }
    }];
}

- (NSArray<WFHomePageRow*>*)parseRowData:(id)response {
    NSDictionary *styleMapping = @{@"carousel_view":@"WFBanner", @"grid_view":@"WFGridViewData",@"separator_view":@"WFSeparatorData"};
    NSMutableArray *rows = [NSMutableArray array];
    for (id row in response[@"rows"]) {
        WFHomePageRow *homePageRow = [WFHomePageRow yy_modelWithJSON:row];
        if (homePageRow.styleId) {
            NSString *modelClsName = styleMapping[homePageRow.styleId];
            if (modelClsName && ![modelClsName isEqualToString:@""]) {
                homePageRow.data = [NSClassFromString(modelClsName) yy_modelWithJSON:homePageRow.data];
                [rows addObject:homePageRow];
            }
        }
    }
    return rows;
}
@end
