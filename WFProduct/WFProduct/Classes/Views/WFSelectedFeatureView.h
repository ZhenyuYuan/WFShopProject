//
//  DCFeatureChoseTopCell.h
//  CDDStoreDemo
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WFProduct;
@interface WFSelectedFeatureView : UIView

@property (nonatomic, copy) dispatch_block_t closeHandler;

@property (nonatomic, strong) WFProduct *product;

@end
