//
//  WFHistorySearchTest.m
//  WFShopTests
//
//  Created by Andy on 2017/12/13.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WFHistorySearchDataService.h"


@interface WFHistorySearchTest : XCTestCase

@end

@implementation WFHistorySearchTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAdd {
    
    WFHistorySearchDataService *dataService = [WFHistorySearchDataService new];
    [dataService deleteAll];
//    [dataService addHistorySearch:@"abc"];
//    [dataService getHistorySearchItems:^(NSArray<WFHistorySearchItem *> *items) {
//        [items enumerateObjectsUsingBlock:^(WFHistorySearchItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSLog(@"%@", obj);
//        }];
//    }];
}



@end
