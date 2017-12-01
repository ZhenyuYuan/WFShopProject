//
//  WFCatergoryDataService.h
//  ADSRouter
//
//  Created by Andy on 2017/10/19.
//

#import <Foundation/Foundation.h>

@class WFCategoryItem;
@interface WFCatergoryDataService : NSObject

- (void)getCategoryData:(void(^)(NSArray<WFCategoryItem*> *categoryItems))callback;

@end
