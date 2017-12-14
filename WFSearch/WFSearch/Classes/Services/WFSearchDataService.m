//
//  WFSearchDataService.m
//  WFSearch
//
//  Created by Andy on 2017/10/24.
//

#import "WFSearchDataService.h"
#import "WFSearchItem.h"
#import "YYModel.h"
#import "WFNetwork.h"

@implementation WFSearchDataService

- (void)getSearchResultWithQuery:(NSString *)query category:(NSString *)category orderBy:(WFSearchResultOrderBy)orderType page:(NSInteger)page callback:(void (^)(NSArray<WFSearchItem *> *))callblack {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"search" objId:nil path:nil];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(orderType) forKey:@"order_type"];
    if (query) {
        [params setObject:query forKey:@"q"];
    }
    if (category) {
        [params setObject:category forKey:@"category"];
    }

    [WFNetworkExecutor requestWithUrl:apiUrl parameters:params.copy option:WFRequestOptionGet complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        NSArray<WFSearchItem*> *items = [NSArray yy_modelArrayWithClass:[WFSearchItem class] json:obj.data];
        callblack(items);
    }];
}


@end
