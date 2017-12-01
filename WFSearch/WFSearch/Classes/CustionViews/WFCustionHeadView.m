//
//  DCCustionHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/12.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#define AuxiliaryNum 100

#import "WFCustionHeadView.h"

// Controllers

// Models

// Views

// Vendors
#import "Masonry.h"
// Categories
#import "UIView+WFExtension.h"
#import "UIColor+WFColor.h"
// Others

@interface WFCustionHeadView ()

/** 记录上一次选中的Button */
@property (nonatomic, assign) NSInteger selectIdx;

/** 记录上一次选中的Button底部View */
@property (nonatomic, strong) UIView *selectedIndicator;
@property (nonatomic, strong) NSMutableArray<MASConstraint*> *leftConstraints;

@property (nonatomic, strong) NSArray<UIButton*> *btns;

@end

@implementation WFCustionHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    NSArray *titles = @[@"价格",@"销量",@"评分"];
    NSMutableArray<UIButton*> *btns = [NSMutableArray arrayWithCapacity:titles.count];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btns[i] = btn;
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self);
            if (i > 0) {
                make.left.equalTo(btns[i-1].mas_right);
                make.width.equalTo(btns[0].mas_width);
            } else {
                make.left.mas_equalTo(self);
            }
            if (i + 1 == titles.count) {
                make.right.mas_equalTo(self);
            }
        }];
    }
    _btns = btns.copy;
    
    _selectedIndicator = [UIView new];
    _selectedIndicator.backgroundColor = [UIColor wf_mainColor];
    [self addSubview:_selectedIndicator];
    [_selectedIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_btns[0].mas_width);
        make.height.equalTo(@(3));
        make.bottom.mas_equalTo(self);
        _leftConstraints = [NSMutableArray arrayWithCapacity:_btns.count];
        for (NSInteger idx = 0; idx < _btns.count; ++idx) {
            _leftConstraints[idx] = make.left.equalTo(_btns[idx].mas_left).priorityMedium();
        }
    }];
    [self btnClicked:_btns[0]];
}

#pragma mark - 按钮点击
- (void)btnClicked:(UIButton*)sender {
    for (MASConstraint *constraint in _leftConstraints) {
        [constraint uninstall];
    }
    NSInteger idx = [_btns indexOfObject:sender];
    [self layoutIfNeeded];
    [_leftConstraints[idx] install];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self layoutIfNeeded];
    } completion:nil];
}


#pragma mark - Setter Getter Methods

@end
