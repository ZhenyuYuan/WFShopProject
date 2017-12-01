//
//  WFSearchHistoryCell.h
//  ADSRouter
//
//  Created by Andy on 2017/11/22.
//

#import <UIKit/UIKit.h>

@class WFHistorySearchItem;
@interface WFSearchHistoryCell : UITableViewCell

@property (nonatomic, strong) WFHistorySearchItem *item;

@property (nonatomic, copy) dispatch_block_t didClickDelBtn;

@end
