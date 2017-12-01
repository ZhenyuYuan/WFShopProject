//
//  DCShowTypeTwoCell.m
//  CDDMall
//
//  Created by apple on 2017/6/25.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "WFProductShipFeeCell.h"

// Controllers

// Models

// Views

// Vendors
#import "Masonry.h"
// Categories
#import "UIFont+WFFont.h"
// Others
#import "WFConsts.h"

@interface WFProductShipFeeCell ()



@end

@implementation WFProductShipFeeCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpData];
    }
    return self;
}

- (void)setUpData
{
    self.isHasindicateButton = NO;
    self.leftTitleLable.text = @"运费";
    self.contentLabel.text = @"免运费";
    self.hintLabel.text = @"支持7天无理由退货";
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.hintLabel.font = [UIFont wf_pfr10];
    [self addSubview:self.iconImageView];
    self.iconImageView.image = [UIImage imageNamed:@"round-check" inBundle:[self _bundle] compatibleWithTraitCollection:nil];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.leftTitleLable.mas_right)setOffset:WFMargin];
        make.centerY.mas_equalTo(self.leftTitleLable);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftTitleLable);
        [make.top.mas_equalTo(self.leftTitleLable.mas_bottom)setOffset:WFMargin];
        make.bottom.mas_equalTo(self).offset(-WFMargin);
    }];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.iconImageView.mas_right)setOffset:WFMargin];
        make.centerY.mas_equalTo(self.iconImageView);
    }];
    
}

#pragma mark - Setter Getter Methods


@end
