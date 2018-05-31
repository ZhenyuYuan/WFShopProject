//
//  WFProductDetailSelectVC.h
//  ADSRouter
//
//  Created by Andy on 2017/11/13.
//

#import <UIKit/UIKit.h>

@class WFProduct, WFProductDetailFeature, WFProductSelectedFeature;
@interface WFProductDetailSelectVC : UIViewController

@property (nonatomic, strong) WFProduct *product;

@property (nonatomic, copy) void (^didSelectAllFeature)(NSArray<WFProductDetailFeature*> *features);

@end
