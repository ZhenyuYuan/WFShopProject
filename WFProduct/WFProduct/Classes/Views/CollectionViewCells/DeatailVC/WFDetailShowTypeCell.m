//
//  DCDetailShowTypeCell.m
//  CDDMall
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "WFDetailShowTypeCell.h"
#import "Masonry.h"
#import "WFConsts.h"
#import "UIFont+WFFont.h"
// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface WFDetailShowTypeCell ()

@end

@implementation WFDetailShowTypeCell

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
    
    _leftTitleLable = [[UILabel alloc] init];
    _leftTitleLable.font = [UIFont wf_pfr14];
    _leftTitleLable.textColor = [UIColor lightGrayColor];
    [self addSubview:_leftTitleLable];
    
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont wf_pfr14];
    [self addSubview:_contentLabel];
    
    _hintLabel = [[UILabel alloc] init];
    _hintLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_hintLabel];
    
    _indicateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_indicateButton setImage:[UIImage imageNamed:@"right" inBundle:[self _bundle] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    _isHasindicateButton = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_leftTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:WFMargin];
        [make.top.mas_equalTo(self)setOffset:WFMargin];
    }];
    if (_isHasindicateButton) {
        [self addSubview:_indicateButton];
        [_indicateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            [make.right.mas_equalTo(self)setOffset:-WFMargin];
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.centerY.mas_equalTo(self);
        }];
    }
}

- (NSBundle*)_bundle {
    return [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"WFProduct" ofType:@"bundle"]];
}

- (NSString*)_pathForFile:(NSString*)fileName extension:(NSString*)extension {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"WFProduct" ofType:@"bundle"];
    NSString *path = [[NSBundle bundleWithPath:bundlePath]  pathForResource:fileName ofType:extension];
    return path;
}

#pragma mark - Setter Getter Methods


@end
