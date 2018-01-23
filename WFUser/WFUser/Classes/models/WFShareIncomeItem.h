//
//  WFShareIncomeItem.h
//  ADSRouter
//
//  Created by Andy on 2018/1/22.
//

#import <Foundation/Foundation.h>

@interface WFShareIncomeItem : NSObject

@property (nonatomic, copy) NSString *itemId;
@property (nonatomic, assign) NSInteger createdAt;
@property (nonatomic, copy) NSString *user;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, assign) double amount;
@property (nonatomic, assign) double shareAmount;

@end
