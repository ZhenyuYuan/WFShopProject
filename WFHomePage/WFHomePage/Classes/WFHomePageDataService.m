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

+ (void)load {
    //[BeeHive shareInstance] registerService:@protocol() service:<#(__unsafe_unretained Class)#>
}

- (void)getHomePageRows:(void (^)(NSArray<WFHomePageRow *> *))callback {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"homepage" ofType:@"json"];
    NSString *json = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *rows = [self parseRowData:json];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (callback) {
            callback(rows);
        }
    });
}

- (NSArray<WFHomePageRow*>*)parseRowData:(id)response {
    NSDictionary *styleMapping = @{@"carousel_view":@"WFBanner", @"grid_view":@"WFGridViewData",@"separator_view":@"WFSeparatorData"};
    NSMutableArray *rows = [NSMutableArray array];
    WFNetworkResponse *responseEntity = [WFNetworkResponse yy_modelWithJSON:response];
    for (id row in responseEntity.data[@"rows"]) {
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
