//
//  WFProductShopCell.h
//  WFProduct
//
//  Created by Andy on 2017/11/10.
//

#import <UIKit/UIKit.h>

@class WFProductShop;
@interface WFProductShopCell : UICollectionViewCell

@property (nonatomic, strong) WFProductShop *shop;
@property (nonatomic, copy) dispatch_block_t didClickGoInBtn;
@property (nonatomic, copy) dispatch_block_t didClickContactBtn;

@end
