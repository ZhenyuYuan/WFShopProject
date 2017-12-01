//
//  WFSearchDataService.m
//  WFSearch
//
//  Created by Andy on 2017/10/24.
//

#import "WFSearchDataService.h"
#import "WFSearchItem.h"
#import "YYModel.h"

@implementation WFSearchDataService

- (void)getSearchResult:(void (^)(NSArray<WFSearchItem *> *items))callblack {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"search_result" ofType:@"json"];
    NSString *json = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *items = [self parseItemData:[NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:NULL]];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (callblack) {
            callblack(items);
        }
    });
}

- (NSArray<WFSearchItem*>*)parseItemData:(id)response {
    NSMutableArray *res = [NSMutableArray array];
    for (id item in response[@"data"]) {
        [res addObject:[WFSearchItem yy_modelWithJSON:item]];
    }
    return res;
}

@end
