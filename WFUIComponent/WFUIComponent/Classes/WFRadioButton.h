//
//  WFRadioButton.h
//  ADSRouter
//
//  Created by Andy on 2017/11/24.
//

#import <UIKit/UIKit.h>

@interface WFRadioButton : UIButton

+ (instancetype)radioButtonWithCheckBlk:(dispatch_block_t)checkBlk uncheckBlk:(dispatch_block_t)uncheckBlk;

@end
