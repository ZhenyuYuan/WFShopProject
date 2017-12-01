//
//  UIColor+Extension.h
//  ASByrApp
//
//  Created by lxq on 16/4/14.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WFColor)

+ (UIColor *)wf_lightGrayColor;

+ (UIColor *)wf_darkGrayColor;

+ (UIColor *)wf_borderGrayColor;

+ (UIColor *)wf_mainColor;

+ (UIColor *)wf_mainBackgroundColor;

+ (UIColor *)wf_placeHolderColor;

+ (UIColor *)wf_redColor;

+ (UIColor *)wf_lightRedColor;

+ (UIColor *)wf_colorWithHexString:(NSString*)color alpha:(CGFloat)alpha;

+ (UIColor *)wf_colorWithHexString:(NSString *)color;

@end
