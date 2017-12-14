//
//  WFHistorySearchItem.h
//  ADSRouter
//
//  Created by Andy on 2017/10/17.
//

#import <Foundation/Foundation.h>
#import "Realm.h"

@interface WFHistorySearchItem : RLMObject

@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *query;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, assign) NSInteger updatedAt;

@end
