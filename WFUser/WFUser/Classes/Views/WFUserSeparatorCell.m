//
//  WFUserSeparatorCell.m
//  ADSRouter
//
//  Created by Andy on 2018/1/19.
//

#import "WFUserSeparatorCell.h"
#import "Masonry.h"
#import "WFUIComponent.h"

@implementation WFUserSeparatorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.89 alpha:1.00];
        UIView *view = [UIView new];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
            make.height.equalTo(@(20));
        }];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
