//
//  WFUser.m
//  ADSRouter
//
//  Created by Andy on 2017/12/14.
//

#import "WFUser.h"

@implementation WFUser
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"avatarUrl" : @"avatar_url"
             };
}
@end
