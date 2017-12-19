//
//  WFOrderItemCell.m
//  ADSRouter
//
//  Created by Andy on 2017/12/15.
//

#import "WFOrderItemCell.h"
#import "UIImageView+WebCache.h"
#import "WFOrderProduct.h"
@interface WFOrderItemCell ()

@property (weak, nonatomic) IBOutlet UIImageView *productImgView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *productDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *productAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *productPriceLabel;

@end

@implementation WFOrderItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProduct:(WFOrderProduct *)product {
    _product = product;
    [_productImgView sd_setImageWithURL:[NSURL URLWithString:_product.coverImg]];
    _productNameLabel.text = _product.name;
    _productDetailLabel.text = _product.subTitle;
    _productAmountLabel.text = @(_product.amount).stringValue;
    _productPriceLabel.text = [NSString stringWithFormat:@"￥%.2f", _product.price];
}

@end
