//
//  WFShareIncomeVC.h
//  ADSRouter
//
//  Created by Andy on 2018/1/20.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WFShareIncomeType) {
    WFShareIncomeTypeDaily = 0,
    WFShareIncomeTypeTotal,
    WFShareIncomeTypeUnshare
};
@interface WFShareIncomeVC : UIViewController

@property (nonatomic, assign) WFShareIncomeType shareType;

@end
