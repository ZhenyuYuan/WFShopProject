//
//  UITableViewCell+WFReuseIdentifier.m
//  ADSRouter
//
//  Created by Andy on 2017/10/16.
//

#import "UIView+WFReuseIdentifier.h"

@implementation UIView (WFReuseIdentifier)

+ (NSString*)wf_reuseIdentifier {
    return NSStringFromClass(self.class);
}

@end
