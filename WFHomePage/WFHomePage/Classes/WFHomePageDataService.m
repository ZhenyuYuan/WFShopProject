//
//  WFHomePageDataService.m
//  ADSRouter
//
//  Created by Andy on 2017/10/13.
//

#import "WFHomePageDataService.h"
#import "BeeHive.h"
#import "YYModel.h"
#import "WFNetwork.h"

@implementation WFHomePageDataService

//- (void)getHomePageRows:(void (^)(NSArray<WFHomePageRow *> *))callback {
//    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"homepage" objId:nil path:nil];
//    __weak typeof(self) weakSelf = self;
//    [WFNetworkExecutor requestWithUrl:apiUrl parameters:nil option:WFRequestOptionGet complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
//        __strong typeof(self) sSelf = weakSelf;
//        if (sSelf && callback) {
//            callback([weakSelf parseRowData:obj.data]);
//        }
//    }];
//
//}

- (void)getHomePageData:(void(^)(NSArray<WFHomePageRow*> *rows))callback{
    //    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"category" objId:nil path:nil];
    //    __weak typeof(self) weakSelf = self;
    //    [WFNetworkExecutor requestWithUrl:apiUrl parameters:nil option:WFRequestOptionGet complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
    //        NSArray *categoryItems = [NSArray yy_modelArrayWithClass:[WFCategoryItem class] json:obj.data];
    //        if (callback) {
    //            callback(categoryItems);
    //        }
    //    }];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"homepage" ofType:@"json"];
    NSString *json = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *homepageDatas =[self parseRowData:[NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:NULL]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (callback) {
            callback(homepageDatas);
        }
    });
}

//- (void)getShopHomePageRowsWithShopId:(NSString *)shopId callback:(void (^)(NSArray<WFHomePageRow *> *))callback {
//    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"shop" objId:shopId path:@"homepage"];
//    __weak typeof(self) weakSelf = self;
//    [WFNetworkExecutor requestWithUrl:apiUrl parameters:nil option:WFRequestOptionGet complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
//        __strong typeof(self) sSelf = weakSelf;
//        if (sSelf && callback) {
//            callback([weakSelf parseRowData:obj.data]);
//        }
//    }];
//}

- (NSArray<WFHomePageRow*>*)parseRowData:(id)response {
    NSDictionary *styleMapping = @{@"carousel_view":@"WFBanner", @"grid_view":@"WFGridViewData",@"separator_view":@"WFSeparatorData"};
    NSMutableArray *rows = [NSMutableArray array];
    NSLog(@"准备进循环啦");
    for (id row in response[@"rows"]) {
        NSLog(@"进循环啦");
        WFHomePageRow *homePageRow = [WFHomePageRow yy_modelWithJSON:row];
        NSLog(@"初始化好了homepagerow啦啦啦");
        NSLog(@"我是styleid啦啦%@啦啦", homePageRow.styleId);
        if (homePageRow.styleId) {
            NSLog(@"你好啊%@",homePageRow.styleId);
            NSString *modelClsName = styleMapping[homePageRow.styleId];
            if (modelClsName && ![modelClsName isEqualToString:@""]) {
                homePageRow.data = [NSClassFromString(modelClsName) yy_modelWithJSON:homePageRow.data];
                [rows addObject:homePageRow];
            }
        }
    }
    return rows.copy;
}


//- (NSArray<WFHomePageRow*>*)parseRowData:(id)response {
//    NSDictionary *styleMapping = @{@"carousel_view":@"WFBanner", @"grid_view":@"WFGridViewData",@"separator_view":@"WFSeparatorData"};
//    NSMutableArray *rows = [NSMutableArray array];
//    for (id row in response[@"rows"]) {
//        WFHomePageRow *homePageRow = [WFHomePageRow yy_modelWithJSON:row];
//        if (homePageRow.styleId) {
//            NSString *modelClsName = styleMapping[homePageRow.styleId];
//            if (modelClsName && ![modelClsName isEqualToString:@""]) {
//                homePageRow.data = [NSClassFromString(modelClsName) yy_modelWithJSON:homePageRow.data];
//                [rows addObject:homePageRow];
//            }
//        }
//    }
//    return rows;
//}
@end
