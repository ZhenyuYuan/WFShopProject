//
//  WFOrderSelectDeliverTypeCell.m
//  ADSRouter
//
//  Created by Andy on 2018/1/23.
//

#import "WFOrderSelectDeliverTypeCell.h"
#import "WFUIComponent.h"

@interface WFOrderSelectDeliverTypeCell()

@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation WFOrderSelectDeliverTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpUI];
}

- (void)setUpUI {
    _hintLabel.font = [UIFont wf_pfr16];
    _detailLabel.font = [UIFont wf_pfr14];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
