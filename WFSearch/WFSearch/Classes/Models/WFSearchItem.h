//
//  WFSearchItem.h
//  ADSRouter
//
//  Created by Andy on 2017/10/24.
//

#import <Foundation/Foundation.h>

@interface WFSearchItem : NSObject

@property (nonatomic, copy) NSString *itemId;
/** 图片URL */
@property (nonatomic, copy) NSString *imgUrl;
/** 商品标题 */
@property (nonatomic, copy) NSString *name;
/** 商品价格 */
@property (nonatomic, assign) CGFloat price;
/**  */
@property (nonatomic, assign) NSInteger commentCount;


@end
