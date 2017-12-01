//
//  UIColor+Extension.m
//  ASByrApp
//
//  Created by lxq on 16/4/14.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "UIColor+WFColor.h"

static NSString * const kMainColor = @"#F28B12";
static NSString * const kMainBackgroundColor = @"#F5F5F5";
static NSString * const kPlaceHolderColor = @"#ADADAD";
static NSString * const kRedColor = @"#FF0000";
static NSString * const kLightRedColor = @"#E9232E";

@implementation UIColor (WFColor)

+ (UIColor *)wf_darkGrayColor {
    return [UIColor darkGrayColor];
}

+ (UIColor *)wf_borderGrayColor {
    return [self lightGrayColor];
}

+ (UIColor *)wf_mainColor {
    return [UIColor wf_colorWithHexString:kMainColor];
}

+ (UIColor *)wf_mainBackgroundColor {
    return [UIColor wf_colorWithHexString:kMainBackgroundColor];
}

+ (UIColor *)wf_placeHolderColor {
    return [UIColor wf_colorWithHexString:kPlaceHolderColor];
}

+ (UIColor *)wf_redColor {
    return [UIColor wf_colorWithHexString:kRedColor];
}

+ (UIColor *)wf_lightRedColor {
    return [UIColor wf_colorWithHexString:kLightRedColor];
}

+ (UIColor *)wf_lightGrayColor {
    return [UIColor lightGrayColor];
}



+ (UIColor *)wf_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

+ (UIColor *)wf_colorWithHexString:(NSString *)color
{
    return [self wf_colorWithHexString:color alpha:1.0f];
}

@end
