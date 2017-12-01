//
//  DCSwitchGridCell.h
//  CDDMall
//
//  Created by apple on 2017/6/14.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+WFReuseIdentifier.h"

@class WFSearchItem;

@interface WFSearchGridCell : UICollectionViewCell

/* 推荐数据 */
@property (strong , nonatomic) WFSearchItem *searchItem;


@end
