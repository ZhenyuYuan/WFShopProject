//
//  NSURL+WFClearBackground.m
//  WFShop
//
//  Created by Andy on 2017/10/13.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "UINavigationBar+WFClearBackground.h"

@implementation UINavigationBar (WFClearBackground)

- (void)wf_setClearBackgroundColor {
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setTranslucent:YES];
    [self setShadowImage:[UIImage new]];
}

@end
