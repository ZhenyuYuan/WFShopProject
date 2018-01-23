//
//  WFOrderListFooterView.h
//  ADSRouter
//
//  Created by Andy on 2018/1/20.
//

#import <UIKit/UIKit.h>

@interface WFOrderListFooter : UIView

@property (strong, nonatomic) UILabel *detailLabel;
@property (strong, nonatomic) UIButton *leftBtn;
@property (strong, nonatomic) UIButton *rightBtn;

@property (nonatomic, copy) dispatch_block_t leftBtnClickedBlk;
@property (nonatomic, copy) dispatch_block_t rightBtnClickedBlk;

@end
