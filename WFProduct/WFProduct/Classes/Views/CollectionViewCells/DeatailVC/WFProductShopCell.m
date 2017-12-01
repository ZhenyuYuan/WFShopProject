//
//  WFProductShopCell.m
//  WFProduct
//
//  Created by Andy on 2017/11/10.
//

#import "WFProductShopCell.h"
#import "WFUIComponent.h"
#import "UIImageView+WebCache.h"
#import "WFProductModels.h"

@interface WFProductShopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shopCoverImgView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *goInShopBtn;
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;

@end

@implementation WFProductShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _shopNameLabel.font = [UIFont wf_pfr15];
    _subtitleLabel.font = [UIFont wf_pfr13];
    _subtitleLabel.textColor = [UIColor wf_placeHolderColor];
    
    [DCSpeedy dc_chageControlCircularWith:_goInShopBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor wf_borderGrayColor] canMasksToBounds:YES];
    [_goInShopBtn setImage:[UIImage imageNamed:@"shop" inBundle:WFGetBundle(@"WFProduct") compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [_goInShopBtn addTarget:self action:@selector(goInBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [DCSpeedy dc_chageControlCircularWith:_contactBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor wf_borderGrayColor] canMasksToBounds:YES];
    [_contactBtn setImage:[UIImage imageNamed:@"service" inBundle:WFGetBundle(@"WFProduct") compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [_contactBtn addTarget:self action:@selector(contactBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setShop:(WFProductShop *)shop {
    _shopNameLabel.text = shop.name;
    _subtitleLabel.text = shop.subTitle;
    [_shopCoverImgView sd_setImageWithURL:[NSURL URLWithString:shop.coverImg]];
}

- (void)goInBtnClicked {
    if (_didClickGoInBtn) {
        _didClickGoInBtn();
    }
}

- (void)contactBtnClicked {
    if (_didClickContactBtn) {
        _didClickContactBtn();
    }
}


@end
