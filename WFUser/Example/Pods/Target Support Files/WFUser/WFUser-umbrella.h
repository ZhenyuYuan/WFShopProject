#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "WFLoginVC.h"
#import "WFMeVC.h"
#import "WFShareIncomeVC.h"
#import "WFWechatLoginVC.h"
#import "WFWechatLoginWaitingVC.h"
#import "WFShareIncomeItem.h"
#import "WFUser.h"
#import "WFUserNormalFunction.h"
#import "WFUserNormalFunctionGroup.h"
#import "WFUserToken.h"
#import "WFWechatAuthorizeObj.h"
#import "WFWechatUser.h"
#import "WFWechatLoginModule.h"
#import "WFUserCenter.h"
#import "WFUserDataService.h"
#import "WFUserLoginDataService.h"
#import "WFUserService.h"
#import "WFWechatLoginService.h"
#import "WFWechatUserService.h"
#import "WFMyCouponDetailCell.h"
#import "WFMyCouponHeaderCell.h"
#import "WFMyShareCell.h"
#import "WFMyShareHeaderCell.h"
#import "WFShareIncomeHeader.h"
#import "WFShareIncomeItemCell.h"
#import "WFUserCell.h"
#import "WFUserNormalFunctionCell.h"
#import "WFUserOrderCell.h"
#import "WFUserOrderDetailCell.h"
#import "WFUserSeparatorCell.h"

FOUNDATION_EXPORT double WFUserVersionNumber;
FOUNDATION_EXPORT const unsigned char WFUserVersionString[];

