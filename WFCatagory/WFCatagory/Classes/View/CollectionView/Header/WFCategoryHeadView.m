//
//  DCBrandsSortHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "WFCategoryHeadView.h"

// Controllers

// Models
#import "WFCategoryItem.h"
// Views

// Vendors

// Categories
#import "UIFont+WFFont.h"
// Others
#import "Masonry.h"

@interface WFCategoryHeadView ()

/* 头部标题Label */
@property (strong , nonatomic)UILabel *headLabel;

@end

@implementation WFCategoryHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI {
    _headLabel = [[UILabel alloc] init];
    _headLabel.textColor = [UIColor darkGrayColor];
    _headLabel.font = [UIFont wf_pfr13];
    [self addSubview:_headLabel];
    [_headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark - Setter Getter Methods
- (void)setCategoryItem:(WFCategoryItem *)categoryItem {
    _categoryItem = categoryItem;
    _headLabel.text = categoryItem.name;
}

@end
