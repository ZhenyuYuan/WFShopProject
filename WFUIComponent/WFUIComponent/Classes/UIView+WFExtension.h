//
//  UIView+DCExtension.h
//  CDDStoreDemo
//
//  Created by apple on 2017/3/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WFExtension)


@property (nonatomic , assign) CGFloat wf_width;
@property (nonatomic , assign) CGFloat wf_height;
@property (nonatomic , assign) CGSize  wf_size;
@property (nonatomic , assign) CGFloat wf_x;
@property (nonatomic , assign) CGFloat wf_y;
@property (nonatomic , assign) CGPoint wf_origin;
@property (nonatomic , assign) CGFloat wf_centerX;
@property (nonatomic , assign) CGFloat wf_centerY;
@property (nonatomic , assign) CGFloat wf_right;
@property (nonatomic , assign) CGFloat wf_bottom;

- (BOOL)intersectWithView:(UIView *)view;

+ (instancetype)wf_viewFromXib;

+ (instancetype)wf_viewFromXibInBundle:(NSBundle*)bundle;

- (BOOL)isShowingOnKeyWindow;

@end
