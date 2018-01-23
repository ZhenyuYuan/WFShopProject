//
//  WFOrderSelectCouponCell.m
//  ADSRouter
//
//  Created by Andy on 2018/1/23.
//

#import "WFOrderSelectCouponCell.h"
#import "WFUIComponent.h"
#import "WFCoupon.h"

@interface WFOrderSelectCouponCell()

@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation WFOrderSelectCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpUI];
}

- (void)setUpUI {
    _hintLabel.font = [UIFont wf_pfr16];
    _detailLabel.font = [UIFont wf_pfr14];
    _detailLabel.textColor = [UIColor wf_mainColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCoupon:(WFCoupon *)coupon {
    _coupon = coupon;
    if (_coupon) {
        _detailLabel.text = _coupon.name;
    }
}

@end
