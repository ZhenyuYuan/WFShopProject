//
//  WFUserOrderCell.m
//  ADSRouter
//
//  Created by Andy on 2017/11/21.
//

#import "WFOrderCell.h"
#import "WFUIComponent.h"

const CGFloat kHeaderViewHeight = 50.f;
const CGFloat kContentViewHeight = 50.f;
const CGFloat kFooterViewHeight = 50.f;

@implementation WFOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpUI];
}

- (void)setUpUI {
    
}

//- (UIView*)setUpHeaderView {
//    
//}
//
//- (UIView*)setUpContentView {
//    
//}
//
//- (UIView*)setUpFooterView {
//    
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrder:(WFOrder *)order {
    
}

@end
