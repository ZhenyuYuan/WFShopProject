//
//  WFCouponCell.m
//  ADSRouter
//
//  Created by Andy on 2018/1/23.
//

#import "WFCouponCell.h"
#import "WFUIComponent.h"
#import "UIImageView+WebCache.h"
#import "WFCoupon.h"

@interface WFCouponCell ()

@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hintIcon;

@end

@implementation WFCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [DCSpeedy dc_chageControlCircularWith:_view AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor groupTableViewBackgroundColor] canMasksToBounds:YES];
    _shopNameLabel.font = [UIFont wf_pfr14];
    _couponNameLabel.font = [UIFont wf_pfr14];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCoupon:(WFCoupon *)coupon {
    _coupon = coupon;
    [_iconImg sd_setImageWithURL:[NSURL URLWithString:_coupon.icon]];
    _shopNameLabel.text = _coupon.shopName;
    _couponNameLabel.text = _coupon.name;
    switch (_coupon.state) {
        case WFCouponTypeExpired:
            [_hintIcon setImage:[UIImage imageNamed:@"coupon-expired" inBundle:WFGetBundle(@"WFOrder") compatibleWithTraitCollection:nil]];
            break;
        case WFCouponTypeUsed:
            [_hintIcon setImage:[UIImage imageNamed:@"coupon-used" inBundle:WFGetBundle(@"WFOrder") compatibleWithTraitCollection:nil]];
            break;
        default:
            _hintIcon.hidden = YES;
            break;
    }
}

@end
