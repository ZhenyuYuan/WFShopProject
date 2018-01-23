//
//  WFMyShareCell.h
//  ADSRouter
//
//  Created by Andy on 2018/1/19.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WFShareCellType) {
    WFShareCellTypeDaily,
    WFShareCellTypeTotal,
    WFShareCellTypeUnshare,
};

@interface WFMyShareCell : UITableViewCell

@property (nonatomic, assign) WFShareCellType type;
@property (nonatomic, copy) NSString *detail;

@end
