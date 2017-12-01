//
//  WFProductDetailVC.m
//  ADSRouter
//
//  Created by Andy on 2017/11/7.
//

#import "WFProductDetailVC.h"
#import "WFUIComponent.h"
#import "ADSRouter.h"
// Cells
#import "WFProductImageSliderCell.h"
#import "WFProductTitleCell.h"
#import "WFSelectProductDetailCell.h"
#import "WFSelectDeliverAddressCell.h"
#import "WFProductShipFeeCell.h"
#import "WFProductShopCell.h"

// service
#import "WFProductDataService.h"

// model
#import "WFProductModels.h"

#import "IDMPhotoBrowser.h"
#import "Masonry.h"

@interface WFProductDetailVC () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) WFProductDataService *productDataService;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation WFProductDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];

}

- (void)setUpUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_product) {
        return 6;
    } else {
        return 0;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", indexPath.row);
    UICollectionViewCell *cell;
    if (indexPath.row == 0) {
        cell = [_collectionView dequeueReusableCellWithReuseIdentifier:[WFProductImageSliderCell wf_reuseIdentifier] forIndexPath:indexPath];
        __weak typeof(self) weakSelf = self;
        [(WFProductImageSliderCell*)cell setImageUrls:_product.coverImgs];
        ((WFProductImageSliderCell*)cell).didClicked = ^(UIView *clickedView, NSUInteger clickedIndex) {
            IDMPhotoBrowser *photoBrowser = [[IDMPhotoBrowser alloc] initWithPhotoURLs:_product.coverImgs animatedFromView:clickedView];
            photoBrowser.usePopAnimation = YES;
            [photoBrowser setInitialPageIndex:clickedIndex];
            [weakSelf presentViewController:photoBrowser animated:YES completion:nil];
        };
    } else if (indexPath.row == 1) {
        cell = [_collectionView dequeueReusableCellWithReuseIdentifier:[WFProductTitleCell wf_reuseIdentifier] forIndexPath:indexPath];
    } else if (indexPath.row == 2) {
        cell = [_collectionView dequeueReusableCellWithReuseIdentifier:[WFSelectProductDetailCell wf_reuseIdentifier] forIndexPath:indexPath];
        ((WFSelectProductDetailCell*)cell).selectedFeatures = _product.stringlifyFeatures;
    } else if (indexPath.row == 3) {
        cell = [_collectionView dequeueReusableCellWithReuseIdentifier:[WFSelectDeliverAddressCell wf_reuseIdentifier] forIndexPath:indexPath];
        ((WFSelectDeliverAddressCell*)cell).shipAddress = _selectedAddress;
    } else if (indexPath.row == 4) {
        cell = [_collectionView dequeueReusableCellWithReuseIdentifier:[WFProductShipFeeCell wf_reuseIdentifier] forIndexPath:indexPath];
    } else if (indexPath.row == 5) {
        cell = [_collectionView dequeueReusableCellWithReuseIdentifier:[WFProductShopCell wf_reuseIdentifier] forIndexPath:indexPath];
        ((WFProductShopCell*)cell).shop = _product.shop;
        ((WFProductShopCell*)cell).didClickGoInBtn = ^{
            [[ADSRouter sharedRouter] openUrlString:[NSString stringWithFormat:@"wfshop://shop?shopId=%@", _product.shop.shopId]];
        };
        ((WFProductShopCell*)cell).didClickContactBtn = ^{
            [[ADSRouter sharedRouter] openUrlString:[NSString stringWithFormat:@"wfshop://contact_shop?shopId=%@", _product.shop.shopId]];
        };
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return CGSizeMake(self.view.wf_width, self.view.wf_width);
    } else if (indexPath.row == 1) {
        UICollectionViewCell *cell = [WFProductTitleCell new];
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        CGSize size = [cell systemLayoutSizeFittingSize:CGSizeMake(self.view.wf_width, 1.f) withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
        return size;
    } else if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4) {
        return CGSizeMake(self.view.wf_width, 60);
    } else if (indexPath.row == 5) {
        UIView *cell = [WFGetBundle(@"WFProduct") loadNibNamed:@"WFProductShopCell" owner:nil options:nil][0];
        CGSize size = [cell systemLayoutSizeFittingSize:CGSizeMake(self.view.wf_width, 1.f) withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
        return size;
    }
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2 && _didSelectProductDetail) {
        _didSelectProductDetail();
    } else if (indexPath.row == 3 && _didSelectShipAddress) {
        _didSelectShipAddress();
    }
}


#  pragma mark - Getters and Setters

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        //注册header
        [_collectionView registerClass:[WFProductImageSliderCell class] forCellWithReuseIdentifier:[WFProductImageSliderCell wf_reuseIdentifier]];
        [_collectionView registerClass:[WFProductTitleCell class] forCellWithReuseIdentifier:[WFProductTitleCell wf_reuseIdentifier]];
        [_collectionView registerClass:[WFSelectProductDetailCell class] forCellWithReuseIdentifier:[WFSelectProductDetailCell wf_reuseIdentifier]];
        [_collectionView registerClass:[WFSelectDeliverAddressCell class] forCellWithReuseIdentifier:[WFSelectDeliverAddressCell wf_reuseIdentifier]];
        [_collectionView registerClass:[WFProductShipFeeCell class] forCellWithReuseIdentifier:[WFProductShipFeeCell wf_reuseIdentifier]];
        [_collectionView registerNib:[UINib nibWithNibName:@"WFProductShopCell" bundle:WFGetBundle(@"WFProduct")] forCellWithReuseIdentifier:[WFProductShopCell wf_reuseIdentifier]];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //间隔
    }
    return _collectionView;
}

- (void)setSelectedAddress:(NSString *)selectedAddress {
    if (![_selectedAddress isEqualToString:selectedAddress]) {
        _selectedAddress = selectedAddress;
        [_collectionView reloadData];
    }
}

- (void)setProduct:(WFProduct *)product {
    if (product && ![product isEqual:_product]) {
        _product = product;
        [self.collectionView reloadData];
    }
}

@end
