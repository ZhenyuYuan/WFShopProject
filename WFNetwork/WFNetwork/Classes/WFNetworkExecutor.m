//
//  WFNetworkExecutor.m
//  WFByr
//
//  Created by Andy on 2017/8/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFNetworkExecutor.h"
#import "AFHTTPSessionManager+Singleton.h"
#import "YYModel.h"

@implementation WFNetworkResponseObj
@end

@implementation WFNetworkExecutor

+ (NSURLSessionDataTask*)requestWithUrl:(NSString *)url
                             parameters:(NSDictionary *)parameters
                                 option:(WFRequestOption)option
                               complete:(void (^)(NSURLResponse *, WFNetworkResponseObj *, NSError *))complete {
    AFHTTPSessionManager  *manager = [AFHTTPSessionManager sharedHttpSessionManager];
    NSMutableDictionary *params = [parameters mutableCopy];
    if (!params) {
        params = [NSMutableDictionary dictionary];
    }
    if (option & WFRequestOptionWithToken) {
//        [params setValue:@"" forKey:WFByrTokenKey];
    }
    if (option & WFRequestOptionGet) {
        NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:params error:nil];
        NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (complete) {
                complete(response, [WFNetworkResponseObj yy_modelWithJSON:responseObject], error);
            }
        }];
        [task resume];
        return task;
    } else if (option & WFRequestOptionPost) {
        NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:params error:nil];
        NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (complete) {
                complete(response, [WFNetworkResponseObj yy_modelWithJSON:responseObject], error);
            }
        }];
        [task resume];
        return task;
    } else {
        return nil;
    }
}

@end
