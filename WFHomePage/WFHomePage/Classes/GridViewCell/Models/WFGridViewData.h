//
//  WFGridLayoutRow.h
//  WFGridLayout
//
//  Created by Andy on 2017/6/21.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WFGridViewData : NSObject

@property (nonatomic, strong) NSArray<WFGridViewData*> *cells;
@property (nonatomic, copy) NSString *orientation;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, assign) double weight;
@property (nonatomic, strong) NSString *actionUrl;

@end
