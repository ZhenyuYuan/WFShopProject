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
//    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"search" objId:nil path:nil];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:@(orderType) forKey:@"order_type"];
//    if (query) {
//        [params setObject:query forKey:@"q"];
//    }
//    if (category) {
//        [params setObject:category forKey:@"category"];
//    }
//
//    [WFNetworkExecutor requestWithUrl:apiUrl parameters:params.copy option:WFRequestOptionGet complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
//        NSArray<WFSearchItem*> *items = [NSArray yy_modelArrayWithClass:[WFSearchItem class] json:obj.data];
//        callblack(items);
//    }];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"search_result" ofType:@"json"];
    NSString *json = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(orderType) forKey:@"order_type"];
    if (query) {
        [params setObject:query forKey:@"q"];
    }
    if (category) {
        [params setObject:category forKey:@"category"];
    }
 
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray<WFSearchItem*> *items = [self parseSearchData:[NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:NULL]];
        callblack(items);
    });
 
}

- (NSArray*)parseSearchData:(id)jsonData {
    NSMutableArray *searchItems = [NSMutableArray array];
    for (id item in jsonData[@"data"]) {
        [searchItems addObject:[WFSearchItem yy_modelWithJSON:item]];
    }
    return searchItems.copy;
}
@end
