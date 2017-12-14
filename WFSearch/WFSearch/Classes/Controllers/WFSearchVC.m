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
#import "WFHistorySearchDataService.h"

@interface WFSearchVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIBarButtonItem *searchBtn;
@property (nonatomic, strong) UITextField *searchField;

@property (nonatomic, strong) NSMutableArray *historyItems;

@property (nonatomic, strong) WFHistorySearchDataService *historySearchDataService;

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
    __weak typeof(self) weakSelf = self;
    [self.historySearchDataService getHistorySearchItems:^(NSArray<WFHistorySearchItem *> *items) {
        weakSelf.historyItems = [items mutableCopy];
        [weakSelf.tableView reloadData];
    }];
}

- (void)setUpNavi {
    self.navigationItem.hidesBackButton = YES;
    _searchField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    _searchField.placeholder = @"搜索";
    _searchField.keyboardType = UIKeyboardTypeWebSearch;
    [_searchField addTarget:self action:@selector(goSearch) forControlEvents:UIControlEventEditingDidEndOnExit];
    self.navigationItem.titleView = _searchField;
    
    self.navigationItem.leftBarButtonItem = nil;
    
    _searchBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(exit)];
    self.navigationItem.rightBarButtonItem = _searchBtn;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_searchField becomeFirstResponder];
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
    __weak typeof(self) weakSelf = self;
    cell.didClickDelBtn = ^{
        [weakSelf.historySearchDataService deleteHistorySearchItem:weakSelf.historyItems[indexPath.row]];
        [weakSelf.historyItems removeObjectAtIndex:indexPath.row];
        [weakSelf.tableView reloadData];
    };
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    __weak typeof(self) weakSelf = self;
    WFSearchFooterView *footerView = [[WFSearchFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.wf_width, 36.f)];
    footerView.didClickDelBtn = ^{
        [weakSelf.historySearchDataService deleteAll];
        weakSelf.historyItems = nil;
        [weakSelf.tableView reloadData];
    };
    [footerView setNeedsLayout];
    [footerView layoutIfNeeded];
    return footerView;
}

- (void)exit {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)goSearch {
    NSString *query = _searchField.text;
    if ([query isEqualToString:@""]) {
        return;
    }
    [_searchField resignFirstResponder];
    [self.historySearchDataService addHistorySearch:query];
    [[ADSRouter sharedRouter] openUrlString:[NSString stringWithFormat:@"wfshop://searchList?query=%@", query]];
}

- (WFHistorySearchDataService*)historySearchDataService {
    if (!_historySearchDataService) {
        _historySearchDataService = [WFHistorySearchDataService new];
    }
    return _historySearchDataService;
}

@end
