//
//  main.m
//  WFShop
//
//  Created by Andy on 2017/10/11.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "QTouchposeApplication.h"


int main(int argc, char * argv[]) {
    @autoreleasepool {
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        return UIApplicationMain(argc, argv,
                                 NSStringFromClass([QTouchposeApplication class]),
                                 NSStringFromClass([AppDelegate class]));
    }
}
