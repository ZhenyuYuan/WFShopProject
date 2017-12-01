//
//  WFGridCell.h
//  WFGridLayout
//
//  Created by Andy on 2017/6/21.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WFGridViewData;
@interface WFGridCell : UITableViewCell

- (void)setUpWithGridData:(WFGridViewData*)gridViewData;

@end
