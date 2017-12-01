//
//  WFSwitchButton.m
//  ADSRouter
//
//  Created by Andy on 2017/11/8.
//

#import "WFSwitchButton.h"

// Vendors
#import "Masonry.h"
// Categories
#import "UIView+WFExtension.h"
#import "UIColor+WFColor.h"

@interface WFSwitchButton ()

@property (nonatomic, copy) void(^actionBlk)(NSInteger idx);
/** 记录上一次选中的Button */
@property (nonatomic, assign) NSInteger selectIdx;

/** 记录上一次选中的Button底部View */
@property (nonatomic, strong) UIView *selectedIndicator;
@property (nonatomic, strong) NSMutableArray<MASConstraint*> *leftConstraints;

@property (nonatomic, strong) NSArray<UIButton*> *btns;

@end

@implementation WFSwitchButton

+ (WFSwitchButton*)switchButtonWithTitles:(NSArray<NSString *> *)titles actionBlock:(void (^)(NSInteger))block {
    WFSwitchButton *switchBtn = [[WFSwitchButton alloc] initWithTitles:titles actionBlock:block];
    return switchBtn;
}

- (instancetype)initWithTitles:(NSArray<NSString*>*)titles actionBlock:(void(^)(NSInteger))block {
    self.titles = titles;
    self.actionBlk = block;
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor clearColor];
    NSMutableArray<UIButton*> *btns = [NSMutableArray arrayWithCapacity:_titles.count];
    for (NSInteger i = 0; i < _titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor wf_mainColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        btns[i] = btn;
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self);
            if (i > 0) {
                make.left.equalTo(btns[i-1].mas_right);
                make.width.equalTo(btns[0].mas_width);
            } else {
                make.left.mas_equalTo(self);
            }
            if (i + 1 == _titles.count) {
                make.right.mas_equalTo(self);
            }
        }];
    }
    _btns = btns.copy;
    
    _selectedIndicator = [UIView new];
    _selectedIndicator.backgroundColor = [UIColor wf_mainColor];
    [self addSubview:_selectedIndicator];
    [_selectedIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_btns[0].mas_width);
        make.height.equalTo(@(3));
        make.bottom.mas_equalTo(self);
        _leftConstraints = [NSMutableArray arrayWithCapacity:_btns.count];
        for (NSInteger idx = 0; idx < _btns.count; ++idx) {
            _leftConstraints[idx] = make.left.equalTo(_btns[idx].mas_left).priorityMedium();
        }
    }];
    [self btnClicked:_btns[0]];
}

#pragma mark - 按钮点击
- (void)btnClicked:(UIButton*)sender {
    for (MASConstraint *constraint in _leftConstraints) {
        [constraint uninstall];
    }
    NSInteger idx = [_btns indexOfObject:sender];
    [self layoutIfNeeded];
    [_leftConstraints[idx] install];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self layoutIfNeeded];
    } completion:nil];
    if (_actionBlk) {
        _actionBlk(idx);
    }
}

- (void)setFont:(UIFont *)font {
    [_btns enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.titleLabel.font = font;
    }];
}

@end
