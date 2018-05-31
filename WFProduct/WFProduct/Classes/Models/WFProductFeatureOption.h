//
//  WFProductFeatureOption.h
//  ADSRouter
//
//  Created by Andy on 2017/11/14.
//

#import <Foundation/Foundation.h>

@interface WFProductFeatureOption : NSObject

@property (nonatomic, assign) NSInteger optionId;
@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) BOOL isSelected;

@end
