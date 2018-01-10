//
//  WFLauchAdProtocol.h
//  ADSRouter
//
//  Created by Andy on 2018/1/8.
//

#import <Foundation/Foundation.h>

@protocol WFLaunchAdProtocol <NSObject>

- (UIViewController*)launchAdVC:(dispatch_block_t)skipBlock;

@end
