//
//  WFSearchDataService.h
//  WFSearch
//
//  Created by Andy on 2017/10/24.
//

#import <Foundation/Foundation.h>

@class WFSearchItem;
@interface WFSearchDataService : NSObject

- (void)getSearchResult:(void(^)(NSArray<WFSearchItem*> *items))callblack;

@end
