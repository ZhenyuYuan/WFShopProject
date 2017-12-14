//
//  WFSearchDataService.h
//  WFSearch
//
//  Created by Andy on 2017/10/24.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WFSearchResultOrderBy) {
    WFSearchResultOrderByPriceASC,
    WFSearchResultOrderByPriceDESC,
    WFSearchResultOrderByAmountASC,
    WFSearchResultOrderByAmountDESC,
    WFSearchResultOrderByRateASC,
    WFSearchResultOrderByRateDESC,
};

@class WFSearchItem;
@interface WFSearchDataService : NSObject

- (void)getSearchResultWithQuery:(NSString*)query category:(NSString*)category orderBy:(WFSearchResultOrderBy)orderType page:(NSInteger)page callback:(void(^)(NSArray<WFSearchItem*> *))callblack;

@end
