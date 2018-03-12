//
//  WFAPIFactory.m
//  ADSRouter
//
//  Created by Andy on 2017/12/13.
//

#import "WFAPIFactory.h"
#import "WFNetworkConsts.h"

static NSString * const WFBaseURL = @"https://wfshop.andysheng.cn/";
static NSString * const WFBaseURL2 = @"http://admin.swczyc.com/hyapi/ymmall/";

NSString *WFDelAndAddSlash(NSString *url) {
    NSMutableString *res = [NSMutableString stringWithString:url];
    if (![res hasSuffix:@"/"]) {
        [res appendString:@"/"];
    }
    if ([res hasPrefix:@"/"]) {
        [res deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    return [res copy];
}

@implementation WFAPIFactory

+ (NSString *)URLWithNameSpace:(NSString *)nameSpace objId:(NSString *)objId path:(NSString *)path {
    NSMutableString *url = [NSMutableString stringWithString:WFDelAndAddSlash(WFBaseURL)];
    [url appendString:WFDelAndAddSlash(nameSpace)];
    if (objId && ![objId isEqualToString:@""]) {
        [url appendString:WFDelAndAddSlash(objId)];
    }
    if (path && ![path isEqualToString:@""]) {
        [url appendString:WFDelAndAddSlash(path)];
    }
    return [url copy];
}


@end

@implementation WFAPIFactory2

+ (NSString *)URLWithNameSpace:(NSString *)nameSpace objId:(NSString *)objId path:(NSString *)path {
    NSMutableString *url = [NSMutableString stringWithString:WFDelAndAddSlash(WFBaseURL2)];
    [url appendString:WFDelAndAddSlash(nameSpace)];
    if (objId && ![objId isEqualToString:@""]) {
        [url appendString:WFDelAndAddSlash(objId)];
    }
    if (path && ![path isEqualToString:@""]) {
        [url appendString:WFDelAndAddSlash(path)];
    }
    return [url copy];
}


@end

