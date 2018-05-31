//
//  WFShipAddressSelectVC.h
//  ADSRouter
//
//  Created by Andy on 2017/11/13.
//

#import <UIKit/UIKit.h>

@class WFProductShipAddress;
@interface WFShipAddressSelectVC : UIViewController

@property (nonatomic, copy) void (^didSelectAddress)(WFProductShipAddress *selectedAddress);

@end
