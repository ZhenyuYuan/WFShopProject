//
//  AFHTTPSessionManager+Singleton.h
//  WFByr
//
//  Created by Andy on 2017/8/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFHTTPSessionManager (Singleton)

+ (AFHTTPSessionManager *)sharedHttpSessionManager;

@end
