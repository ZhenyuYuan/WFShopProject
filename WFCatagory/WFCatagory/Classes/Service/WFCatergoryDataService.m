//
//  WFCatergoryDataService.m
//  ADSRouter
//
//  Created by Andy on 2017/10/19.
//

#import "WFCatergoryDataService.h"
#import "WFCategoryItem.h"
#import "YYModel.h"
@implementation WFCatergoryDataService


- (void)getCategoryData:(void (^)(NSArray<WFCategoryItem *> *))callback {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"category" ofType:@"json"];
    NSString *json = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *categoryItems = [self parseCategoryData:[NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:NULL]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (callback) {
            callback(categoryItems);
        }
    });
}

- (NSArray*)parseCategoryData:(id)jsonData {
    NSMutableArray *categoryItems = [NSMutableArray array];
    for (id category in jsonData[@"data"]) {
        [categoryItems addObject:[WFCategoryItem yy_modelWithJSON:category]];
    }
    return categoryItems.copy;
}

@end
