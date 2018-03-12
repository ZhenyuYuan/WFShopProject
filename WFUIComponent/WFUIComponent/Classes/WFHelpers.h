//
//  WFHelpers.h
//  ADSRouter
//
//  Created by Andy on 2017/10/24.
//

#import <Foundation/Foundation.h>

@class MBProgressHUD;
extern CGFloat WFGetScreenWidth(void);
extern CGFloat WFGetScreenHeight(void);

extern void WFShowHud(NSString *msg, UIView *toView, CGFloat duration);

extern MBProgressHUD*  WFShowProgressHud(NSString *msg, UIView *toView, CGFloat duration);

extern NSBundle* WFGetBundle(NSString *bundleName);

extern NSString* WFGetPathForFile(NSString *fileName, NSString *extension, NSString *bundleName);

extern void WFAskSomething(NSString *title, NSString *msg, UIViewController *vc, dispatch_block_t yesBlk, dispatch_block_t noBlk);

@interface WFHelpers : NSObject

@end
