//
//  WFProductDetailFeature.h
//  ADSRouter
//
//  Created by Andy on 2017/11/13.
//

#import <Foundation/Foundation.h>

@class WFProductFeatureOption;
@interface WFProductDetailFeature : NSObject

@property (nonatomic, assign) NSInteger featureId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray<WFProductFeatureOption*> *options;

@end
