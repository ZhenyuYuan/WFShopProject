//
//  WFBannerCell.m
//  ADSRouter
//
//  Created by Andy on 2017/10/13.
//

#import "WFBannerCell.h"
#import "WFBanner.h"
#import "SDCycleScrollView.h"
#import "Masonry.h"
#import "YYModel.h"
#import "UIImageView+WebCache.h"
#import "ADSRouter.h"


@interface WFBannerCell () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) WFBanner *banner;
@property (nonatomic, strong) SDCycleScrollView *sliderView;

@end

@implementation WFBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUIWithFrame:self.frame];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUIWithFrame:frame];
    }
    return self;
}

- (void)setUpUIWithFrame:(CGRect)frame {
    _sliderView = [SDCycleScrollView cycleScrollViewWithFrame:frame imageURLStringsGroup:@[]];
    _sliderView.contentMode = UIViewContentModeScaleAspectFill;
    _sliderView.autoScrollTimeInterval = 5.0;
    _sliderView.delegate = self;
    [self.contentView addSubview:_sliderView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpWithData:(id)data {
    WFBanner *banner = [WFBanner yy_modelWithJSON:data];
    [self setUpWithBanner:banner];
}

- (void)setUpWithBanner:(WFBanner*)banner {
    _banner = banner;
    _sliderView.autoScrollTimeInterval = banner.duration;
    NSMutableArray<NSString*> *imgUrls = [NSMutableArray arrayWithCapacity:banner.images.count];
    [banner.images enumerateObjectsUsingBlock:^(WFBannerImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        imgUrls[idx] = obj.imgUrl;
    }];
    _sliderView.imageURLStringsGroup = [imgUrls copy];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    [[ADSRouter sharedRouter] openUrlString:_banner.images[index].actionUrl];
}

@end
