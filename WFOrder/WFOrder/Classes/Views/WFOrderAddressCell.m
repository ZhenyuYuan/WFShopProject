//
//  WFOrderAddressCell.m
//  ADSRouter
//
//  Created by Andy on 2017/12/15.
//

#import "WFOrderAddressCell.h"
#import "WFUIComponent.h"
#import "WFOrderShipAddress.h"

@interface WFOrderAddressCell ()

@property (weak, nonatomic) IBOutlet UILabel *receiverNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation WFOrderAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setUpUI];
}

- (void)setUpUI {
    _receiverNameLabel.font = [UIFont wf_pfr16];
    _phoneLabel.font = [UIFont wf_pfr16];
    _addressLabel.font = [UIFont wf_pfr14];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setAddress:(WFOrderShipAddress *)address {
    _address = address;
    _receiverNameLabel.text = address.receiverName;
    _phoneLabel.text = address.receiverPhone;
    _addressLabel.text = address.address;
}

@end
