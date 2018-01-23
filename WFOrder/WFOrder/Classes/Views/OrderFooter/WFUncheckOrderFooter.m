//
//  WFUncheckOrderFooter.m
//  ADSRouter
//
//  Created by Andy on 2018/1/22.
//

#import "WFUncheckOrderFooter.h"
#import "WFUIComponent.h"

@implementation WFUncheckOrderFooter

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI {
    [self.leftBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor wf_mainColor] forState:UIControlStateNormal];
    
    [self.rightBtn setTitle:@"联系客服" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor wf_lightGrayColor] forState:UIControlStateNormal];
    
    [DCSpeedy dc_chageControlCircularWith:self.leftBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor wf_mainColor] canMasksToBounds:YES];
    [DCSpeedy dc_chageControlCircularWith:self.rightBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor wf_lightGrayColor] canMasksToBounds:YES];
}

@end
