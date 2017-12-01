//
//  WFUserNormalFunctionCell.m
//  ADSRouter
//
//  Created by Andy on 2017/11/18.
//

#import "WFUserNormalFunctionCell.h"
#import "WFUIComponent.h"
#import "WFUserNormalFunction.h"

@interface WFUserNormalFunctionCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation WFUserNormalFunctionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _titleLabel.font = [UIFont wf_pfr16];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setFunction:(WFUserNormalFunction *)function {
    _titleLabel.text = function.title;
    [_iconImg setImage:[UIImage imageNamed:function.icon inBundle:WFGetBundle(@"WFUser") compatibleWithTraitCollection:nil]];
}

@end
