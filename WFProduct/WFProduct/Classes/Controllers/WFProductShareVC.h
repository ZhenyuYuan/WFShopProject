//
//  WFProductShareVC.h
//  WFProduct
//
//  Created by Andy on 2017/11/20.
//

#import <UIKit/UIKit.h>

@class WFShareItem;
@interface WFProductShareVC : UIViewController

@property (nonatomic, weak) UIViewController *productVC;
@property (nonatomic, strong) WFShareItem *shareItem;

@end
