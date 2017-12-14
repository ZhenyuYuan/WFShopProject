//
//  DCCommodityViewController.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
#import <objc/runtime.h>
#import "WFCatagoryVC.h"

// Controllers

// Models
#import "WFCategoryItem.h"

// Views
#import "WFCategoryCell.h"
#import "WFThirdLevelCategoryCell.h"
#import "WFCategoryHeadView.h"

// Vendors

// Categories
#import "UIColor+WFColor.h"
#import "UIView+WFReuseIdentifier.h"
// Others
#import "ADSRouter.h"
#import "WFCatergoryDataService.h"
#import "Masonry.h"

const CGFloat kTableViewRatio = 0.3;

@interface WFCatagoryVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* collectionViw */
@property (strong , nonatomic)UICollectionView *collectionView;

/* 左边数据 */
@property (strong , nonatomic)NSMutableArray<WFCategoryItem *> *categoryItems;

@property (nonatomic, assign) NSInteger selectedFirstCategory;

@property (nonatomic, strong) WFCatergoryDataService *categoryDataService;
@end

@implementation WFCatagoryVC


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 3; //X
        layout.minimumLineSpacing = 5;  //Y
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
    }
    return _collectionView;
}


#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if (self.navigationController.navigationBar.barTintColor == RGBA(231, 23, 37, 1.0))return;
//    self.navigationController.navigationBar.barTintColor = RGBA(231, 23, 37, 1.0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI   ];
    
    [self setUpData];
}

- (void)setUpUI {
    [self setUpNav];
    
    self.view.backgroundColor = [UIColor wf_mainBackgroundColor];
    
    [self setUpTableView];
    
    [self setUpCollectionView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - initizlize
- (void)setUpTableView {
    _tableView = [UITableView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    [_tableView registerClass:[WFCategoryCell class] forCellReuseIdentifier:[WFCategoryCell wf_reuseIdentifier]];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(kTableViewRatio);
    }];
}

- (void)setUpCollectionView {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = 3; //X
    layout.minimumLineSpacing = 5;  //Y
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    //注册Cell
    [_collectionView registerClass:[WFThirdLevelCategoryCell class] forCellWithReuseIdentifier:[WFThirdLevelCategoryCell wf_reuseIdentifier]];
    //注册Header
    [_collectionView registerClass:[WFCategoryHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[WFCategoryHeadView wf_reuseIdentifier]];
    
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(1-kTableViewRatio);
    }];
}

#pragma mark - 加载数据
- (void)setUpData {
    _categoryDataService = [WFCatergoryDataService new];
    
    _categoryItems = [NSMutableArray array];
    
    typeof(self) weakSelf = self;
    [_categoryDataService getCategoryData:^(NSArray<WFCategoryItem *> *categoryItems) {
        [weakSelf.categoryItems addObjectsFromArray:categoryItems];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [weakSelf.collectionView reloadData];
    }]; 
}


#pragma mark - 设置导航条
- (void)setUpNav {
    UILabel *searchField = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    searchField.text = @"搜索";
    searchField.textColor = [UIColor wf_placeHolderColor];
    searchField.textAlignment = NSTextAlignmentLeft;
    searchField.userInteractionEnabled = YES;
    [searchField addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchBtnClicked)]];
    self.navigationItem.titleView = searchField;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"qr"] style:UIBarButtonItemStyleDone target:self action:@selector(qrBtnClicked)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStyleDone target:self action:@selector(searchBtnClicked)];
}

- (void)qrBtnClicked {
    [[ADSRouter sharedRouter] openUrlString:@"wfshop://qrscan"];
}

- (void)searchBtnClicked {
    [[ADSRouter sharedRouter] openUrlString:@"wfshop://search"];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _categoryItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WFCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[WFCategoryCell wf_reuseIdentifier] forIndexPath:indexPath];
    cell.categoryItem = _categoryItems[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedFirstCategory = indexPath.row;
    [self.collectionView reloadData];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (!_categoryItems || _categoryItems.count == 0) return 0;
    
    return _categoryItems[_selectedFirstCategory].children.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //if (!_categoryItems || _categoryItems.count == 0 || _categoryItems[_selectedFirstCategory].children.count == 0)
    return _categoryItems[_selectedFirstCategory].children[section].children.count;
}

#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WFThirdLevelCategoryCell *gridcell = [collectionView dequeueReusableCellWithReuseIdentifier:[WFThirdLevelCategoryCell wf_reuseIdentifier] forIndexPath:indexPath];
    gridcell.categoryItem = _categoryItems[_selectedFirstCategory].children[indexPath.section].children[indexPath.row];
    return gridcell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        WFCategoryHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[WFCategoryHeadView wf_reuseIdentifier] forIndexPath:indexPath];
        headerView.categoryItem = _categoryItems[_selectedFirstCategory].children[indexPath.section];
        reusableview = headerView;
    }
    return reusableview;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((CGRectGetWidth(_collectionView.frame)- 6)/3, (CGRectGetWidth(_collectionView.frame)- 6)/3 + 20);
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(CGRectGetWidth(self.view.bounds), 25);
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *catagoryName = _categoryItems[_selectedFirstCategory].children[indexPath.section].children[indexPath.row].name;
    NSLog(@"clicked:%@", catagoryName);
    NSString *urlString = [@"wfshop://searchList?catagory=" stringByAppendingString:catagoryName];
    [[ADSRouter sharedRouter] openUrlString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

#pragma 设置StatusBar为白色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
