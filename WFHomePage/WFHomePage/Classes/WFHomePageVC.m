//
//  WFHomePageVC.m
//  WFShop
//
//  Created by Andy on 2017/10/12.
//  Copyright © 2017年 andy. All rights reserved.
//

#import "WFHomePageVC.h"
#import "WFHomePageProtocol.h"
#import "WFHomePageRow.h"
#import "Masonry.h"
#import "ADSRouter.h"
#import "UINavigationBar+WFClearBackground.h"
#import "WFHomePageDataService.h"
#import "WFHomePageCellFactory.h"
#import "UIView+WFReuseIdentifier.h"
#import "UIColor+WFColor.h"
#import "MJRefresh.h"
#import "WFHelpers.h"


#define WFSCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define WFSCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

@interface WFHomePageVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<WFHomePageRow*> *rows;
@property (nonatomic, strong) WFHomePageDataService *homePageDataService;

@end

@implementation WFHomePageVC

ADS_REQUEST_MAPPING(WFHomePageVC, "wfshop://shop")
ADS_PARAMETER_MAPPING(WFHomePageVC, shopId, "shopId")
ADS_HIDE_BOTTOM_BAR

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    
    [self loadData];
}

- (void)loadData {
    __weak typeof(self) weakSelf = self;
    if (_shopId && ![_shopId isEqualToString:@""]) {
        [self.homePageDataService getShopHomePageRowsWithShopId:_shopId callback:^(NSArray<WFHomePageRow *> *rows) {
            weakSelf.rows = rows;
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView reloadData];
        }];
    } else {
        [self.homePageDataService getHomePageRows:^(NSArray<WFHomePageRow *> *rows) {
            weakSelf.rows = rows;
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView reloadData];
        }];
    }
}

- (void)setUpUI {
    _tableView = [UITableView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor wf_mainBackgroundColor];
    __weak typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    label.text = @"到底了";
    label.textColor = [UIColor wf_placeHolderColor];
    label.textAlignment = NSTextAlignmentCenter;
    _tableView.tableFooterView = label;
    
    [self setUpNavi];
}

- (void)setUpNavi {
    NSString *placeHolder = @"";
    if (_shopId && ![_shopId isEqualToString:@""]) {
        UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"category" inBundle:WFGetBundle(@"WFHomePage") compatibleWithTraitCollection:nil] style:UIBarButtonItemStylePlain target:self action:@selector(categoryClicked)];
        self.navigationItem.rightBarButtonItem = barBtn;
        placeHolder = @"搜索店铺内商品";
    } else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"qr"] style:UIBarButtonItemStyleDone target:self action:@selector(qrBtnClicked)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStyleDone target:self action:@selector(searchBtnClicked)];
        placeHolder = @"搜索";
    }
    UILabel *searchField = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    searchField.text = placeHolder;
    searchField.textColor = [UIColor wf_placeHolderColor];
    searchField.textAlignment = NSTextAlignmentLeft;
    searchField.userInteractionEnabled = YES;
    [searchField addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchBtnClicked)]];
    self.navigationItem.titleView = searchField;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rows.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [WFHomePageCellFactory cellWithRowData:_rows[indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return WFSCREEN_WIDTH * _rows[indexPath.row].ratio;
}

- (void)qrBtnClicked {
    NSLog(@"开始跳转:%f", [NSDate date].timeIntervalSince1970);
    [[ADSRouter sharedRouter] openUrlString:@"wfshop://qrscan"];
}

- (void)searchBtnClicked {
    [[ADSRouter sharedRouter] openUrlString:@"wfshop://search"];
}

- (void)categoryClicked {
    [[ADSRouter sharedRouter] openUrlString:[NSString stringWithFormat:@"wfshop://category?shopId=%@", _shopId]];
}

- (WFHomePageDataService*)homePageDataService {
    if (!_homePageDataService) {
        _homePageDataService = [WFHomePageDataService new];
    }
        return _homePageDataService;
}

@end
