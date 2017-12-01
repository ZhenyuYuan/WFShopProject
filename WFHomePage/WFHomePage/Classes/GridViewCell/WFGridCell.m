//
//  WFGridCell.m
//  WFGridLayout
//
//  Created by Andy on 2017/6/21.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFGridCell.h"
#import "WFGridView.h"
#import "Masonry.h"

@interface WFGridCell ()
@end

@implementation WFGridCell {
    WFGridView *_gridView;
}

- (void)setUpWithGridData:(WFGridViewData *)gridViewData {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [_gridView removeFromSuperview];
    _gridView = [WFGridView gridViewWithGridViewData:gridViewData];
    [self.contentView addSubview:_gridView];
    [_gridView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

@end
