//
//  WFRepairOrderFooter.m
//  ADSRouter
//
//  Created by Andy on 2018/1/22.
//

#import "WFRepairOrderFooter.h"
#import "WFUIComponent.h"

@implementation WFRepairOrderFooter

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI {
    [self.rightBtn setTitle:@"申请售后" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor wf_mainColor] forState:UIControlStateNormal];
    
    self.leftBtn.hidden = YES;
    
    [DCSpeedy dc_chageControlCircularWith:self.rightBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor wf_mainColor] canMasksToBounds:YES];
}

@end
