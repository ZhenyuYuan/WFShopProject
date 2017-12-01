//
//  WFProductSelectedDetailCell.m
//  ADSRouter
//
//  Created by Andy on 2017/11/10.
//

#import "WFProductSelectedDetailCell.h"
#import "Masonry.h"
#import "UIFont+WFFont.h"
#import "WFConsts.h"

@interface WFProductSelectedDetailCell ()

///* 指示按钮 */
//@property (strong , nonatomic)UIButton *indicateButton;
///* 标题 */
//@property (strong , nonatomic)UILabel *leftTitleLable;
///* 图片 */
//@property (strong , nonatomic)UIImageView *iconImageView;
///* 内容 */
//@property (strong , nonatomic)UILabel *contentLabel;
///* 提示 */
//@property (strong , nonatomic)UILabel *hintLabel;


@end

@implementation WFProductSelectedDetailCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpData];
    }
    return self;
}

- (void)setUpData
{
    self.hintLabel.text = @"可选增值服务";
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.hintLabel.font = [UIFont wf_pfr12];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.leftTitleLable.mas_right)setOffset:WFMargin];
        make.width.mas_equalTo(self).multipliedBy(0.78);
        make.centerY.mas_equalTo(self.leftTitleLable);
    }];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentLabel);
        [make.top.mas_equalTo(self.contentLabel.mas_bottom)setOffset:8];
    }];
}

#pragma mark - Setter Getter Methods

@end
