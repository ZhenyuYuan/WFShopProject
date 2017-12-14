//
//  WFAPIFactory.h
//  ADSRouter
//
//  Created by Andy on 2017/12/13.
//

#import <Foundation/Foundation.h>

@interface WFAPIFactory : NSObject

+ (NSString*)URLWithNameSpace:(NSString*)nameSpace objId:(NSString*)objId path:(NSString*)path;

@end
