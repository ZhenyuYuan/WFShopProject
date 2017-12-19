//
//  WFProductDataService.h
//  WFProduct
//
//  Created by Andy on 2017/11/14.
//

#import <Foundation/Foundation.h>

@class WFProduct, WFProductDetailFeature, WFProductShipAddress, WFProductShop, WFProductShareItem, WFProductComment;
@interface WFProductDataService : NSObject

- (void)collectProduct:(NSString*)productId callback:(void(^)(BOOL))callback;

- (void)getProductIdWithFeatures:(NSArray<WFProductDetailFeature*>*)features productGroupId:(NSString*)productGroupId callback:(void(^)(NSString* productId))callback;

- (void)getProductWithProductId:(NSString*)productId callback:(void(^)(WFProduct* product))callback;

- (void)getProductFeatureWithProductId:(NSString*)productId callback:(void(^)(NSArray<WFProductDetailFeature*> *features)) callback;

- (void)getShipAddressWithUserId:(NSString*)userId callback:(void(^)(NSArray<WFProductShipAddress*>*addressArr))callback;

- (void)getShopWithShopId:(NSString*)shopId callback:(void(^)(WFProductShop *shop))callback;

- (BOOL)isAllFeaturesSelected:(NSArray<WFProductDetailFeature*>*)features;

- (void)getShareItems:(void(^)(NSArray<WFProductShareItem*> *shareItems)) callback;

- (void)getProductCommentWithProductId:(NSString*)productId page:(NSInteger)page callback:(void(^)(NSArray<WFProductComment*>*))callback;


- (void)addProductToCart:(NSString*)productId amount:(NSInteger)amount callback:(void(^)(BOOL))callback;

@end
