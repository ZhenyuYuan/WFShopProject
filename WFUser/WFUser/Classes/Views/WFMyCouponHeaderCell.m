//
//  WFMyCouponHeaderCell.m
//  ADSRouter
//
//  Created by Andy on 2018/1/19.
//

#import "WFMyCouponHeaderCell.h"
#import "WFUIComponent.h"

@interface WFMyCouponHeaderCell ()

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation WFMyCouponHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _leftLabel.font = [UIFont wf_pfr16];
    
    _rightLabel.font = [UIFont wf_pfr13];
    _rightLabel.textColor = [UIColor wf_placeHolderColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
