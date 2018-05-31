//
//  WFShipAddressCell.m
//  ADSRouter
//
//  Created by Andy on 2017/11/15.
//

#import "WFShipAddressCell.h"
#import "WFUIComponent.h"
#import "WFProductShipAddress.h"
@interface WFShipAddressCell ()

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation WFShipAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _userNameLabel.text = @"张三";
    _userNameLabel.font = [UIFont wf_pfr14];
    
    _phoneLabel.text = @"13261626355";
    _phoneLabel.font = [UIFont wf_pfr14];
    
    _addressLabel.text = @"北京市海淀区西土城路十号";
    _addressLabel.font = [UIFont wf_pfr14];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAddress:(WFProductShipAddress *)address {
    _userNameLabel.text = address.receiverName;
    _phoneLabel.text = address.receiverPhone;
    _addressLabel.text = [NSString stringWithFormat:@"%@%@%@", address.province, address.city, address.detail];
}

@end
