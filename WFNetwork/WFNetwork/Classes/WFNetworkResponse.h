//
//  WFNetworkResponse.h
//  ADSRouter
//
//  Created by Andy on 2017/11/14.
//

#import <Foundation/Foundation.h>

@interface WFNetworkResponse : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) id data;

@end
