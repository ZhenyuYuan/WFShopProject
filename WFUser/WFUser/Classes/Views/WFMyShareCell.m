//
//  WFMyShareCell.m
//  ADSRouter
//
//  Created by Andy on 2018/1/19.
//

#import "WFMyShareCell.h"
#import "WFHelpers.h"
#import "WFUIComponent.h"

@interface WFMyShareCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation WFMyShareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _titleLabel.font = [UIFont wf_pfr16];
    _detailLabel.font = [UIFont wf_pfr16];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setType:(WFShareCellType)type {
    _type = type;
    switch (_type) {
        case WFShareCellTypeDaily:
            [_iconImg setImage:[UIImage imageNamed:@"daily" inBundle:WFGetBundle(@"WFUser") compatibleWithTraitCollection:nil]];
            [_titleLabel setText:@"日分成"];
            break;
        case WFShareCellTypeTotal:
            [_iconImg setImage:[UIImage imageNamed:@"total" inBundle:WFGetBundle(@"WFUser") compatibleWithTraitCollection:nil]];
            [_titleLabel setText:@"总分成"];
            break;
        case WFShareCellTypeUnshare:
            [_iconImg setImage:[UIImage imageNamed:@"unshare" inBundle:WFGetBundle(@"WFUser") compatibleWithTraitCollection:nil]];
            [_titleLabel setText:@"待分成"];
            break;
        default:
            break;
    }
}

- (void)setDetail:(NSString *)detail {
    _detail = detail;
    switch (_type) {
        case WFShareCellTypeDaily:case WFShareCellTypeTotal:
            [_detailLabel setText:[NSString stringWithFormat:@"￥%@", _detail]];
            break;
        case WFShareCellTypeUnshare:
            [_detailLabel setText:[NSString stringWithFormat:@"%@单", _detail]];
            break;
        default:
            break;
    }
}

@end
