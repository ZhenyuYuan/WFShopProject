//
//  WFSearchVC.m
//  ADSRouter
//
//  Created by Andy on 2017/10/17.
//

#import "WFSearchVC.h"
#import "WFSearchHistoryCell.h"
#import "WFSearchFooterView.h"
#import "WFHistorySearchItem.h"
#import "ADSRouter.h"
#import "WFUIComponent.h"

@interface WFSearchVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIBarButtonItem *searchBtn;
@property (nonatomic, strong) UITextField *searchField;

@property (nonatomic, strong) NSArray *historyItems;

@end


@implementation WFSearchVC

ADS_REQUEST_MAPPING(WFSearchVC, "wfshop://search")
ADS_STORYBOARD_IN_BUNDLE("WFSearch", "WFSearchVC", "WFSearch")
ADS_SHOWSTYLE_PUSH_WITHOUT_ANIMATION
ADS_HIDE_BOTTOM_BAR

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self loadData];
}

- (void)setUpUI {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self setUpNavi];
}

- (void)loadData {
    WFHistorySearchItem *item1 = [WFHistorySearchItem new];
    item1.query = @"魅族";
    WFHistorySearchItem *item2 = [WFHistorySearchItem new];
    item2.query = @"小米";
    self.historyItems = @[item1, item2];
    
    [_tableView reloadData];
}

- (void)setUpNavi {
    self.navigationItem.hidesBackButton = YES;
    _searchField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    _searchField.placeholder = @"搜索";
    self.navigationItem.titleView = _searchField;
    
    self.navigationItem.leftBarButtonItem = nil;
    
    _searchBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = _searchBtn;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _historyItems.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WFSearchHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[WFSearchHistoryCell wf_reuseIdentifier] forIndexPath:indexPath];
    cell.item = _historyItems[indexPath.row];
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    WFSearchFooterView *footerView = [[WFSearchFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.wf_width, 36.f)];
    footerView.didClickDelBtn = ^{
        NSLog(@"clear history");
    };
    [footerView setNeedsLayout];
    [footerView layoutIfNeeded];

    return footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)search {
    [self.navigationController popViewControllerAnimated:NO];
}

@end
