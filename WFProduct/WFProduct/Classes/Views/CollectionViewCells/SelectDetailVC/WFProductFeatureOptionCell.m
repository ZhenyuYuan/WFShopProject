//
//  WFProductDetailFeatureCell.m
//  ADSRouter
//
//  Created by Andy on 2017/11/13.
//

#import "WFProductFeatureOptionCell.h"
#import "Masonry.h"
#import "WFConsts.h"
#import "DCSpeedy.h"
#import "UIFont+WFFont.h"
#import "UIColor+WFColor.h"
#import "WFProductFeatureOption.h"

@interface WFProductFeatureOptionCell ()

/* 属性 */
@property (strong , nonatomic)UILabel *attLabel;

@end

@implementation WFProductFeatureOptionCell


#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI
{
    _attLabel = [[UILabel alloc] init];
    _attLabel.textAlignment = NSTextAlignmentCenter;
    _attLabel.font = [UIFont wf_pfr14];
    [self addSubview:_attLabel];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_attLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self).offset(WFMargin);
        make.right.bottom.mas_equalTo(self).offset(-WFMargin);
    }];
}


#pragma mark - Setter Getter Methods

- (void)setOption:(WFProductFeatureOption *)option {
    _option = option;
    _attLabel.text = option.name;
    
    if (option.isSelected) {
        _attLabel.textColor = [UIColor wf_mainColor];
        [DCSpeedy dc_chageControlCircularWith:self AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor wf_mainColor] canMasksToBounds:YES];
    }else{
        _attLabel.textColor = [UIColor blackColor];
        [DCSpeedy dc_chageControlCircularWith:self AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4] canMasksToBounds:YES];
    }
}

@end
