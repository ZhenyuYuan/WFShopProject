//
//  WFProductDetailSelectVC.m
//  ADSRouter
//
//  Created by Andy on 2017/11/13.
//

#import "WFProductDetailSelectVC.h"
#import "WFProductDetailFeature.h"
#import "WFProductFeatureOptionCell.h"
#import "WFProductFeatureHeaderView.h"

#import "ADSRouter.h"

#import "Masonry.h"
#import "WFUIComponent.h"
#import "WFConsts.h"
#import "WFProductConsts.h"

#import "PPNumberButton.h"

#import "WFSelectedFeatureView.h"

// Service
#import "WFProductDataService.h"

// Model
#import "WFProductFeatureOption.h"
#import "WFProduct.h"
#import "WFProductDetailFeature.h"

const CGFloat kSelectedFeatureViewHeight = 100.0;
const CGFloat kBottomBarHeight = 100.0;

@interface WFProductDetailSelectVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PPNumberButtonDelegate>

@property (nonatomic, strong) WFProductDataService *productDataService;

@property (nonatomic, strong) WFSelectedFeatureView *selectedFeatureView;

@property (strong , nonatomic) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray<WFProductDetailFeature*> *features;

@end


@implementation WFProductDetailSelectVC

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI {
    
    [self basicInit];
    
    [self setUpSelectedFeatureView];
    
    [self setUpCollectionView];
    
    [self setUpBottomBar];
}

- (void)basicInit {
    // init service
    _productDataService = [WFProductDataService new];
    
    // init data
    
    // init UI
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setUpSelectedFeatureView {
    __weak typeof(self) weakSelf = self;
    
    _selectedFeatureView = [WFSelectedFeatureView new];
    _selectedFeatureView.closeHandler = ^{
        [weakSelf _wf_doBeforeClose];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    [self.view addSubview:_selectedFeatureView];
    [_selectedFeatureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.view).offset(WFMargin);
        make.right.equalTo(self.view).offset(-WFMargin);
        make.height.equalTo(@(kSelectedFeatureViewHeight));
    }];
}

- (void)setUpCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 8.0;
    layout.minimumInteritemSpacing = WFMargin;
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[WFProductFeatureOptionCell class] forCellWithReuseIdentifier:[WFProductFeatureOptionCell wf_reuseIdentifier]];
    [_collectionView registerClass:[WFProductFeatureHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[WFProductFeatureHeaderView wf_reuseIdentifier]];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"];
    
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_selectedFeatureView.mas_bottom).offset(WFMargin);
        make.right.left.mas_equalTo(_selectedFeatureView);
        make.bottom.equalTo(self.view).multipliedBy(WFProductDetailSelectViewRatio).offset(-kBottomBarHeight);
    }];
}

- (void)setUpBottomBar {
    UIButton *addCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addCartBtn.backgroundColor = [UIColor wf_mainColor];
    [addCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addCartBtn addTarget:self action:@selector(addCartBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addCartBtn];
    [addCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-self.view.wf_height * (1 - WFProductDetailSelectViewRatio));
        make.width.equalTo(self.view.mas_width).multipliedBy(0.5);
        make.height.equalTo(@(kBottomBarHeight * 0.5));
    }];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.backgroundColor = [UIColor wf_redColor];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(addCartBtn);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.5);
        make.height.equalTo(@(kBottomBarHeight * 0.5));
    }];
    
    UILabel *numLabel = [UILabel new];
    numLabel.text = @"数量";
    numLabel.font = [UIFont wf_pfr14];
    [self.view addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(WFMargin);
        make.bottom.equalTo(addCartBtn.mas_top);
        make.height.equalTo(@(kBottomBarHeight * 0.5));
    }];
    
    PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectZero];
    numberButton.shakeAnimation = YES;
    numberButton.minValue = 1;
    numberButton.inputFieldFont = 23;
    numberButton.increaseTitle = @"＋";
    numberButton.decreaseTitle = @"－";
    numberButton.currentNumber = 1;
    numberButton.delegate = self;
    [self.view addSubview:numberButton];
    [numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.bottom.equalTo(numLabel);
        make.width.equalTo(@(150));
        make.left.equalTo(numLabel.mas_right).offset(WFMargin);
    }];
    
}

#pragma mark - 底部按钮点击
- (void)addCartBtnClicked {
    [self _wf_doBeforeClose];
    if (![self _wf_checkAllFeatureSelected]) {
        WFShowHud(@"请选择全属性", self.view, 0.5);
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)buyBtnClicked {
    [self _wf_doBeforeClose];
    if (![self _wf_checkAllFeatureSelected]) {
        WFShowHud(@"请选择全属性", self.view, 0.5);
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
            [[ADSRouter sharedRouter] openUrlString:@"wfshop://completeOrder"];
        }];
    }
}

- (void)_wf_doBeforeClose {
    if ([self _wf_checkAllFeatureSelected] && _didSelectAllFeature) {
        _didSelectAllFeature(_features);
    }
}

- (BOOL)_wf_checkAllFeatureSelected {
    return [_productDataService isAllFeaturesSelected:_features];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _features.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _features[section].options.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    WFProductFeatureOptionCell *cell = [WFProductFeatureOptionCell new];
    cell.option = _features[indexPath.section].options[indexPath.row];
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    CGSize size = [cell systemLayoutSizeFittingSize:CGSizeMake(1.f, 1.f) withHorizontalFittingPriority:UILayoutPriorityFittingSizeLevel verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(_collectionView.wf_width, 35);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(_collectionView.wf_width, 5);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WFProductFeatureOptionCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:[WFProductFeatureOptionCell wf_reuseIdentifier] forIndexPath:indexPath];
    cell.option = _features[indexPath.section].options[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if ([kind  isEqualToString:UICollectionElementKindSectionHeader]) {
        WFProductFeatureHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[WFProductFeatureHeaderView wf_reuseIdentifier] forIndexPath:indexPath];
        headerView.feature = _features[indexPath.section];
        return headerView;
    }else {

        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
        return footerView;
    }
}

- (void)setProduct:(WFProduct *)product {
    _product = product;
    _features = _product.features;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [_features[indexPath.section].options enumerateObjectsUsingBlock:^(WFProductFeatureOption * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected && idx != indexPath.row) {
            obj.isSelected = NO;
        }
    }];
    _features[indexPath.section].options[indexPath.row].isSelected = !_features[indexPath.section].options[indexPath.row].isSelected;
    [_collectionView reloadData];
}

@end
