//
//  DCGoodsSortCell.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "WFThirdLevelCategoryCell.h"

// Controllers

// Models
#import "WFCategoryItem.h"
// Views

// Vendors

// Categories
#import "UIColor+WFColor.h"
#import "UIFont+WFFont.h"
// Others
#import <UIImageView+WebCache.h>
#import "Masonry.h"

@interface WFThirdLevelCategoryCell ()

/* imageView */
@property (strong , nonatomic) UIImageView *imageView;
/* label */
@property (strong , nonatomic) UILabel *categoryNameLabel;

@end

@implementation WFThirdLevelCategoryCell

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
    //self.backgroundColor = [UIColor wf_mainBackgroundColor];
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageView];
    
    _categoryNameLabel = [UILabel new];
    _categoryNameLabel.font = [UIFont wf_pfr13];
    _categoryNameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_categoryNameLabel];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        [make.top.mas_equalTo(self.contentView) setOffset:5];
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.contentView.bounds) * 0.85, CGRectGetWidth(self.contentView.bounds) * 0.85));
    }];
    
    [_categoryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_imageView.mas_bottom)setOffset:5];
        make.width.mas_equalTo(_imageView);
        make.centerX.mas_equalTo(self.contentView);
    }];
}

#pragma mark - Setter Getter Methods
- (void)setCategoryItem:(WFCategoryItem *)categoryItem {
    _categoryItem = categoryItem;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_categoryItem.imgUrl]];
    _categoryNameLabel.text = _categoryItem.name;
}

@end
