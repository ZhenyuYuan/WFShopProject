//
//  WFUserOrderCell.m
//  ADSRouter
//
//  Created by Andy on 2017/11/18.
//

#import "WFUserOrderCell.h"
#import "WFUIComponent.h"

@interface WFUserOrderCell ()

@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTitleLabel;

@end

@implementation WFUserOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _leftTitleLabel.font = [UIFont wf_pfr16];
    
    _rightTitleLabel.font = [UIFont wf_pfr13];
    _rightTitleLabel.textColor = [UIColor wf_placeHolderColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
