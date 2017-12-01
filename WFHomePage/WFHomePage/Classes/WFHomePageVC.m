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


#define WFSCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define WFSCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

@interface WFHomePageVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<WFHomePageRow*> *rows;
@property (nonatomic, strong) WFHomePageDataService *homePageDataService;

@end

@implementation WFHomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    
    __weak typeof(self) weakSelf = self;
    [self.homePageDataService getHomePageRows:^(NSArray<WFHomePageRow *> *rows) {
        weakSelf.rows = rows;
        [weakSelf.tableView reloadData];
    }];
}

- (void)setUpUI {
    self.title = @"首页";
    
    _tableView = [UITableView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor wf_mainBackgroundColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    label.text = @"到底了";
    label.textColor = [UIColor wf_placeHolderColor];
    label.textAlignment = NSTextAlignmentCenter;
    _tableView.tableFooterView = label;
    
    [self setUpNavi];
}

- (void)setUpNavi {

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)qrBtnClicked {
    [[ADSRouter sharedRouter] openUrlString:@"wfshop://qrscan"];
}

- (void)searchBtnClicked {
    [[ADSRouter sharedRouter] openUrlString:@"wfshop://search"];
}

- (WFHomePageDataService*)homePageDataService {
    if (!_homePageDataService) {
        _homePageDataService = [WFHomePageDataService new];
    }
        return _homePageDataService;
}

@end
