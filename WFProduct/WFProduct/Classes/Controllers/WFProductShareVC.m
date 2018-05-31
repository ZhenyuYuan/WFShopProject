//
//  WFProductShareVC.m
//  WFProduct
//
//  Created by Andy on 2017/11/20.
//

#import "WFProductShareVC.h"
#import "WFUIComponent.h"
#import "WFShareItemCell.h"
#import "WFConsts.h"
#import "WFProductDataService.h"
#import "WFShareService.h"
#import "WFProductShareItem.h"


@interface WFProductShareVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (strong , nonatomic)UICollectionView *collectionView;

@property (nonatomic, strong) WFProductDataService *productDataService;

@property (strong , nonatomic)NSMutableArray<WFProductShareItem*> *shareItems;

@property (strong, nonatomic) WFShareService *shareService;

@end

@implementation WFProductShareVC

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        //注册
        [_collectionView registerClass:[WFShareItemCell class] forCellWithReuseIdentifier:[WFShareItemCell wf_reuseIdentifier]];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}


#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpShareAlterView];
    
    [self setUpBase];
    
    [self setUpTopBottomView];
}

- (void)setUpBase
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _productDataService = [WFProductDataService new];
    __weak typeof(self) weakSelf = self;
    [_productDataService getShareItems:^(NSArray<WFProductShareItem *> *shareItems) {
        weakSelf.shareItems = shareItems;
    }];
}

- (void)setUpTopBottomView
{
    UILabel *shareLabel = [UILabel new];
    shareLabel.text = @"分享到";
    shareLabel.font = [UIFont wf_pfr18];
    shareLabel.textAlignment = NSTextAlignmentCenter;
    shareLabel.frame = CGRectMake(0, WFMargin, self.view.wf_width, 35);
    [self.view addSubview:shareLabel];
    
    
    UIView *line = [UIView new];
    line.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.4];
    line.frame = CGRectMake(WFMargin, shareLabel.wf_bottom + WFMargin, self.view.wf_width - 2*WFMargin, 1);
    [self.view addSubview:line];
    
    self.collectionView.frame = CGRectMake(0, line.wf_bottom + WFMargin, self.view.wf_width, 160);
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:0];
    cancelButton.adjustsImageWhenHighlighted = NO;
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"share_cancle"] forState:0];
    [cancelButton setTitleColor:[UIColor blackColor] forState:0];
    cancelButton.frame = CGRectMake(WFMargin, self.collectionView.wf_bottom + WFMargin * 2, self.view.wf_width - 2 *WFMargin, 35);
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _shareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WFShareItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[WFShareItemCell wf_reuseIdentifier] forIndexPath:indexPath];
    cell.shareItem = _shareItems[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:YES completion:nil];
    _shareService = [WFShareService new];
    [_shareService shareItem:_shareItem fromVC:_productVC viaPlatform:_shareItems[indexPath.row].platformId callback:^(BOOL success, NSString *msg) {
        if (success) {
            WFShowHud(@"成功", _productVC.view, 1);
        } else {
            WFShowHud(msg, _productVC.view, 1);
        }
        self.shareService = nil;
    }];
}

#pragma mark - 弹出弹框
- (void)setUpShareAlterView
{
//    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionDown;
//    __weak typeof(self)weakSelf = self;
//    [self xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint){
//        [weakSelf dismissViewControllerAnimated:YES completion:nil];
//    } edgeSpacing:0];
}

#pragma mark - 取消点击
- (void)cancelButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.wf_width / 4, 80);
    
}

@end
