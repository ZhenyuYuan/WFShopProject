//
//  WFProductCommentCellTableViewCell.m
//  ADSRouter
//
//  Created by Andy on 2017/12/13.
//

#import "WFProductCommentCell.h"
#import "WFUIComponent.h"
#import "UIImageView+WebCache.h"
#import "WFProductComment.h"

@interface WFProductCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

@implementation WFProductCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpUI];
}

- (void)setUpUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _userNameLabel.font = [UIFont wf_pfr13];
    
    _ratingLabel.font = [UIFont wf_pfr11];
    _ratingLabel.textColor = [UIColor wf_darkGrayColor];
    
    _commentLabel.font = [UIFont wf_pfr13];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setProductComment:(WFProductComment *)productComment {
    [_avatarImgView sd_setImageWithURL:[NSURL URLWithString:productComment.buyer.avatarUrl]];
    _userNameLabel.text = productComment.buyer.buyerName;
    _ratingLabel.text = [NSString stringWithFormat:@"评分:%.1f", productComment.rating];
    _commentLabel.text = productComment.comment;
}

@end
