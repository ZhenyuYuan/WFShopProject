//
//  DCClassCategoryCell.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "WFCategoryItem.h"

#import "Masonry.h"
// Controllers

// Models
#import "WFCategoryCell.h"
// Views

// Vendors

// Categories
#import "UIFont+WFFont.h"
#import "UIColor+WFColor.h"
// Others

@interface WFCategoryCell ()

/* 标题 */
@property (strong , nonatomic)UILabel *titleLabel;
/* 指示View */
@property (strong , nonatomic)UIView *indicatorView;

@end

@implementation WFCategoryCell

#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpUI];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont wf_pfr15];
    [self addSubview:_titleLabel];
    
    _indicatorView = [[UIView alloc] init];
    _indicatorView.hidden = NO;
    _indicatorView.backgroundColor = [UIColor wf_mainColor];
    [self addSubview:_indicatorView];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
    
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(self);
        make.width.mas_equalTo(5);
    }];
}

#pragma mark - cell点击
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        _indicatorView.hidden = NO;
        _titleLabel.textColor = [UIColor wf_mainColor];
        self.backgroundColor = [UIColor whiteColor];
    }else{
        _indicatorView.hidden = YES;
        _titleLabel.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - Setter Getter Methods
- (void)setCategoryItem:(WFCategoryItem *)categoryItem
{
    _categoryItem = categoryItem;
    self.titleLabel.text = categoryItem.name;
}

@end
