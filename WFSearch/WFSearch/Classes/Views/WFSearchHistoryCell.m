//
//  WFSearchHistoryCell.m
//  ADSRouter
//
//  Created by Andy on 2017/11/22.
//

#import "WFSearchHistoryCell.h"
#import "WFUIComponent.h"
#import "WFHistorySearchItem.h"

@interface WFSearchHistoryCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation WFSearchHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _contentLabel.font = [UIFont wf_pfr15];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)delBtnClicked:(id)sender {
    if (_didClickDelBtn) {
        _didClickDelBtn();
    }
}

- (void)setItem:(WFHistorySearchItem *)item {
    _contentLabel.text = item.query;
}

@end
