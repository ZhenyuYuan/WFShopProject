//
//  WFOrderDataService.m
//  ADSRouter
//
//  Created by Andy on 2017/11/21.
//

#import "WFOrderDataService.h"
#import "WFOrderModels.h"
#import "YYModel.h"
#import "WFHelpers.h"
#import "WFNetwork.h"

@implementation WFOrderDataService

- (void)getOrdersWithUserId:(NSString *)userId callback:(void (^)(NSArray<WFOrder *> *))callback {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"order" ofType:@"json"];
    NSString *json = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *orders = [self parseOrders:json];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (callback) {
            callback(orders);
        }
    });
}

- (NSArray<WFOrder*>*)parseOrders:(id)response {
    WFNetworkResponse *responseEntity = [WFNetworkResponse yy_modelWithJSON:response];
    NSArray *orders = [NSArray yy_modelArrayWithClass:[WFOrder class] json:responseEntity.data];
    return orders;
}
@end
