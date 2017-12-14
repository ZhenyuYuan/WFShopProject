//
//  WFHistorySearchDataService.m
//  ADSRouter
//
//  Created by Andy on 2017/12/13.
//

#import "WFHistorySearchDataService.h"
#import "Realm.h"
#import "WFHistorySearchItem.h"

@implementation WFHistorySearchDataService

- (void)addHistorySearch:(NSString *)query {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    WFHistorySearchItem *item = [[WFHistorySearchItem objectsWhere:[NSString stringWithFormat:@"query = '%@'", query]] firstObject];
    if (item) {
        item.updatedAt = [[NSDate date] timeIntervalSince1970];
    } else {
        item = [WFHistorySearchItem new];
        item.itemId = [[[WFHistorySearchItem allObjects] maxOfProperty:@"itemId"] integerValue] + 1;
        item.query = query;
        item.createdAt = [[NSDate date] timeIntervalSince1970];
        item.updatedAt = [[NSDate date] timeIntervalSince1970];
        [realm addObject:item];
    }
    [realm addOrUpdateObject:item];
    [realm commitWriteTransaction];
}

- (void)getHistorySearchItems:(void (^)(NSArray<WFHistorySearchItem *> *))callback {
    NSMutableArray<WFHistorySearchItem*> *res = [NSMutableArray array];
    RLMResults<WFHistorySearchItem*> *historyItems = [[WFHistorySearchItem allObjects] sortedResultsUsingKeyPath:@"updatedAt" ascending:NO];
    for (int idx = 0; idx < historyItems.count; ++idx) {
        [res addObject:historyItems[idx]];
    }
    callback(res.copy);
}

- (void)deleteHistorySearchItem:(WFHistorySearchItem *)historySearchItem {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObject:historySearchItem];
    [realm commitWriteTransaction];
}

- (void)deleteAll {
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}
@end
