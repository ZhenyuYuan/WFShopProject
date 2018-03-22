//
//  WFProductIntroCell.m
//  ADSRouter
//
//  Created by Andy on 2017/12/12.
//

#import "WFProductIntroCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

@interface WFProductIntroCell()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) MASConstraint *ratio;

@end

@implementation WFProductIntroCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imgView = [UIImageView new];
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
            //_ratio = make.height.equalTo(self.contentView.mas_width).multipliedBy(1);
        }];
    }
    return self;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.contentView);
//    }];
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        _ratio = make.height.equalTo(self.contentView.mas_width).multipliedBy(1);
//    }];
//}

- (void)setIntroImg:(WFProductIntroImg *)introImg {
    [_imgView sd_setImageWithURL:[NSURL URLWithString:introImg.url]];
//    [_ratio uninstall];
//    _ratio.multipliedBy(introImg.ratio);
//    [_ratio install];
}

@end
