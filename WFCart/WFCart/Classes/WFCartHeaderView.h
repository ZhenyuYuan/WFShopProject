//
//  WFCartHeaderView.h
//  ADSRouter
//
//  Created by Andy on 2017/11/23.
//

#import <UIKit/UIKit.h>
#import "WFCartItem.h"
@interface WFCartHeaderView : UIView

@property (nonatomic, strong) WFCartItemGroup *cartGroup;
@property (nonatomic, copy) void (^didCheckOrUncheck)(BOOL check);

@end
