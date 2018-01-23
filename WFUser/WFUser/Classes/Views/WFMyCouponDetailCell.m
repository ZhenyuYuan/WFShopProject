//
//  WFMyCouponDetailCell.m
//  ADSRouter
//
//  Created by Andy on 2018/1/19.
//

#import "WFMyCouponDetailCell.h"
#import "WFUIComponent.h"

@interface WFMyCouponDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *couponLabel;
@property (weak, nonatomic) IBOutlet UILabel *unUsedLabel;
@property (weak, nonatomic) IBOutlet UILabel *usedLabel;
@property (weak, nonatomic) IBOutlet UILabel *expiredLabel;

@end

@implementation WFMyCouponDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _couponLabel.font = [UIFont wf_pfr13];
    _unUsedLabel.font = [UIFont wf_pfr13];
    _usedLabel.font = [UIFont wf_pfr13];
    _expiredLabel.font = [UIFont wf_pfr13];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
