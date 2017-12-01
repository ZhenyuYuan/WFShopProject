//
//  WFSearchFooterView.m
//  ADSRouter
//
//  Created by Andy on 2017/11/22.
//

#import "WFSearchFooterView.h"
#import "Masonry.h"
#import "WFUIComponent.h"
#import "WFConsts.h"

@interface WFSearchFooterView ()

@property (nonatomic, strong) UIButton *delbtn;

@end

@implementation WFSearchFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    _delbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _delbtn.titleLabel.font = [UIFont wf_pfr15];
    [_delbtn setTitle:@"清空历史记录" forState:UIControlStateNormal];
    [_delbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_delbtn addTarget:self action:@selector(delBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_delbtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_delbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).offset(WFMargin);
        make.right.bottom.mas_equalTo(self).offset(-WFMargin);
    }];
}

- (void)delBtnClicked {
    if (_didClickDelBtn) {
        _didClickDelBtn();
    }
}

@end
