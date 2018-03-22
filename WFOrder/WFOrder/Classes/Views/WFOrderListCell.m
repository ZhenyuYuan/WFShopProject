//
//  WFOrderListCell.m
//  ADSRouter
//
//  Created by Andy on 2017/12/19.
//

#import "WFOrderListCell.h"
#import "WFOrderProduct.h"
#import "UIImageView+WebCache.h"
#import "WFUIComponent.h"

@interface WFOrderListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;

@end

@implementation WFOrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpUI];
}

- (void)setUpUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _nameLabel.font = [UIFont wf_pfr14];
    _numberLabel.font = [UIFont wf_pfr13];
    _numberLabel.textColor = [UIColor wf_placeHolderColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProduct:(WFOrderProduct *)product {
    _product = product;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_product.coverImg]];
    _nameLabel.text = _product.name;
    _numberLabel.text = [NSString stringWithFormat:@"%ld件", _product.amount];
    _costLabel.text = [NSString stringWithFormat:@"￥%.2f", _product.price];
}

@end
