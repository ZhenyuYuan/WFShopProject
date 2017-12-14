//
//  WFLoginVC.h
//  ADSRouter
//
//  Created by Andy on 2017/12/14.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WFLoginType) {
    WFLoginTypePhone = 0,
    WFLoginTypeEmail
};

@interface WFLoginVC : UIViewController

@property (nonatomic, assign) WFLoginType loginType;

@end
