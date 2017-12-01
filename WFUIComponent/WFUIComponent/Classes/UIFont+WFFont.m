//
//  UIFont+WFFont.m
//  ADSRouter
//
//  Created by Andy on 2017/10/19.
//

#import "UIFont+WFFont.h"

#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"

@implementation UIFont (WFFont)

+ (instancetype)wf_pfr10 {
    return [self wf_pfrFontWithSize:10];
}

+ (instancetype)wf_pfr11 {
    return [self wf_pfrFontWithSize:11];
}

+ (instancetype)wf_pfr12 {
    return [self wf_pfrFontWithSize:12];
}

+ (instancetype)wf_pfr13 {
    return [self wf_pfrFontWithSize:13];
}

+ (instancetype)wf_pfr14 {
    return [self wf_pfrFontWithSize:14];
}

+ (instancetype)wf_pfr15 {
    return [self wf_pfrFontWithSize:15];
}

+ (instancetype)wf_pfr16 {
    return [self wf_pfrFontWithSize:16];
}

+ (instancetype)wf_pfr18 {
    return [self wf_pfrFontWithSize:18];
}

+ (instancetype)wf_pfr20 {
    return [self wf_pfrFontWithSize:20];
}

+ (instancetype)wf_pfrFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:PFR size:size];
}

@end

#undef PFR
