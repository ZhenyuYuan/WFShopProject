//
//  DCClassCategoryCell.h
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+WFReuseIdentifier.h"

@class WFCategoryItem;

@interface WFCategoryCell : UITableViewCell

/* 标题数据 */
@property (strong , nonatomic)WFCategoryItem *categoryItem;

@end
