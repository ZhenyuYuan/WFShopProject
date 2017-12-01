//
//  DCShowTypeThreeCell.m
//  CDDMall
//
//  Created by apple on 2017/6/25.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "WFSelectDeliverAddressCell.h"

// Controllers

// Models

// Views

// Vendors
#import "Masonry.h"
// Categories
#import "UIColor+WFColor.h"
#import "UIFont+WFFont.h"
// Others
#import "WFConsts.h"

@interface WFSelectDeliverAddressCell ()



@end

@implementation WFSelectDeliverAddressCell

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
    self.leftTitleLable.text = @"送至";
    self.contentLabel.text = @"地址";
    self.hintLabel.text = @"由DC商贸配送监管";
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.hintLabel.font = [UIFont wf_pfr10];
    [self addSubview:self.iconImageView];
    self.iconImageView.image = [UIImage imageNamed:@"location" inBundle:[self _bundle] compatibleWithTraitCollection:nil];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.leftTitleLable.mas_right)setOffset:WFMargin];
        make.centerY.mas_equalTo(self.leftTitleLable);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.iconImageView.mas_right)setOffset:WFMargin];
        make.centerY.mas_equalTo(self.leftTitleLable);
    }];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView);
        make.top.mas_greaterThanOrEqualTo(self.iconImageView.mas_bottom).offset(8);
        make.top.mas_greaterThanOrEqualTo(self.contentLabel.mas_bottom).offset(8);
    }];
    
}

- (void)setShipAddress:(NSString *)shipAddress {
    if (shipAddress && _shipAddress != shipAddress) {
        _shipAddress = shipAddress;
        self.contentLabel.text = _shipAddress;
    }
}

@end
