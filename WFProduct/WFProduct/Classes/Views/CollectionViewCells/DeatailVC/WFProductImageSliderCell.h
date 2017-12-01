//
//  WFProductImageSliderCell.h
//  ADSRouter
//
//  Created by Andy on 2017/11/9.
//

#import <UIKit/UIKit.h>

@interface WFProductImageSliderCell : UICollectionViewCell

@property (nonatomic, strong) NSArray<NSString*> *imageUrls;
@property (nonatomic, copy) void(^didClicked)(UIView *clickedView, NSUInteger clickedIndex);

@end
