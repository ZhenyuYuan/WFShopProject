//
//  WFAppLaunchServiceProtocol.h
//  WFShop
//
//  Created by Andy on 2017/10/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;
@protocol WFAppLaunchServiceProtocol <NSObject>

@required
- (UIViewController*)rootVC;

@end
