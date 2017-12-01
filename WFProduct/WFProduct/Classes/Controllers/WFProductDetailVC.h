//
//  WFProductDetailVC.h
//  ADSRouter
//
//  Created by Andy on 2017/11/7.
//

#import <UIKit/UIKit.h>

@class WFProduct;
@interface WFProductDetailVC : UIViewController

@property (nonatomic, copy) NSString *selectedFeatures;
@property (nonatomic, copy) NSString *selectedAddress;

@property (nonatomic, copy) void(^didSelectProductDetail)(void);
@property (nonatomic, copy) void(^didSelectShipAddress)(void);

@property (nonatomic, strong) WFProduct *product;

@end
