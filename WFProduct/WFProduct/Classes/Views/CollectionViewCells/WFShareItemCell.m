//
//  WFShareItemCell.m
//  ADSRouter
//
//  Created by Andy on 2017/11/20.
//

#import "WFShareItemCell.h"
#import "WFUIComponent.h"
#import "Masonry.h"
#import "WFConsts.h"
#import "WFProductShareItem.h"

@interface WFShareItemCell ()

/* 图片 */
@property (strong , nonatomic)UIImageView *shareImageView;
/* 品台 */
@property (strong , nonatomic)UILabel *shareLabel;

@end

@implementation WFShareItemCell

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
    self.backgroundColor = [UIColor whiteColor];
    
    _shareImageView = [UIImageView new];
    [self addSubview:_shareImageView];
    
    _shareLabel = [UILabel new];
    _shareLabel.textAlignment = NSTextAlignmentCenter;
    _shareLabel.textColor = [UIColor darkGrayColor];
    _shareLabel.font = [UIFont wf_pfr13];
    [self addSubview:_shareLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_shareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:WFMargin];
        make.size.mas_equalTo(CGSizeMake(43 , 43));
    }];
    [_shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_shareImageView.mas_bottom)setOffset:WFMargin];
        make.centerX.mas_equalTo(self);
    }];
    
}

- (void)setShareItem:(WFProductShareItem *)shareItem {
    shareItem = shareItem;
    self.shareLabel.text = shareItem.title;
    self.shareImageView.image = [UIImage imageNamed:shareItem.icon inBundle:WFGetBundle(@"WFProduct") compatibleWithTraitCollection:nil];
}

#pragma mark - Setter Getter Methods


@end
