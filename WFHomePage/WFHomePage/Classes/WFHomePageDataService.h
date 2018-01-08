//
//  WFHomePageDataService.h
//  ADSRouter
//
//  Created by Andy on 2017/10/13.
//

#import <Foundation/Foundation.h>
#import "WFHomePageRow.h"

@interface WFHomePageDataService : NSObject

- (void)getHomePageRows:(void(^)(NSArray<WFHomePageRow*> *rows))callback;

- (void)getShopHomePageRowsWithShopId:(NSString*)shopId callback:(void(^)(NSArray<WFHomePageRow*> *rows))callback;

@end
