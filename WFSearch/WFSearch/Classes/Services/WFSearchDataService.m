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
    NSString *apiUrl = [WFAPIFactory2 URLWithNameSpace:@"product" objId:nil path:@"/search"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:@(orderType) forKey:@"order_type"];
    if (query) {
        [params setObject:query forKey:@"specialty_name"];
    }
    [params setObject:@(--page) forKey:@"page"];
    [params setObject:@(10) forKey:@"rows"];
//    if (category) {
//        [params setObject:category forKey:@"category"];
//    }

    [WFNetworkExecutor2 requestWithUrl:apiUrl parameters:params.copy option:WFRequestOptionGet complete:^(NSURLResponse *response, WFNetworkResponseObj2 *obj, NSError *error) {
//        NSArray<WFSearchItem*> *items = [NSArray yy_modelArrayWithClass:[WFSearchItem class] json:obj.data];
//        callblack(items);
        NSMutableArray<WFSearchItem*> *items = [NSMutableArray array];
        for (id row in obj.obj[@"rows"]) {
            WFSearchItem *item = [WFSearchItem new];
            item.itemId = row[@"specialty"][@"id"];
            item.imgUrl = row[@"specialty"][@"icon"] ?: @"";
            item.name = [NSString stringWithFormat:@"%@-%@", row[@"specialty"][@"name"], row[@"specification"][@"specification"]];
            item.price = [row[@"specialty"][@"pPrice"] floatValue];
            item.commentCount = 100;
            [items addObject:item];
        }
        callblack(items);
    }];
   
}


@end
