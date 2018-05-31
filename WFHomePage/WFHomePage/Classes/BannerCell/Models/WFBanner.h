//
//  WFBanner.h
//  ADSRouter
//
//  Created by Andy on 2017/10/13.
//

#import <Foundation/Foundation.h>
#import "WFHomePageRow.h"

@interface WFBannerImage: NSObject

@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *actionUrl;

@end

@interface WFBanner : NSObject

@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, strong) NSArray<WFBannerImage*> *images;

@end
