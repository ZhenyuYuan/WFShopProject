//
//  WFProductComment.h
//  ADSRouter
//
//  Created by Andy on 2017/12/13.
//

#import <Foundation/Foundation.h>

@interface WFProductBuyer : NSObject

@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, copy) NSString *buyerName;


@end

@interface WFProductComment : NSObject

@property (nonatomic, strong) WFProductBuyer *buyer;
@property (nonatomic, assign) CGFloat rating;
@property (nonatomic, copy) NSString *comment;

@end
