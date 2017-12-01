//
//  WFUserOrderDetailCell.m
//  ADSRouter
//
//  Created by Andy on 2017/11/18.
//

#import "WFUserOrderDetailCell.h"
#import "WFUIComponent.h"

@interface WFUserOrderDetailCell ()
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UILabel *checkLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIButton *repairBtn;
@property (weak, nonatomic) IBOutlet UILabel *repairLabel;


@end

@implementation WFUserOrderDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _payBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    _checkBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    _commentBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    _repairBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _payLabel.font = [UIFont wf_pfr13];
    _checkLabel.font = [UIFont wf_pfr13];
    _commentLabel.font = [UIFont wf_pfr13];
    _repairLabel.font = [UIFont wf_pfr13];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)payBtnClicked:(id)sender {
    if (_showUnpayOrders) {
        _showUnpayOrders();
    }
}

- (IBAction)checkBtnClicked:(id)sender {
    if (_showUncheckOrders) {
        _showUncheckOrders();
    }
}

- (IBAction)commentBtnClicked:(id)sender {
    if (_showUncommentOrders) {
        _showUncommentOrders();
    }
}

- (IBAction)repairBtnClicked:(id)sender {
    if (_showRepairOrders) {
        _showRepairOrders();
    }
}

@end
