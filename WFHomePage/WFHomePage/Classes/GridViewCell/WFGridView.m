//
//  WFGridView.m
//  ADSRouter
//
//  Created by Andy on 2017/10/16.
//

#import "WFGridView.h"
#import "WFGridViewData.h"
#import "UIImageView+WebCache.h"
#import "WFAdTapGestureRecognizer.h"
#import "ADSRouter.h"
#import "Masonry.h"

void _wf_linkTwoView(UIView *prevView, UIView *currentView, UIView *superView, NSString *orientation, CGFloat weight) {
    if ([orientation isEqualToString:@"h"]) {
        [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (prevView) {
                make.left.equalTo(prevView.mas_right);
            } else {
                make.left.equalTo(superView.mas_left);
            }
            make.top.bottom.equalTo(superView);
            make.width.equalTo(superView.mas_width).multipliedBy(weight);
        }];
    } else {
        [currentView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (prevView) {
                make.top.equalTo(prevView.mas_bottom);
            } else {
                make.top.equalTo(superView.mas_top);
            }
            make.height.equalTo(superView.mas_height).multipliedBy(weight);
            make.left.right.equalTo(superView);
        }];
    }
}


@implementation WFGridView

+ (instancetype)gridViewWithGridViewData:(WFGridViewData *)data {
    WFGridView *view = [WFGridView new];
    [view _wf_doLayoutWithLayoutData:data];
    return view;
}

- (void)_wf_doLayoutWithLayoutData:(WFGridViewData*)data {
    if (data.cells.count != 0) {
        NSInteger weightCount = 0;
        for (WFGridViewData *cell in data.cells) {
            [self addSubview:[WFGridView gridViewWithGridViewData:cell]];
            weightCount += cell.weight;
        }
        
        for (NSInteger cellIndex = 0; cellIndex < data.cells.count; ++cellIndex) {
            if (cellIndex == 0) {
                _wf_linkTwoView(nil,
                                self.subviews[cellIndex],
                                self,
                                data.orientation,
                                data.cells[cellIndex].weight / weightCount);
            } else {
                _wf_linkTwoView(self.subviews[cellIndex - 1],
                                self.subviews[cellIndex],
                                self,
                                data.orientation,
                                data.cells[cellIndex].weight / weightCount);
            }
        }
    } else {
        UIImageView *imgView = [UIImageView new];
        [imgView sd_setImageWithURL:[NSURL URLWithString:data.imgUrl]];
        imgView.userInteractionEnabled = YES;
        WFAdTapGestureRecognizer *recognizer = [[WFAdTapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
        recognizer.url = data.actionUrl;
        [imgView addGestureRecognizer:recognizer];
        [self addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
}

- (void)clicked:(WFAdTapGestureRecognizer*)recognizer {
    [[ADSRouter sharedRouter] openUrlString:recognizer.url];
}

@end
