//
//  WFRadioButton.m
//  ADSRouter
//
//  Created by Andy on 2017/11/24.
//

#import "WFRadioButton.h"
#import "WFHelpers.h"

@interface WFRadioButton ()

@property (nonatomic, copy) dispatch_block_t checkBlk;
@property (nonatomic, copy) dispatch_block_t uncheckBlk;

@property (nonatomic, strong) UIImage *checkedImg;
@property (nonatomic, strong) UIImage *uncheckedImg;

@property (nonatomic, assign) BOOL isChecked;
@end

@implementation WFRadioButton

+ (instancetype)radioButtonWithCheckBlk:(dispatch_block_t)checkBlk uncheckBlk:(dispatch_block_t)uncheckBlk {
    WFRadioButton *btn = [self buttonWithType:UIButtonTypeCustom];
    [btn setImage:btn.uncheckedImg forState:UIControlStateNormal];
    [btn addTarget:btn action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)btnClicked {
    self.isChecked = !_isChecked;
    if (_isChecked) {
        if (_checkBlk) _checkBlk();
    } else {
        if (_uncheckBlk) _uncheckBlk();
    }
}

- (void)setIsChecked:(BOOL)isChecked {
    _isChecked = isChecked;
    if (_isChecked) {
        [self setImage:self.checkedImg forState:UIControlStateNormal];
    } else {
        [self setImage:self.uncheckedImg forState:UIControlStateNormal];
    }
}

- (UIImage*)checkedImg {
    if (!_checkedImg) {
        _checkedImg = [[UIImage imageNamed:@"radio-checked" inBundle:WFGetBundle(@"WFUIComponent") compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return _checkedImg;
}

- (UIImage*)uncheckedImg {
    if (!_uncheckedImg) {
        _uncheckedImg = [UIImage imageNamed:@"radio" inBundle:WFGetBundle(@"WFUIComponent") compatibleWithTraitCollection:nil];
    }
    return _uncheckedImg;
}

@end
