//
//  WFNetworkExecutor.h
//  WFByr
//
//  Created by Andy on 2017/8/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, WFRequestOption) {
    WFRequestOptionDefault   = 1 << 0,
    WFRequestOptionGet       = 1 << 1,
    WFRequestOptionPost      = 1 << 2,
    WFRequestOptionWithToken = 1 << 3
};

@interface WFNetworkResponseObj : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) id data;

@end

@interface WFNetworkExecutor : NSObject

+ (NSURLSessionDataTask*)requestWithUrl:(NSString*)url
                             parameters:(NSDictionary*)parameters
                                 option:(WFRequestOption)option
                               complete:(void(^)(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error))complete;

@end
