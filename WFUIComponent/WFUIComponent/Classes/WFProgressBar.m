//
//  WFProgressBar.m
//  ADSRouter
//
//  Created by Andy on 2017/12/25.
//

#import "WFProgressBar.h"

@interface WFProgressBar ()

@property (nonatomic, strong) CALayer *progressLayer;

@end

@implementation WFProgressBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _progressLayer = [[CALayer alloc] init];
        _progressLayer.frame = self.layer.frame;
        _progressLayer.backgroundColor = [UIColor blackColor].CGColor;
        [self.layer addSublayer:_progressLayer];
    }
    return self;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    _progressLayer.backgroundColor = _color.CGColor;
}

- (void)setProgress:(double)progress {
    _progress = progress;
    CGRect frame = self.frame;
    frame.size.width *= progress;
    frame.origin = CGPointMake(0, 0);
    _progressLayer.frame = frame;
    if (_hideOnComplete && _progress > 0.9999999) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setHidden:YES];
        });
    }
}

@end
