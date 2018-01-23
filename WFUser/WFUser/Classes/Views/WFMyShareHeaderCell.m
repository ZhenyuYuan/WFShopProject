//
//  WFMyShareHeaderCell.m
//  ADSRouter
//
//  Created by Andy on 2018/1/19.
//

#import "WFMyShareHeaderCell.h"
#import "WFUIComponent.h"

@interface WFMyShareHeaderCell ()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@end

@implementation WFMyShareHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _leftLabel.font = [UIFont wf_pfr16];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
