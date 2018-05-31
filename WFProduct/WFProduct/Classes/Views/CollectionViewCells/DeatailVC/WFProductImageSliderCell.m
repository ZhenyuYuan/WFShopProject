//
//  WFProductImageSliderCell.m
//  ADSRouter
//
//  Created by Andy on 2017/11/9.
//

#import "WFProductImageSliderCell.h"

#import "SDCycleScrollView.h"
#import "UIView+WFExtension.h"
#import "WFConsts.h"

@interface WFProductImageSliderCell () <SDCycleScrollViewDelegate>

@property (strong , nonatomic) SDCycleScrollView *cycleScrollView;

@end

@implementation WFProductImageSliderCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.wf_width, self.wf_height) delegate:self placeholderImage:nil];
    _cycleScrollView.backgroundColor = [UIColor whiteColor];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
    _cycleScrollView.autoScroll = NO; // 不自动滚动
    [self addSubview:_cycleScrollView];
}

#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSUInteger)index {
    if (_didClicked) {
        _didClicked(cycleScrollView, index);
    }
}

#pragma mark - Setter Getter Methods
- (void)setImageUrls:(NSArray<NSString *> *)imageUrls {
    _imageUrls = imageUrls;
    _cycleScrollView.imageURLStringsGroup = _imageUrls;
}


@end
