//
//  WFProductDetailVC.m
//  ADSRouter
//
//  Created by Andy on 2017/11/7.
//

#import "WFProductRootVC.h"
#import "ADSRouter.h"

#import "WFProductDetailSelectVC.h"
#import "WFProductDetailVC.h"
#import "WFProductCommentVC.h"
#import "WFShipAddressSelectVC.h"
#import "WFProductShareVC.h"

#import "WFUIComponent.h"

#import "WFUserProtocol.h"
#import "BeeHive.h"
#import "WFProductDataService.h"
#import "WFProductConsts.h"
#import "Masonry.h"
#import "YYModel.h"

#import "WFProductModels.h"

#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"


NSString *WFStringlifyProducts(NSArray<WFProduct*> *products, NSArray *amounts) {
    NSMutableArray *res = [NSMutableArray array];
    for (NSInteger idx = 0; idx < products.count; ++idx) {
        WFProduct *product = products[idx];
        [res addObject:@{@"id":product.productId,
                         @"name":product.name,
                         @"sub_title":product.subTitle,
                         @"cover_img":product.coverImgs.firstObject,
                         @"price":@(product.price),
                         @"amount":amounts[idx]
                         }];
    }
    return [res yy_modelToJSONString];
}

@interface WFProductRootVC ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *collectBtn;
@property (nonatomic, strong) UIButton *showCartBtn;
@property (nonatomic, strong) UIButton *addCartBtn;
@property (nonatomic, strong) UIButton *buyBtn;

@property (nonatomic, strong) WFProductDetailVC *productDetailVC;
@property (nonatomic, strong) WFProductCommentVC *productCommentVC;

@property (nonatomic, strong) NSArray<WFProductDetailFeature*> *features;

@property (nonatomic, strong) WFProductDataService *productDataService;

@property (nonatomic, strong) id<WFUserProtocol> userService;

@property (nonatomic, strong) WFProduct *product;

@end

@implementation WFProductRootVC

ADS_REQUEST_MAPPING(WFProductRootVC, "wfshop://product")
ADS_PARAMETER_MAPPING_SIMPLIFY(WFProductRootVC, productId)
ADS_HIDE_BOTTOM_BAR
ADS_BEFORE_JUMP(^(ADSURL *url, BOOL *stop){
    NSLog(@"show product:%@", url.parameters);
})


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self loadData];
}

- (void)setUpUI {
    self.title = @"商品详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setUpNavi];
    
    [self addSubVCs];
    
    [self setUpScrollView];
    
    [self setUpBottomBar];
}

- (void)loadData {
    [self hideUIComponents];
    _amount = 1;
    __weak typeof(self) weakSelf = self;
    _productDataService = [WFProductDataService new];
    [_productDataService getProductWithProductId:_productId callback:^(WFProduct *product) {
        weakSelf.product = product;
        [weakSelf showUIComponents];
    }];
}

- (void)hideUIComponents {
    self.scrollView.hidden = YES;
}

- (void)showUIComponents {
    self.scrollView.hidden = NO;
}


- (void)addSubVCs {
    _productDetailVC = [WFProductDetailVC new];
    __weak typeof(self) weakSelf = self;
    _productDetailVC.didSelectProductDetail = ^{
        WFProductDetailSelectVC *vc = [WFProductDetailSelectVC new];
        vc.product = weakSelf.product;
        vc.didSelectAllFeature = ^(NSArray<WFProductDetailFeature *> *features) {
            [weakSelf.productDataService getProductIdWithFeatures:features productGroupId:weakSelf.productId callback:^(NSString *productId) {
                weakSelf.productId = productId;
                [weakSelf loadData];
            }];
        };
        
        [weakSelf setUpAlterViewControllerWith:vc WithDistance:weakSelf.view.wf_height * WFProductDetailSelectViewRatio WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:YES WithFlipEnable:YES];
    };
    
    _productDetailVC.didSelectShipAddress = ^{
        WFShipAddressSelectVC *vc = [[UIStoryboard storyboardWithName:@"WFProduct" bundle:WFGetBundle(@"WFProduct")] instantiateViewControllerWithIdentifier:NSStringFromClass([WFShipAddressSelectVC class])];
        vc.didSelectAddress = ^(WFProductShipAddress *selectedAddress) {
            weakSelf.productDetailVC.selectedAddress = selectedAddress.shortAddress;
        };
        [weakSelf setUpAlterViewControllerWith:vc WithDistance:weakSelf.view.wf_height * WFShipAddressSelectViewRatio WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:YES WithFlipEnable:YES];
    };
    [self addChildViewController:_productDetailVC];
    
    _productCommentVC = [[UIStoryboard storyboardWithName:@"WFProduct" bundle:WFGetBundle(@"WFProduct")] instantiateViewControllerWithIdentifier:@"WFProductCommentVC"];
    [self addChildViewController:_productCommentVC];
}

- (void)setUpScrollView {
    self.scrollView.backgroundColor = [UIColor whiteColor];
    for (NSInteger idx = 0; idx < self.childViewControllers.count; ++idx) {
        UIView *childView = self.childViewControllers[idx].view;
        if (childView.superview) {
            continue;
        }
        childView.frame = CGRectMake(idx * _scrollView.wf_width, 0, _scrollView.wf_width, _scrollView.wf_height - WFProductBottomBarHeight);
        [_scrollView addSubview:childView];
    }
    //_scrollView.contentSize = CGSizeMake(_scrollView.wf_width * self.childViewControllers.count, _scrollView.wf_height);
}

- (void)setUpNavi {
    __weak typeof(self) weakSelf = self;
    WFSwitchButton *switchBtn = [WFSwitchButton switchButtonWithTitles:@[@"商品",@"评价"] actionBlock:^(NSInteger idx) {
        [weakSelf.scrollView setContentOffset:CGPointMake(idx * weakSelf.scrollView.wf_width, 0) animated:YES];
    }];
    switchBtn.font = [UIFont wf_pfr16];
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(100));
    }];
    self.navigationItem.titleView = switchBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share" inBundle:WFGetBundle(@"WFProduct") compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(shareBtnClicked)];
}

- (void)setUpBottomBar {
    
    _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_collectBtn addTarget:self action:@selector(collectBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_collectBtn setBackgroundColor:[UIColor whiteColor]];
    [_collectBtn setImage:[UIImage imageNamed:@"fav" inBundle:WFGetBundle(@"WFProduct") compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    _collectBtn.tintColor = [UIColor wf_placeHolderColor];
    [self.view addSubview:_collectBtn];
    
    _showCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _showCartBtn.backgroundColor = [UIColor whiteColor];
    [_showCartBtn addTarget:self action:@selector(showCartBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_showCartBtn setImage:[UIImage imageNamed:@"cart" inBundle:WFGetBundle(@"WFProduct") compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [self.view addSubview:_showCartBtn];
    
    _addCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [_addCartBtn addTarget:self action:@selector(addCartBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    _addCartBtn.titleLabel.font = [UIFont wf_pfr16];
    _addCartBtn.backgroundColor = [UIColor wf_mainColor];
    [self.view addSubview:_addCartBtn];
    
    _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [_buyBtn addTarget:self action:@selector(buyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    _buyBtn.titleLabel.font = [UIFont wf_pfr16];
    _buyBtn.backgroundColor = [UIColor wf_redColor];
    [self.view addSubview:_buyBtn];
    
    [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.2);
        make.height.equalTo(@(WFProductBottomBarHeight));
    }];
    
    [_showCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_collectBtn.mas_right);
        make.size.bottom.mas_equalTo(_collectBtn);
    }];
    
    [_addCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_showCartBtn.mas_right);
        make.height.equalTo(_collectBtn);
        make.width.equalTo(self.view).multipliedBy(0.3);
        make.bottom.equalTo(self.view);
    }];
    
    [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_addCartBtn.mas_right);
        make.size.bottom.mas_equalTo(_addCartBtn);
    }];
    
}

- (void)shareBtnClicked {
    [self setUpAlterViewControllerWith:[WFProductShareVC new] WithDistance:300 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:NO WithFlipEnable:NO];
}

#pragma mark - 转场动画弹出控制器
- (void)setUpAlterViewControllerWith:(UIViewController *)vc WithDistance:(CGFloat)distance WithDirection:(XWDrawerAnimatorDirection)vcDirection WithParallaxEnable:(BOOL)parallaxEnable WithFlipEnable:(BOOL)flipEnable
{
    //[self dismissViewControllerAnimated:YES completion:nil]; //以防有控制未退出
    XWDrawerAnimatorDirection direction = vcDirection;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.parallaxEnable = parallaxEnable;
    animator.flipEnable = flipEnable;
    [self xw_presentViewController:vc withAnimator:animator];
    __weak typeof(self)weakSelf = self;
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlterViewback];
    }];
}

- (void)showCartBtnClicked {
    [[ADSRouter sharedRouter] openUrlString:@"wfshop://cart"];
}

- (void)collectBtnClicked {
    if (![self.userService isLogined]) {
        [[ADSRouter sharedRouter] openUrlString:@"wfshop://login"];
    } else {
        __weak typeof(self) weakSelf = self;
        [_productDataService collectProduct:_productId callback:^(BOOL success) {
            WFShowHud(success ? @"收藏成功" : @"收藏失败", weakSelf.view, 1);
            if (success) {
                
            }
        }];
    }
}

- (void)addCartBtnClicked {
    if (![self.userService isLogined]) {
        [[ADSRouter sharedRouter] openUrlString:@"wfshop://login"];
    } else {
        __weak typeof(self) weakSelf = self;
        [_productDataService addProductToCart:_productId amount:_amount callback:^(BOOL success) {
            WFShowHud(success ? @"加入购物车成功" : @"加入购物车失败", weakSelf.view, 1);
        }];
    }
}

- (void)buyBtnClicked {
    if (![self.userService isLogined]) {
        [[ADSRouter sharedRouter] openUrlString:@"wfshop://login"];
    } else {
        NSString *itemsStr =WFStringlifyProducts(@[_product], @[@(_amount)]);
        [[ADSRouter sharedRouter] openUrlString:[NSString stringWithFormat:@"wfshop://completeOrder?itemsStr=%@", [[itemsStr dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:kNilOptions]]];
    }
}

#pragma 退出界面
- (void)selfAlterViewback {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIScrollView*)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.frame = self.view.bounds;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)setProductId:(NSString *)productId {
    _productId = productId;
}

- (void)setProduct:(WFProduct *)product {
    _product = product;
    self.productDetailVC.product = product;
    self.productCommentVC.productId = _product.productId;
}

- (id<WFUserProtocol>)userService {
    if (!_userService) {
        _userService = [[BeeHive shareInstance] createService:@protocol(WFUserProtocol)];
    }
    return _userService;
}

@end
