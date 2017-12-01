//
//  WFHomePageCellFactory.h
//  ADSRouter
//
//  Created by Andy on 2017/10/16.
//

#import <Foundation/Foundation.h>
#import "Models/WFHomePageRow.h"

@interface WFHomePageCellFactory : NSObject

+ (UITableViewCell*)cellWithRowData:(WFHomePageRow*)row;

@end
