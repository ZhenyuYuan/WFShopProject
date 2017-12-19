//
//  WFOrderProduct.h
//  ADSRouter
//
//  Created by Andy on 2017/11/21.
//

#import <Foundation/Foundation.h>

@interface WFOrderProduct : NSObject

@property (nonatomic, copy) NSString *productId;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *coverImg;
@property (nonatomic, assign) NSInteger amount;

@end
