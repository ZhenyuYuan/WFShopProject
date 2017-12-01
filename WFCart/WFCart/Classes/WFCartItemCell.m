//
//  WFCartItemCell.m
//  ADSRouter
//
//  Created by Andy on 2017/11/22.
//

#import "WFCartItemCell.h"
#import "WFCartItem.h"
#import "UIImageView+WebCache.h"
#import "WFUIComponent.h"
#import "ADSRouter.h"

@interface WFCartItemCell ()

@property (weak, nonatomic) IBOutlet UIButton *radioBtn;
@property (weak, nonatomic) IBOutlet UIImageView *coverImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountField;

@property (nonatomic, assign) BOOL checked;


@end

@implementation WFCartItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [DCSpeedy dc_chageControlCircularWith:_coverImg AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor wf_lightGrayColor] canMasksToBounds:YES];

    _titleLabel.font = [UIFont wf_pfr15];
    _subTitleLabel.font = [UIFont wf_pfr13];
    _subTitleLabel.textColor = [UIColor wf_placeHolderColor];
    _priceLabel.font = [UIFont wf_pfr13];
    _priceLabel.textColor = [UIColor wf_lightRedColor];
    
    _radioBtn.tintColor = [UIColor wf_mainColor];
    
    [self.contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showProduct)]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setCartItem:(WFCartItem *)cartItem {
    if (cartItem && cartItem != _cartItem) {
        _cartItem = cartItem;
        [_coverImg sd_setImageWithURL:[NSURL URLWithString:_cartItem.product.coverImg]];
        _titleLabel.text = _cartItem.product.name;
        _subTitleLabel.text = _cartItem.product.detail;
        _priceLabel.text = [NSString stringWithFormat:@"￥%lf", _cartItem.product.price];
        _amountField.text = @(_cartItem.amount).stringValue;
    }
    [self updateRadioBtn:_cartItem.isSelected];
}

- (IBAction)minus:(id)sender {
    if (_cartItem.amount > 1) {
        --_cartItem.amount;
        if (_didChangeAmount) _didChangeAmount();
    } else {
        if (_didWantToDel) _didWantToDel();
    }
    _amountField.text = @(_cartItem.amount).stringValue;
}

- (IBAction)add:(id)sender {
    ++_cartItem.amount;
    _amountField.text = @(_cartItem.amount).stringValue;
    if (_didChangeAmount) _didChangeAmount();
}

- (IBAction)checkBtnClicked:(id)sender {
    _cartItem.isSelected = !_cartItem.isSelected;
    [self updateRadioBtn:_cartItem.isSelected];
    if (_didCheckOrUncheck) {
        _didCheckOrUncheck(_cartItem.isSelected);
    }
}

- (void)showProduct {
    [[ADSRouter sharedRouter] openUrlString:[NSString stringWithFormat:@"wfshop://product:product_id=%@", _cartItem.product.productId]];
}

- (void)updateRadioBtn:(BOOL)checked {
    if (checked) {
        UIImage *radioImg = [[UIImage imageNamed:@"radio-checked" inBundle:WFGetBundle(@"WFCart") compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_radioBtn setImage:radioImg forState:UIControlStateNormal];
    } else {
        [_radioBtn setImage:[UIImage imageNamed:@"radio" inBundle:WFGetBundle(@"WFCart") compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    }
}
@end
