//
//  WFUserOrderDetailCell.h
//  ADSRouter
//
//  Created by Andy on 2017/11/18.
//

#import <UIKit/UIKit.h>

@interface WFUserOrderDetailCell : UITableViewCell

@property (nonatomic, copy) dispatch_block_t showUnpayOrders;
@property (nonatomic, copy) dispatch_block_t showUncheckOrders;
@property (nonatomic, copy) dispatch_block_t showUncommentOrders;
@property (nonatomic, copy) dispatch_block_t showRepairOrders;

@end
