//
//  WFSelectOrderAddressCell.m
//  ADSRouter
//
//  Created by Andy on 2017/12/18.
//

#import "WFSelectOrderAddressCell.h"
#import "WFHelpers.h"
#import "WFUIComponent.h"
#import "WFOrderShipAddress.h"
@interface WFSelectOrderAddressCell ()
@property (weak, nonatomic) IBOutlet UIImageView *ratioBtn;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation WFSelectOrderAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpUI];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setUpUI {
    _ratioBtn.tintColor = [UIColor wf_mainColor];
    _addressLabel.font = [UIFont wf_pfr14];
    _nameLabel.font = [UIFont wf_pfr14];
    _phoneLabel.font = [UIFont wf_pfr14];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        UIImage *radioImg = [[UIImage imageNamed:@"radio-checked" inBundle:WFGetBundle(@"WFOrder") compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_ratioBtn setImage:radioImg];
    } else {
        [_ratioBtn setImage:[UIImage imageNamed:@"radio" inBundle:WFGetBundle(@"WFOrder") compatibleWithTraitCollection:nil]];
    }
    
}

- (void)setAddress:(WFOrderShipAddress *)address {
    _address = address;
    _addressLabel.text = address.address;
    _nameLabel.text = address.receiverName;
    _phoneLabel.text = address.receiverPhone;
}

@end
