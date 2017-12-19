//
//  WFUserOrderCell.m
//  ADSRouter
//
//  Created by Andy on 2017/11/21.
//

#import "WFOrderCell.h"
#import "WFUIComponent.h"


@implementation WFOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpUI];
}

- (void)setUpUI {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrder:(WFOrder *)order {
    
}

@end
