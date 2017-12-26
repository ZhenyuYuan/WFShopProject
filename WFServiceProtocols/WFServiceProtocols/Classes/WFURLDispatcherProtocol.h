//
//  WFURLDispatcherProtocol.h
//  ADSRouter
//
//  Created by Andy on 2017/12/25.
//

#import <Foundation/Foundation.h>

@protocol WFURLDispatcherProtocol <NSObject>

- (void)openUrlString:(NSString*)urlString;

- (void)openUrl:(NSURL*)url;

@end
