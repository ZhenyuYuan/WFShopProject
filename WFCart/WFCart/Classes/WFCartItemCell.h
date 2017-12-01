//
//  WFCartItemCell.h
//  ADSRouter
//
//  Created by Andy on 2017/11/22.
//

#import <UIKit/UIKit.h>

@class WFCartItem;
@interface WFCartItemCell : UITableViewCell

@property (nonatomic, strong) WFCartItem *cartItem;
@property (nonatomic, copy) void (^didCheckOrUncheck)(BOOL check);
@property (nonatomic, copy) dispatch_block_t didChangeAmount;
@property (nonatomic, copy) dispatch_block_t didWantToDel;

@end
