//
//  WFHomePageCellFactory.m
//  ADSRouter
//
//  Created by Andy on 2017/10/16.
//

#import "WFHomePageCellFactory.h"
#import "WFBannerCell.h"
#import "WFGridCell.h"
#import "WFSeparatorCell.h"

#define WFSCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define WFSCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

@implementation WFHomePageCellFactory

+ (instancetype)sharedFactory {
    static WFHomePageCellFactory *factory;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        factory = [WFHomePageCellFactory new];
    });
    return factory;
}

+ (UITableViewCell*)cellWithRowData:(WFHomePageRow*)row {
    return [[WFHomePageCellFactory sharedFactory] _wf_cellWithRowData:row];
}

- (UITableViewCell*)_wf_cellWithRowData:(WFHomePageRow*)row {
    UITableViewCell *cell;
    if ([row.styleId isEqualToString:@"carousel_view"]) {
        CGRect bannerFrame =CGRectMake(0, 0, WFSCREEN_WIDTH, WFSCREEN_WIDTH * row.ratio);
        cell = [[WFBannerCell alloc] initWithFrame:bannerFrame];
        [(WFBannerCell*)cell setUpWithBanner:row.data];
    } else if ([row.styleId isEqualToString:@"grid_view"]) {
        cell = [WFGridCell new];
        [(WFGridCell*)cell setUpWithGridData:row.data];
    } else if ([row.styleId isEqualToString:@"separator_view"]) {
        cell = [WFSeparatorCell new];
        [(WFSeparatorCell*)cell setUpWithSeparator:row.data];
    }
    return cell;
}


@end
