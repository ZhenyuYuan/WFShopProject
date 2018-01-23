//
//  WFShareIncomeItemCell.m
//  ADSRouter
//
//  Created by Andy on 2018/1/20.
//

#import "WFShareIncomeItemCell.h"
#import "WFShareIncomeItem.h"

@interface WFShareIncomeItemCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *myShareLabel;
@end

@implementation WFShareIncomeItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(WFShareIncomeItem *)item {
    _item = item;
    //_timeLabel.text =
    _userLabel.text = item.user;
    _productLabel.text = item.productName;
    _shopLabel.text = item.shopName;
    _totalLabel.text = [NSString stringWithFormat:@"总价: ￥%.2f", _item.amount];
    _myShareLabel.text = [NSString stringWithFormat:@"分成: ￥%.2f", _item.shareAmount];
}

@end
