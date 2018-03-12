//
//  WFAPIFactory.h
//  ADSRouter
//
//  Created by Andy on 2017/12/13.
//

#import <Foundation/Foundation.h>

@protocol WFAPIFactoryProtocol <NSObject>
- (NSString*)URLWithNameSpace:(NSString*)nameSpace objId:(NSString*)objId path:(NSString*)path;
@end

@interface WFAPIFactory : NSObject

+ (NSString*)URLWithNameSpace:(NSString*)nameSpace objId:(NSString*)objId path:(NSString*)path;

@end

@interface WFAPIFactory2 : NSObject

+ (NSString*)URLWithNameSpace:(NSString*)nameSpace objId:(NSString*)objId path:(NSString*)path;

@end
