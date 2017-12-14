//
//  WFMeVC.m
//  ADSRouter
//
//  Created by Andy on 2017/11/17.
//

#import "WFMeVC.h"
#import "WFUIComponent.h"

// Cells
#import "WFUserOrderCell.h"
#import "WFUserOrderDetailCell.h"
#import "WFUserNormalFunctionCell.h"
#import "WFUserCell.h"
#import "WFUserDataService.h"
#import "ADSRouter.h"
#import "WFUserNormalFunctionGroup.h"
#import "UITableView+ASDataDrivenLayout.h"
#import "WFUserNormalFunction.h"
#import "WFUserCenter.h"

const CGFloat kCoverHeight = 150.f;

@interface WFMeVC () <UITableViewDelegate>

@property (nonatomic, strong) UIImageView *coverImg;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) WFUserDataService *userDataService;
@property (nonatomic, strong) NSArray<WFUserNormalFunctionGroup*> *funcGroups;

@property (nonatomic, strong) WFUser *user;


@end

@implementation WFMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)loadData {
    __weak typeof(self) weakSelf = self;
    _userDataService = [WFUserDataService new];
    [_userDataService getFunctions:^(NSArray<WFUserNormalFunctionGroup *> *funcGroups) {
        weakSelf.funcGroups = funcGroups;
        weakSelf.tableView.sectionInfos = [weakSelf getSectionInfo];
        [weakSelf.tableView reloadData];
    }];
    
    if ([[WFUserCenter sharedCenter] isUserLogined]) {
        [_userDataService getUser:^(WFUser *user) {
            weakSelf.user = user;
            weakSelf.tableView.sectionInfos = [weakSelf getSectionInfo];
            [weakSelf.tableView reloadData];
        }];
    }
}

- (void)setUpUI {
    self.title = @"我的";
    
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.estimatedRowHeight = 100.f;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.enableDataDrivenLayout = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(kCoverHeight - 100, 0, 0, 0);
    _tableView.sectionInfos = [self getSectionInfo];
    _tableView.tableFooterView = [UIView new];
    _coverImg = [UIImageView new];
    [self.view insertSubview:_coverImg belowSubview:_tableView];
    _coverImg.frame =CGRectMake(0, 0, self.view.wf_width, kCoverHeight);
    _coverImg.contentMode = UIViewContentModeScaleAspectFill;
    [_coverImg setImage:[UIImage imageNamed:@"background" inBundle:WFGetBundle(@"WFUser") compatibleWithTraitCollection:nil]];
}

- (NSArray<ASSectionInfo*>*)getSectionInfo {
    NSMutableArray<ASSectionInfo*> *sectionInfoArr = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    ASCellInfo *userCell = [ASCellInfo new];
    userCell.cellReuseIdentifier = [WFUserCell wf_reuseIdentifier];
    userCell.cellClass = [WFUserCell class];
    userCell.fillInData = ^(UITableView *tableView, NSIndexPath *indexPath, __kindof UITableViewCell *cell, id data) {
        ((WFUserCell*)cell).userAvatarClicked = ^{
            
        };
        ((WFUserCell*)cell).user = weakSelf.user;
        ((WFUserCell*)cell).doLogin = ^{
            [[ADSRouter sharedRouter] openUrlString:@"wfshop://login"];
        };
    };
    ASSectionInfo *userSection = [ASSectionInfo new];
    userSection.cellInfos = @[userCell];
    [sectionInfoArr addObject:userSection];
    
    ASCellInfo *allOrderCell = [ASCellInfo new];
    allOrderCell.cellReuseIdentifier = [WFUserOrderCell wf_reuseIdentifier];
    allOrderCell.cellClass = [WFUserOrderCell class];
    allOrderCell.didSelected = ^(UITableView *tableView, NSIndexPath *indexPath, id data) {
        [[ADSRouter sharedRouter] openUrlString:@"wfshop://showOrders?selected_idx=0"];
    };
    ASCellInfo *detailOrderCell = [ASCellInfo new];
    detailOrderCell.cellReuseIdentifier = [WFUserOrderDetailCell wf_reuseIdentifier];
    detailOrderCell.cellClass = [WFUserOrderDetailCell class];
    detailOrderCell.fillInData = ^(UITableView *tableView, NSIndexPath *indexPath, __kindof UITableViewCell *cell, id data) {
        ((WFUserOrderDetailCell*)cell).showUnpayOrders = ^{
            [[ADSRouter sharedRouter] openUrlString:@"wfshop://showOrders?selected_idx=1"];
        };
        ((WFUserOrderDetailCell*)cell).showUncheckOrders = ^{
            [[ADSRouter sharedRouter] openUrlString:@"wfshop://showOrders?selected_idx=2"];
        };
        ((WFUserOrderDetailCell*)cell).showUncommentOrders = ^{
            [[ADSRouter sharedRouter] openUrlString:@"wfshop://showOrders?selected_idx=3"];
        };
        ((WFUserOrderDetailCell*)cell).showRepairOrders = ^{
            [[ADSRouter sharedRouter] openUrlString:@"wfshop://showOrders?selected_idx=4"];
        };
    };
    ASSectionInfo *orderSection = [ASSectionInfo new];
    orderSection.cellInfos = @[allOrderCell, detailOrderCell];
    [sectionInfoArr addObject:orderSection];
    
    for (WFUserNormalFunctionGroup *funcGroup in _funcGroups) {
        ASSectionInfo *sectionInfo = [ASSectionInfo new];
        NSMutableArray<ASCellInfo*> *cellInfoArr = [NSMutableArray array];
        for (WFUserNormalFunction *func in funcGroup.functions) {
            ASCellInfo *cellInfo = [ASCellInfo new];
            cellInfo.cellReuseIdentifier = [WFUserNormalFunctionCell wf_reuseIdentifier];
            cellInfo.data = func;
            cellInfo.cellClass = [WFUserNormalFunctionCell class];
            cellInfo.fillInData = ^(UITableView *tableView, NSIndexPath *indexPath, __kindof UITableViewCell *cell, id data) {
                ((WFUserNormalFunctionCell*)cell).function = data;
            };
            cellInfo.didSelected = ^(UITableView *tableView, NSIndexPath *indexPath, id data) {
                NSString *actionUrl = ((WFUserNormalFunction*)data).url;
                [[ADSRouter sharedRouter] openUrlString:actionUrl];
            };
            [cellInfoArr addObject:cellInfo];
        }
        sectionInfo.cellInfos = cellInfoArr.copy;
        [sectionInfoArr addObject:sectionInfo];
    }
    return [sectionInfoArr copy];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _coverImg.frame =CGRectMake(0, 0, self.view.wf_width, - _tableView.contentOffset.y + 100);
}

@end
