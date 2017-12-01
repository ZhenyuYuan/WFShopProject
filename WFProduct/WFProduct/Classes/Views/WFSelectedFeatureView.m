//
//  DCFeatureChoseTopCell.m
//  CDDStoreDemo
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "WFSelectedFeatureView.h"

// Controllers

// Models

// Views

// Vendors
#import "Masonry.h"
#import "UIImageView+WebCache.h"
// Categories
#import "UIFont+WFFont.h"
#import "UIColor+WFColor.h"

// Others
#import "WFConsts.h"

@interface WFSelectedFeatureView ()

/* 取消 */
@property (strong , nonatomic) UIButton *closeButton;
/* 商品价格 */
@property (strong , nonatomic) UILabel *goodPriceLabel;
/* 图片 */
@property (strong , nonatomic) UIImageView *goodImageView;
/* 选择属性 */
@property (strong , nonatomic) UILabel *chooseAttLabel;

@end

@implementation WFSelectedFeatureView

#pragma mark - Intial

- (instancetype)initWithFrame:(CGRect)frame {
    self= [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setImage:[UIImage imageNamed:@"close" inBundle:[self _bundle] compatibleWithTraitCollection:nil] forState:0];
    [_closeButton addTarget:self action:@selector(crossButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_closeButton];
    
    _goodImageView = [UIImageView new];
    [self addSubview:_goodImageView];
    [_goodImageView sd_setImageWithURL:[NSURL URLWithString:@"https://ws4.sinaimg.cn/large/006tKfTcly1fkk2vq6y8fj30le0aomzj.jpg"]];
    
    _goodPriceLabel = [UILabel new];
    _goodPriceLabel.font = [UIFont wf_pfr18];
    _goodPriceLabel.textColor = [UIColor redColor];
    [_goodPriceLabel setText:@"￥ 12"];
    [self addSubview:_goodPriceLabel];
    
    _chooseAttLabel = [UILabel new];
    _chooseAttLabel.numberOfLines = 2;
    _chooseAttLabel.font = [UIFont wf_pfr14];
    [self addSubview:_chooseAttLabel];
    [_chooseAttLabel setText:@"已选属性"];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-WFMargin];
        [make.top.mas_equalTo(self)setOffset:WFMargin];
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    [_goodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:WFMargin];
        [make.top.mas_equalTo(self)setOffset:WFMargin];
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [_goodPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_goodImageView.mas_right)setOffset:WFMargin];
        [make.top.mas_equalTo(_goodImageView)setOffset:WFMargin];
    }];
    
    [_chooseAttLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodPriceLabel);
        make.right.mas_equalTo(_closeButton.mas_left);
        [make.top.mas_equalTo(_goodPriceLabel.mas_bottom)setOffset:5];
    }];
    
}

- (NSBundle*)_bundle {
    return [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"WFProduct" ofType:@"bundle"]];
}

- (NSString*)_pathForFile:(NSString*)fileName extension:(NSString*)extension {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"WFProduct" ofType:@"bundle"];
    NSString *path = [[NSBundle bundleWithPath:bundlePath]  pathForResource:fileName ofType:extension];
    return path;
}

- (void)crossButtonClick {
    if (_closeHandler) {
        _closeHandler();
    }
}


@end
