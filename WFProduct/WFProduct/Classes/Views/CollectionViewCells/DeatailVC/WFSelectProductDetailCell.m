//
//  DCShowTypeOneCell.m
//  CDDMall
//
//  Created by apple on 2017/6/25.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "WFSelectProductDetailCell.h"

// Controllers

// Models

// Views

// Vendors
#import "Masonry.h"
#import "WFConsts.h"
// Categories
#import "UIFont+WFFont.h"
// Others

@interface WFSelectProductDetailCell ()



@end

@implementation WFSelectProductDetailCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpData];
    }
    return self;
}

- (void)setUpData {
    self.contentLabel.text = @"请选择改商品属性";
    self.leftTitleLable.text = @"已选";
    self.hintLabel.text = @"可选增值服务";
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.hintLabel.font = [UIFont wf_pfr12];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.leftTitleLable.mas_right)setOffset:WFMargin];
        make.width.mas_equalTo(self).multipliedBy(0.78);
        make.centerY.mas_equalTo(self.leftTitleLable);
    }];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentLabel);
        [make.top.mas_equalTo(self.contentLabel.mas_bottom)setOffset:8];
    }];
}

#pragma mark - Setter Getter Methods
- (void)setSelectedFeatures:(NSString *)selectedFeatures {
    if (selectedFeatures && ![selectedFeatures isEqualToString:@""]) {
        self.contentLabel.text = selectedFeatures;
    } else {
        self.contentLabel.text = @"请选择改商品属性";
    }
}
@end
