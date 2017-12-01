//
//  WFProduct.m
//  ADSRouter
//
//  Created by Andy on 2017/11/7.
//

#import "WFProduct.h"
#import "WFProductDetailFeature.h"
#import "WFProductFeatureOption.h"



@implementation WFProductInfo

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"name" : @"info_name",
             @"value":@"info_value"
             };
}

@end

@implementation WFProductIntroImg

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"url":@"img_url"};
}

@end

@implementation WFProductSelectedFeature

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"featureId" : @"feature_id",
             @"optionId":@"option_id"
             };
}

@end

@implementation WFProduct

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"coverImgs" : [NSString class],
             @"infoArr" : [WFProductInfo class],
             @"introImgArr" : [WFProductIntroImg class],
             @"selectedFeatures" : [WFProductSelectedFeature class],
             @"features" : [WFProductDetailFeature class],
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"productId" : @"id",
             @"productGroupId":@"product_group_id",
             @"subTitle":@"sub_title",
             @"coverImgs":@"img_urls",
             @"infoArr":@"product_info",
             @"introImgArr":@"intro_imgs",
             @"selectedFeatures":@"product_features",
             @"shipFee":@"ship_fee",
             @"commentCount":@"comment_count"
             };
}

- (NSArray<WFProductDetailFeature*>*)features {
    [_features enumerateObjectsUsingBlock:^(WFProductDetailFeature * _Nonnull feature, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger featureId = feature.featureId;
        [self.selectedFeatures enumerateObjectsUsingBlock:^(WFProductSelectedFeature * _Nonnull selectedFeature, NSUInteger idx, BOOL * _Nonnull stop) {
            if (featureId == selectedFeature.featureId) {
                NSInteger selectedOptionId = selectedFeature.optionId;
                [feature.options enumerateObjectsUsingBlock:^(WFProductFeatureOption * _Nonnull option, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (option.optionId == selectedOptionId) {
                        option.isSelected = YES;
                        *stop = YES;
                    }
                }];
                *stop = YES;
            }
        }];
    }];
    _selectedFeatures = nil;
    return _features;
}

- (NSString*)stringlifyFeatures {
    NSMutableString *featureString = [NSMutableString string];
    [_selectedFeatures enumerateObjectsUsingBlock:^(WFProductSelectedFeature * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger selectedFeatureId = obj.featureId;
        NSInteger selectedOptionId = obj.optionId;
        [_features enumerateObjectsUsingBlock:^(WFProductDetailFeature * _Nonnull feature, NSUInteger idx, BOOL * _Nonnull stop) {
            if (selectedFeatureId == feature.featureId) {
                [feature.options enumerateObjectsUsingBlock:^(WFProductFeatureOption * _Nonnull option, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (selectedOptionId == option.optionId) {
                        [featureString appendString:option.name];
                        [featureString appendString:@","];
                        *stop = YES;
                    }
                }];
            }
        }];
    }];
    return featureString.copy;
}

@end
