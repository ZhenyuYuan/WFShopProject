//
//  WFSearchListVC.m
//
//
//  Created by Andy on 2017/10/24.
//

#import "WFSearchListVC.h"

// Controllers


// Models
#import "WFSearchItem.h"
// Views
#import "WFNavSearchBarView.h"
#import "WFCustionHeadView.h"
#import "WFSearchGridCell.h"
#import "WFSearchListCell.h"
#import "WFColonInsView.h"
#import "WFHoverFlowLayout.h"

// Vendors
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"
#import "ADSRouter.h"
// Categories
#import "UIFont+WFFont.h"
#import "UIColor+WFColor.h"
// Others
#import "WFHelpers.h"
#import "WFConsts.h"
#import "WFSearchDataService.h"


@interface WFSearchListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/* scrollerVew */
@property (strong , nonatomic)UICollectionView *collectionView;


/* 自定义头部View */
@property (strong , nonatomic) WFCustionHeadView *custionHeadView;
/* 具体商品数据 */
@property (strong , nonatomic)NSMutableArray<WFSearchItem *> *setItem;


/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;


@property (nonatomic, strong) WFSearchDataService *dataService;

@end

static CGFloat _lastContentOffset;


@implementation WFSearchListVC
ADS_REQUEST_MAPPING(WFSearchListVC, "wfshop://searchList")
ADS_PARAMETER_MAPPING(WFSearchListVC, catagory, "catagory")
ADS_PARAMETER_MAPPING(WFSearchListVC, query, "query")
ADS_HIDE_BOTTOM_BAR

#pragma mark  - 防止警告
- (NSString *)goodPlisName
{
    return nil;
}

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        WFHoverFlowLayout *layout = [WFHoverFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.frame = CGRectMake(0, WFTopNavH, WFGetScreenWidth(), WFGetScreenHeight() - WFTopNavH);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[WFCustionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[WFCustionHeadView wf_reuseIdentifier]]; //头部View
        [_collectionView registerClass:[WFSearchGridCell class] forCellWithReuseIdentifier:[WFSearchGridCell wf_reuseIdentifier]];
         [_collectionView registerClass:[WFSearchListCell class] forCellWithReuseIdentifier:[WFSearchListCell wf_reuseIdentifier]];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if (self.navigationController.navigationBar.barTintColor == DCBGColor)return;
//    self.navigationController.navigationBar.barTintColor = DCBGColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self setUpData];
}

#pragma mark - initialize
- (void)setUpUI {
    
    [self setUpNav];
    
    [self setUpCollectionView];
    
    [self setUpSuspendView];
}

- (void)setUpCollectionView {
    // 默认列表视图
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor wf_mainBackgroundColor];
    self.collectionView.backgroundColor = self.view.backgroundColor;
}

#pragma mark - 加载数据
- (void)setUpData
{
    _setItem = [NSMutableArray array];
    _dataService = [WFSearchDataService new];
    __weak typeof(self) weakSelf = self;
    [_dataService getSearchResult:^(NSArray<WFSearchItem *> *items) {
        [weakSelf.setItem addObjectsFromArray:items];
        [weakSelf.collectionView reloadData];
    }];
}

#pragma mark - 导航栏
- (void)setUpNav {
    self.title = @"";
    WFNavSearchBarView *searchBarVc = [[WFNavSearchBarView alloc] init];
    searchBarVc.placeholdLabel.text = @"快速查找商品";
    searchBarVc.frame = CGRectMake(40, 25, WFGetScreenWidth() * 0.68, 35);
    searchBarVc.voiceImageBtn.hidden = YES;
    searchBarVc.searchViewBlock = ^{
        [[ADSRouter sharedRouter] openUrlString:@"wfshop://search"];
    };
    self.navigationItem.titleView = searchBarVc;
}

#pragma mark - 悬浮按钮
- (void)setUpSuspendView {
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(WFGetScreenWidth() - 50, WFGetScreenHeight() - 60, 40, 40);
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _setItem.count;
}

#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WFSearchGridCell *cell = nil;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:[WFSearchListCell wf_reuseIdentifier] forIndexPath:indexPath];
    cell.searchItem = _setItem[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        
        WFCustionHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[WFCustionHeadView wf_reuseIdentifier] forIndexPath:indexPath];
        __weak typeof(self)weakSelf = self;
      
        reusableview = headerView;
    }
    return reusableview;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //return CGSizeMake((WFGetScreenWidth() - 4)/2, (WFGetScreenWidth() - 4)/2 + 60);
    return CGSizeMake(WFGetScreenWidth(), 120);
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(WFGetScreenWidth(), 40); //头部
}

#pragma mark - 边间距属性默认为0
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
    
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    //return 4;
    return 0;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WFSearchItem *selectedItem = _setItem[indexPath.row];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[ADSRouter sharedRouter] openUrlString:[@"wfshop://product?productId=" stringByAppendingString:selectedItem.itemId]];
    
}


#pragma mark - 滑动代理
//开始滑动的时候记录位置
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    _lastContentOffset = scrollView.contentOffset.y;
    
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
    if(scrollView.contentOffset.y > _lastContentOffset){
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.collectionView.frame = CGRectMake(0, 20, WFGetScreenWidth(), WFGetScreenHeight() - 20);
        self.view.backgroundColor = [UIColor whiteColor];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.collectionView.frame = CGRectMake(0, WFTopNavH, WFGetScreenWidth(), WFGetScreenHeight() - WFTopNavH);
//        self.view.backgroundColor = DCBGColor;
    }
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断回到顶部按钮是否隐藏
    _backTopButton.hidden = (scrollView.contentOffset.y > WFGetScreenHeight()) ? NO : YES;
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
       // strongSelf.footprintButton.dc_y = (strongSelf.backTopButton.hidden == YES) ? WFGetScreenHeight() - 60 : WFGetScreenHeight() - 110;
    }];
    
}

#pragma mark - 点击事件

#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

#pragma mark - 转场动画弹出控制器
- (void)setUpAlterViewControllerWith:(UIViewController *)vc WithDistance:(CGFloat)distance
{
    XWDrawerAnimatorDirection direction = XWDrawerAnimatorDirectionRight;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.parallaxEnable = YES;
    [self xw_presentViewController:vc withAnimator:animator];
    __weak typeof(self)weakSelf = self;
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlterViewback];
    }];
}

#pragma 退出界面
- (void)selfAlterViewback{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
