//
//  AFHTTPSessionManager+Singleton.m
//  WFByr
//
//  Created by Andy on 2017/8/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "AFHTTPSessionManager+Singleton.h"


@implementation AFHTTPSessionManager (Singleton)

+ (AFHTTPSessionManager *)sharedHttpSessionManager {
    static AFHTTPSessionManager * sessionManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
        
        sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        sessionManager.responseSerializer = responseSerializer;
        
    });
    return sessionManager;
}


@end
