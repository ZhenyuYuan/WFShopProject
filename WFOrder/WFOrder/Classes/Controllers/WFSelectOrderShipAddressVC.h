//
//  WFSelectOrderShipAddress.h
//  ADSRouter
//
//  Created by Andy on 2017/12/15.
//

#import <UIKit/UIKit.h>

@class WFOrderShipAddress;
@interface WFSelectOrderShipAddressVC : UIViewController

@property (nonatomic, strong) WFOrderShipAddress *selectedAddress;
@property (nonatomic, copy) void(^didSelectShipAddress)(WFOrderShipAddress *address);

@end
