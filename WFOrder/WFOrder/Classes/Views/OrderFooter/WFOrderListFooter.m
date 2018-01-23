//
//  WFOrderListFooterView.m
//  ADSRouter
//
//  Created by Andy on 2018/1/20.
//

#import "WFOrderListFooter.h"
#import "Masonry.h"
#import "WFUIComponent.h"

@interface WFOrderListFooter ()



@end

@implementation WFOrderListFooter


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _detailLabel = [UILabel new];
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_detailLabel];
        [self addSubview:_leftBtn];
        [self addSubview:_rightBtn];
        
        _detailLabel.textAlignment = NSTextAlignmentRight;
        _detailLabel.font = [UIFont wf_pfr13];
        _detailLabel.text = @"共2件商品 实付款: ￥37.30";
        
        _leftBtn.titleLabel.font = [UIFont wf_pfr13];
        [_leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        _rightBtn.titleLabel.font = [UIFont wf_pfr13];
        [_rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(8);
            make.leading.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
        }];
        
        [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(80));
            make.top.equalTo(self.detailLabel.mas_bottom).offset(8);
            make.trailing.equalTo(self.rightBtn.mas_leading).offset(-16);
            make.bottom.equalTo(self).offset(-8);
        }];
        
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(_leftBtn);
            make.trailing.equalTo(self.mas_trailing).offset(-16);
            make.centerY.equalTo(_leftBtn.mas_centerY);
        }];
    }
    return self;
}

- (void)leftBtnClicked {
    if (_leftBtnClickedBlk) {
        _leftBtnClickedBlk();
        
    }
}

- (void)rightBtnClicked {
    if (_rightBtnClickedBlk) {
        _rightBtnClickedBlk();
    }
}


@end
