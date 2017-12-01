//
//  WFBannerCell.h
//  ADSRouter
//
//  Created by Andy on 2017/10/13.
//

#import <UIKit/UIKit.h>

@class WFBanner;
@interface WFBannerCell : UITableViewCell

- (void)setUpWithData:(id)data;
- (void)setUpWithBanner:(WFBanner*)banner;

@end
