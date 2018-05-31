//
//  WFProductTitleCell.m
//  ADSRouter
//
//  Created by Andy on 2017/11/9.
//

#import "WFProductTitleCell.h"
#import "WFProduct.h"
#import "WFUIComponent.h"
#import "WFConsts.h"
#import "Masonry.h"


@interface WFProductTitleCell ()

/* 自营 */
@property (nonatomic, strong) UIImageView *autotrophyImageView;

/* 分享按钮 */
//@property (strong , nonatomic) DCUpDownButton *shareButton;

/* 商品标题 */
@property (strong , nonatomic) UILabel *titleLabel;
/* 商品价格 */
@property (strong , nonatomic) UILabel *priceLabel;
/* 商品小标题 */
@property (strong , nonatomic) UILabel *subtitleLabel;

/* 优惠按钮 */
//@property (strong , nonatomic) UIButton *preferentialButton;

/** 分享按钮点击回调 */
//@property (nonatomic, copy) dispatch_block_t shareButtonClickBlock;

@end

@implementation WFProductTitleCell

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

    
//    _autotrophyImageView = [[UIImageView alloc] init];
//    [self addSubview:_autotrophyImageView];
//    _autotrophyImageView.image = [UIImage imageNamed:@"detail_title_ziying_tag"];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont wf_pfr16];
    _titleLabel.text = @"小米 （MI）红米4A 2GB+16GB 全网通双卡双带手机";
    _titleLabel.numberOfLines = 0;
    [self addSubview:_titleLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont wf_pfr18];
    _priceLabel.text = @"￥ 1500";
    _priceLabel.textColor = [UIColor redColor];
    [self addSubview:_priceLabel];
    
    _subtitleLabel = [[UILabel alloc] init];
    _subtitleLabel.font = [UIFont wf_pfr12];
    _subtitleLabel.textColor = [UIColor wf_lightRedColor];
    _subtitleLabel.text = @"“人像摄影大师”新一代徕卡双镜头 一体化前置指纹 5.1英寸显示屏 麒麟960芯片";
    _subtitleLabel.numberOfLines = 0;
    //_subtitleLabel.textColor = RGB(233, 35, 46);
    [self addSubview:_subtitleLabel];
    
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
//    _shareButton = [DCUpDownButton buttonWithType:UIButtonTypeCustom];
//    [_shareButton setTitle:@"分享" forState:0];
//    [_shareButton setImage:[UIImage imageNamed:@"icon_fenxiang2"] forState:0];
//    [_shareButton setTitleColor:[UIColor blackColor] forState:0];
//    _shareButton.titleLabel.font = PFR10Font;
//    [self addSubview:_shareButton];
//    [_shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
//
//    [DCSpeedy dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.15]];
    
    
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    [_autotrophyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        [make.left.mas_equalTo(self)setOffset:DCMargin];
//        [make.top.mas_equalTo(self)setOffset:DCMargin];
//    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(WFMargin);
        make.top.mas_equalTo(self).offset(-3);
        make.right.mas_equalTo(self).offset(-WFMargin);
    }];


    [_subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel);
        make.right.mas_equalTo(self).offset(-WFMargin);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(WFMargin);
    }];

    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel);
        make.top.mas_equalTo(_subtitleLabel.mas_bottom).offset(WFMargin);
        make.bottom.mas_equalTo(self).offset(-WFMargin);
    }];
    
//    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        [make.right.mas_equalTo(self)setOffset:-DCMargin];
//        [make.top.mas_equalTo(self)setOffset:DCMargin];
//    }];
//
//    [DCSpeedy dc_setUpLongLineWith:_goodTitleLabel WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.15] WithHightRatio:0.6];
}


#pragma mark - 分享按钮点击
- (void)shareButtonClick
{
   // !_shareButtonClickBlock ? : _shareButtonClickBlock();
}

#pragma mark - Setter Getter Methods

- (void)setProduct:(WFProduct *)product {
    _product = product;
    _titleLabel.text = _product.name;
    _priceLabel.text = [NSString stringWithFormat:@"￥ %.2f", _product.price];
    _subtitleLabel.text = _product.subTitle;
}
@end

