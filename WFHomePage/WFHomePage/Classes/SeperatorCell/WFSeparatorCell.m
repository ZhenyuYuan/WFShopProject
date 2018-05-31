//
//  WFSeperatorCell.m
//  ADSRouter
//
//  Created by Andy on 2017/10/16.
//

#import "WFSeparatorCell.h"
#import "WFSeparatorData.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "ADSRouter.h"
#import "WFURLDispatcherProtocol.h"
#import "BeeHive.h"

@implementation WFSeparatorCell {
    UIImageView *_background;
    UILabel *_label;
    WFSeparatorData *_data;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    _background = [UIImageView new];
    _background.contentMode = UIViewContentModeScaleAspectFit;
    _background.userInteractionEnabled = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked)];
    [_background addGestureRecognizer:recognizer];
    [self.contentView addSubview:_background];
    [_background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    _label = [UILabel new];
    [self.contentView addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}

- (void)setUpWithSeparator:(WFSeparatorData *)separatorData {
    _data = separatorData;
    if (![_data.imgUrl isEqualToString:@""]) {
        [_background sd_setImageWithURL:[NSURL URLWithString:_data.imgUrl]];
    }
    _label.text = _data.title;
}

- (void)clicked {
    if (![_data.actionUrl isEqualToString:@""]) {
        id<WFURLDispatcherProtocol> urlDispatcher = [[BeeHive shareInstance] createService:@protocol(WFURLDispatcherProtocol)];
        [urlDispatcher openUrlString:_data.actionUrl];
    }
}


@end
