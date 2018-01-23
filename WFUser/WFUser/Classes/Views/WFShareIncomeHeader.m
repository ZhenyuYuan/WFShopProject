//
//  WFShareIncomeHeader.m
//  ADSRouter
//
//  Created by Andy on 2018/1/20.
//

#import "WFShareIncomeHeader.h"

@interface WFShareIncomeHeader ()

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation WFShareIncomeHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLeftText:(NSString *)leftText {
    _leftText = leftText;
    [_leftLabel setText:_leftText];
}

- (void)setDetailText:(NSString *)detailText {
    _detailText = detailText;
    [_detailLabel setText:_detailText];
}


@end
