//
//  WFCartItem.h
//  ADSRouter
//
//  Created by Andy on 2017/11/22.
//

#import <Foundation/Foundation.h>

@interface WFCartShop : NSObject

@property (nonatomic, copy) NSString *shopId;
@property (nonatomic, copy) NSString *name;

@end

@interface WFCartProduct: NSObject

@property (nonatomic, copy) NSString *productId;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *coverImg;

@end

@interface WFCartItem : NSObject

@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong)  WFCartProduct *product;
@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, assign) BOOL isSelected;

@end

@interface WFCartItemGroup : NSObject

@property (nonatomic, strong) WFCartShop *shop;
@property (nonatomic, strong) NSMutableArray<WFCartItem*> *cartItems;
@property (nonatomic, assign) BOOL isSelected;

@end
