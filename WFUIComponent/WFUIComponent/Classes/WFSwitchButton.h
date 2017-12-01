//
//  WFSwitchButton.h
//  ADSRouter
//
//  Created by Andy on 2017/11/8.
//

#import <UIKit/UIKit.h>

@interface WFSwitchButton : UIView

@property (nonatomic, strong) NSArray<NSString*>*titles;
@property (nonatomic, strong) UIFont *font;

+ (WFSwitchButton*)switchButtonWithTitles:(NSArray<NSString*>*)titles actionBlock:(void (^)(NSInteger idx))block;

@end
