//
//  WFCategoryItem
//
//
//  Created by Andy on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFCategoryItem : NSObject


@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, strong) NSArray<WFCategoryItem*> *children;

@end
