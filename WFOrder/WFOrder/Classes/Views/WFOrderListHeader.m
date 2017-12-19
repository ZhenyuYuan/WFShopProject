//
//  WFOrderListHeader.m
//  ADSRouter
//
//  Created by Andy on 2017/12/19.
//

#import "WFOrderListHeader.h"
#import "WFUIComponent.h"
#import "WFOrder.h"
#import "ADSRouter.h"

@interface WFOrderListHeader ()

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *orderIdLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderId;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *amount;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btn;

@end

@implementation WFOrderListHeader

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpUI];
}

- (void)setUpUI {
    _orderIdLabel.font = [UIFont wf_pfr14];
    _orderId.font = [UIFont wf_pfr14];
    _orderIdLabel.textColor = [UIColor wf_placeHolderColor];
    _orderId.textColor = [UIColor wf_placeHolderColor];
    
    _orderStatusLabel.font = [UIFont wf_pfr13];
    _status.font = [UIFont wf_pfr13];
    _status.textColor = [UIColor blueColor];
    
    _amountLabel.font = [UIFont wf_pfr13];
    _amount.font = [UIFont wf_pfr13];
    _amount.textColor = [UIColor wf_redColor];
    
    _btn.titleLabel.font = [UIFont wf_pfr13];
    [_btn setBackgroundColor:[UIColor wf_mainColor]];
    [_btn addTarget:self action:@selector(goBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [DCSpeedy dc_chageControlCircularWith:_btn AndSetCornerRadius:5 SetBorderWidth:0 SetBorderColor:nil canMasksToBounds:YES];
}

- (void)goBtnClicked {
    switch (_order.state) {
        case WFOrderStateUnpayed:
            [[ADSRouter sharedRouter] openUrlString:[NSString stringWithFormat:@"wfshop://pay?orderId=%@", _order.orderId]];
            break;
        case WFOrderStateUncheck:

            break;
        case WFOrderStateUncomment:

            break;
        default:
            break;
    }
}

- (void)setOrder:(WFOrder *)order {
    _order = order;
    _orderId.text = _order.orderId;
    _status.text = _order.orderStateStr;
     [_btn setHidden:NO];
    switch (_order.state) {
        case WFOrderStateUnpayed:
            [_btn setTitle:@"去支付" forState:UIControlStateNormal];
            break;
        case WFOrderStateUncheck:
            [_btn setTitle:@"去确认收货" forState:UIControlStateNormal];
            break;
        case WFOrderStateUncomment:
            [_btn setTitle:@"去评价" forState:UIControlStateNormal];
            break;
        default:
            [_btn setHidden:YES];
            break;
    }
}

@end
