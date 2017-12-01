//
//  WFProduct.h
//  ADSRouter
//
//  Created by Andy on 2017/11/7.
//

#import <Foundation/Foundation.h>

@class WFProductShop, WFProductDetailFeature;

@interface WFProductInfo : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *value;

@end


@interface WFProductIntroImg : NSObject

@property (nonatomic, assign) float ratio;
@property (nonatomic, copy) NSString *url;

@end

@interface WFProductSelectedFeature :NSObject

@property (nonatomic, assign) NSInteger featureId;
@property (nonatomic, assign) NSInteger optionId;

@end

@interface WFProduct : NSObject

@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *productGroupId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, assign) float price;
@property (nonatomic, assign) float shipFee;
@property (nonatomic, strong) NSArray<NSString*> *coverImgs;
@property (nonatomic, strong) NSArray<WFProductInfo*> *infoArr;
@property (nonatomic, strong) NSArray<WFProductIntroImg*> *introImgArr;
@property (nonatomic, strong) NSArray<WFProductSelectedFeature*> *selectedFeatures;
@property (nonatomic, strong) NSArray<WFProductDetailFeature*> *features;
@property (nonatomic, strong) WFProductShop *shop;

- (NSString*)stringlifyFeatures;

@end
