//
//  WFCartHeaderView.m
//  ADSRouter
//
//  Created by Andy on 2017/11/23.
//

#import "WFCartHeaderView.h"
#import "Masonry.h"
#import "WFUIComponent.h"
#import "ADSRouter.h"

@interface WFCartHeaderView ()

@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

@property (nonatomic, assign) BOOL isChecked;

@end

@implementation WFCartHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpUI];
        _isChecked = NO;
    }
    return self;
}

- (void)setUpUI {
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopClicked)]];
    _shopNameLabel.font = [UIFont wf_pfr12];
    _checkBtn.tintColor = [UIColor wf_mainColor];
    _checkBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (IBAction)checkBtnClicked:(id)sender {
    self.isChecked = !_isChecked;
    if (_didCheckOrUncheck) {
        _didCheckOrUncheck(_isChecked);
    }
}

- (void)shopClicked {
    [[ADSRouter sharedRouter] openUrlString:[NSString stringWithFormat:@"wfsop://shop?shop_id=%@", _cartGroup.shop.shopId]];
}

- (void)setCartGroup:(WFCartItemGroup *)cartGroup {
    _cartGroup = cartGroup;
    _shopNameLabel.text = _cartGroup.shop.name;
    self.isChecked = _cartGroup.isSelected;
}

- (void)setIsChecked:(BOOL)isChecked {
    _isChecked = isChecked;
    if (_isChecked) {
        UIImage *radioImg = [[UIImage imageNamed:@"radio-checked" inBundle:WFGetBundle(@"WFCart") compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_checkBtn setImage:radioImg forState:UIControlStateNormal];
    } else {
        [_checkBtn setImage:[UIImage imageNamed:@"radio" inBundle:WFGetBundle(@"WFCart") compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    }
}

@end
