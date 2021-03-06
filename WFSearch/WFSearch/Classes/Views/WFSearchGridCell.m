//
//  DCSwitchGridCell.m
//  CDDMall
//
//  Created by apple on 2017/6/14.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "WFSearchGridCell.h"

// Controllers

// Models
#import "WFSearchItem.h"
// Views

// Vendors
#import <UIImageView+WebCache.h>
#import "DCSpeedy.h"
// Categories
#import "UIFont+WFFont.h"
#import "UIView+WFExtension.h"
// Others
#import "Masonry.h"
#import "WFConsts.h"

@interface WFSearchGridCell ()

/* 优惠套装 */
@property (strong , nonatomic)UIImageView *freeSuitImageView;
/* 商品图片 */
@property (strong , nonatomic)UIImageView *gridImageView;
/* 商品标题 */
@property (strong , nonatomic)UILabel *gridLabel;
/* 自营 */
@property (strong , nonatomic)UIImageView *autotrophyImageView;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;
/* 评价数量 */
@property (strong , nonatomic)UILabel *commentNumLabel;

@end

@implementation WFSearchGridCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    _freeSuitImageView = [[UIImageView alloc] init];
    _freeSuitImageView.image = [UIImage imageNamed:@"taozhuang_tag"];
    [self addSubview:_freeSuitImageView];
    
    _autotrophyImageView = [[UIImageView alloc] init];
    [self addSubview:_autotrophyImageView];
    _autotrophyImageView.image = [UIImage imageNamed:@"detail_title_ziying_tag"];
    
    _gridImageView = [[UIImageView alloc] init];
    _gridImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_gridImageView];
    
    _gridLabel = [[UILabel alloc] init];
    _gridLabel.font = [UIFont wf_pfr14];
    _gridLabel.numberOfLines = 1;
    [self addSubview:_gridLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont wf_pfr15];
    _priceLabel.textColor = [UIColor redColor];
    [self addSubview:_priceLabel];
    
    _commentNumLabel = [[UILabel alloc] init];
    NSInteger pNum = arc4random() % 10000;
    _commentNumLabel.text = [NSString stringWithFormat:@"%zd人已评价",pNum];
    _commentNumLabel.font = [UIFont wf_pfr10];
    _commentNumLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_commentNumLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:WFMargin];
        make.size.mas_equalTo(CGSizeMake(self.wf_width * 0.8, self.wf_width * 0.8));
    }];
    
    [_autotrophyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:WFMargin];
        [make.top.mas_equalTo(_gridImageView.mas_bottom)setOffset:WFMargin];
    }];
    
    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.centerY.mas_equalTo(_autotrophyImageView);
        [make.right.mas_equalTo(self)setOffset:-WFMargin];
    }];
    
    [_freeSuitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_autotrophyImageView);
        [make.top.mas_equalTo(_gridLabel.mas_bottom)setOffset:2];
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_autotrophyImageView);
        [make.top.mas_equalTo(_freeSuitImageView.mas_bottom)setOffset:2];
    }];
    
    [_commentNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_autotrophyImageView);
        [make.top.mas_equalTo(_priceLabel.mas_bottom)setOffset:2];
    }];

    
}

#pragma mark - Setter Getter Methods
- (void)setSearchItem:(WFSearchItem *)searchItem {
    _searchItem = searchItem;
    [_gridImageView sd_setImageWithURL:[NSURL URLWithString:searchItem.imgUrl]];
    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f", searchItem.price];
    _gridLabel.text = searchItem.name;
    _commentNumLabel.text = @(_searchItem.commentCount).stringValue;
    [DCSpeedy dc_setUpLabel:_gridLabel Content:searchItem.name IndentationFortheFirstLineWith:_gridLabel.font.pointSize * 3.5];
}


@end
