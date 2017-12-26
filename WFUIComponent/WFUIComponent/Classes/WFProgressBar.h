//
//  WFProgressBar.h
//  ADSRouter
//
//  Created by Andy on 2017/12/25.
//

#import <UIKit/UIKit.h>

@interface WFProgressBar : UIView

@property (nonatomic, assign) BOOL hideOnComplete;

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, assign) double progress;

@end
