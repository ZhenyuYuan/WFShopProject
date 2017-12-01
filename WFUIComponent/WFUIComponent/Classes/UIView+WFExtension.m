//
//  UIView+WFExtension.m
//  CDDStoreDemo
//
//  Created by apple on 2017/3/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIView+WFExtension.h"

@implementation UIView (WFExtension)

- (CGFloat)wf_x
{
    return self.frame.origin.x;
}

- (void)setWf_x:(CGFloat)wf_x
{
    CGRect wfFrame = self.frame;
    wfFrame.origin.x = wf_x;
    self.frame = wfFrame;
}

-(CGFloat)wf_y
{
    return self.frame.origin.y;
}

-(void)setWf_y:(CGFloat)wf_y
{
    CGRect wfFrame = self.frame;
    wfFrame.origin.y = wf_y;
    self.frame = wfFrame;
}

-(CGPoint)wf_origin
{
    return self.frame.origin;
}

-(void)setWf_origin:(CGPoint)wf_origin
{
    CGRect wfFrame = self.frame;
    wfFrame.origin = wf_origin;
    self.frame = wfFrame;
}

-(CGFloat)wf_width
{
    return self.frame.size.width;
}

-(void)setWf_width:(CGFloat)wf_width
{
    CGRect wfFrame = self.frame;
    wfFrame.size.width = wf_width;
    self.frame = wfFrame;
}

-(CGFloat)wf_height
{
    return self.frame.size.height;
}

-(void)setWf_height:(CGFloat)wf_height
{
    CGRect wfFrame = self.frame;
    wfFrame.size.height = wf_height;
    self.frame = wfFrame;
}

-(CGSize)wf_size
{
    return self.frame.size;
}

- (void)setWf_size:(CGSize)wf_size
{
    CGRect wfFrame = self.frame;
    wfFrame.size = wf_size;
    self.frame = wfFrame;
}

-(CGFloat)wf_centerX{
    
    return self.center.x;
}

-(void)setWf_centerX:(CGFloat)wf_centerX{
    
    CGPoint wfFrame = self.center;
    wfFrame.x = wf_centerX;
    self.center = wfFrame;
}

-(CGFloat)wf_centerY{
    
    return self.center.y;
}

-(void)setWf_centerY:(CGFloat)wf_centerY{
    
    CGPoint wfFrame = self.center;
    wfFrame.y = wf_centerY;
    self.center = wfFrame;
}

- (CGFloat)wf_right{
    
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)wf_bottom{
    
    return CGRectGetMaxY(self.frame);
}

- (void)setWf_right:(CGFloat)wf_right{
    
    self.wf_x = wf_right - self.wf_width;
}

- (void)setWf_bottom:(CGFloat)wf_bottom{
    
    self.wf_y = wf_bottom - self.wf_height;
}

- (BOOL)intersectWithView:(UIView *)view{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}

- (BOOL)isShowingOnKeyWindow {
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

+(instancetype)wf_viewFromXib
{
    return [self wf_viewFromXibInBundle:[NSBundle mainBundle]];
}

+ (instancetype)wf_viewFromXibInBundle:(NSBundle *)bundle {
    return [bundle loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}


@end
