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
#import "WFWechatUser.h"

#import "WFMyCouponHeaderCell.h"
#import "WFMyCouponDetailCell.h"
#import "WFMyShareCell.h"
#import "WFMyShareHeaderCell.h"
#import "WFUserSeparatorCell.h"

const CGFloat kCoverHeight = 150.f;

@interface WFMeVC () <UITableViewDelegate>

@property (nonatomic, strong) UIImageView *coverImg;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) WFUserDataService *userDataService;
@property (nonatomic, strong) NSArray<WFUserNormalFunctionGroup*> *funcGroups;

@property (nonatomic, strong) WFWechatUser *wechatUser;
//@property (nonatomic, strong) WFUser *user;


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
        [[WFUserCenter sharedCenter] getCurrentUser:^(WFWechatUser *user) {
            weakSelf.wechatUser = user;
            weakSelf.tableView.sectionInfos = [weakSelf getSectionInfo];
            [weakSelf.tableView reloadData];
        }];
    } else {
        weakSelf.wechatUser = nil;
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
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.contentInset = UIEdgeInsetsMake(kCoverHeight - 100, 0, 0, 0);
    _tableView.sectionInfos = [self getSectionInfo];
    _tableView.tableFooterView = [UIView new];
    [_tableView registerClass:[WFUserSeparatorCell class] forCellReuseIdentifier:[WFUserSeparatorCell wf_reuseIdentifier]];
    _coverImg = [UIImageView new];
    [self.view insertSubview:_coverImg belowSubview:_tableView];
    _coverImg.frame =CGRectMake(0, 0, self.view.wf_width, kCoverHeight);
    _coverImg.contentMode = UIViewContentModeScaleAspectFill;
    [_coverImg setImage:[UIImage imageNamed:@"background" inBundle:WFGetBundle(@"WFUser") compatibleWithTraitCollection:nil]];
}

- (NSArray<ASSectionInfo*>*)getSectionInfo {
    NSMutableArray<ASSectionInfo*> *sectionInfoArr = [NSMutableArray array];
    
    [sectionInfoArr addObject:[self userSection]];
    
    [sectionInfoArr addObject:[self orderSection]];
    
    [sectionInfoArr addObject:[self couponSection]];
    
    [sectionInfoArr addObject:[self shareSection]];
    
    
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

- (ASSectionInfo *)userSection {
    __weak typeof(self) weakSelf = self;
    ASCellInfo *userCell = [ASCellInfo new];
    userCell.cellReuseIdentifier = [WFUserCell wf_reuseIdentifier];
    userCell.cellClass = [WFUserCell class];
    userCell.fillInData = ^(UITableView *tableView, NSIndexPath *indexPath, __kindof UITableViewCell *cell, id data) {
        ((WFUserCell*)cell).userAvatarClicked = ^{
            
        };
        ((WFUserCell*)cell).wechatUser = weakSelf.wechatUser;
        ((WFUserCell*)cell).doLogin = ^{
            [[ADSRouter sharedRouter] openUrlString:@"wfshop://login"];
        };
    };
    ASSectionInfo *userSection = [ASSectionInfo new];
    userSection.cellInfos = @[userCell];
    return userSection;
}

- (ASSectionInfo*)orderSection {
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
    
    ASCellInfo *separatorCell = [ASCellInfo new];
    separatorCell.cellReuseIdentifier = [WFUserSeparatorCell wf_reuseIdentifier];
    separatorCell.cellClass = [WFUserSeparatorCell class];
    
    ASSectionInfo *orderSection = [ASSectionInfo new];
    orderSection.cellInfos = @[allOrderCell, detailOrderCell, separatorCell];
    return orderSection;
}

- (ASSectionInfo*)couponSection {
    ASCellInfo *header = [ASCellInfo new];
    header.cellReuseIdentifier = [WFMyCouponHeaderCell wf_reuseIdentifier];
    header.cellClass = [WFMyCouponHeaderCell class];
    header.didSelected = ^(UITableView *tableView, NSIndexPath *indexPath, id data) {
        NSLog(@"查看全部优惠券");
    };
    ASCellInfo *couponDetail = [ASCellInfo new];
    couponDetail.cellReuseIdentifier = [WFMyCouponDetailCell wf_reuseIdentifier];
    couponDetail.cellClass = [WFMyCouponDetailCell class];
    
    ASCellInfo *separatorCell = [ASCellInfo new];
    separatorCell.cellReuseIdentifier = [WFUserSeparatorCell wf_reuseIdentifier];
    separatorCell.cellClass = [WFUserSeparatorCell class];
    
    ASSectionInfo *couponSection = [ASSectionInfo new];
    couponSection.cellInfos = @[header, couponDetail, separatorCell];

    return couponSection;
}

- (ASSectionInfo*)shareSection {
    ASCellInfo *shareHeader = [ASCellInfo new];
    shareHeader.cellReuseIdentifier = [WFMyShareHeaderCell wf_reuseIdentifier];
    shareHeader.cellClass = [WFMyShareHeaderCell class];
    
    ASCellInfo *dailyCell = [ASCellInfo new];
    dailyCell.cellReuseIdentifier  = [WFMyShareCell wf_reuseIdentifier];
    dailyCell.cellClass = [WFMyShareCell class];
    dailyCell.fillInData = ^(UITableView *tableView, NSIndexPath *indexPath, __kindof UITableViewCell *cell, id data) {
        ((WFMyShareCell*)cell).type = WFShareCellTypeDaily;
        ((WFMyShareCell*)cell).detail = @"102";
    };
    dailyCell.didSelected = ^(UITableView *tableView, NSIndexPath *indexPath, id data) {
        [[ADSRouter sharedRouter] openUrlString:@"wfshop://shareIncome?shareType=0"];
    };
    ASCellInfo *totalCell = [ASCellInfo new];
    totalCell.cellReuseIdentifier  = [WFMyShareCell wf_reuseIdentifier];
    totalCell.cellClass = [WFMyShareCell class];
    totalCell.fillInData = ^(UITableView *tableView, NSIndexPath *indexPath, __kindof UITableViewCell *cell, id data) {
        ((WFMyShareCell*)cell).type = WFShareCellTypeTotal;
        ((WFMyShareCell*)cell).detail = @"1358";
    };
    totalCell.didSelected = ^(UITableView *tableView, NSIndexPath *indexPath, id data) {
        [[ADSRouter sharedRouter] openUrlString:@"wfshop://shareIncome?shareType=1"];
    };
    
    ASCellInfo *unshareCell = [ASCellInfo new];
    unshareCell.cellReuseIdentifier  = [WFMyShareCell wf_reuseIdentifier];
    unshareCell.cellClass = [WFMyShareCell class];
    unshareCell.fillInData = ^(UITableView *tableView, NSIndexPath *indexPath, __kindof UITableViewCell *cell, id data) {
        ((WFMyShareCell*)cell).type = WFShareCellTypeUnshare;
        ((WFMyShareCell*)cell).detail = @"2";
    };
    unshareCell.didSelected = ^(UITableView *tableView, NSIndexPath *indexPath, id data) {
        [[ADSRouter sharedRouter] openUrlString:@"wfshop://shareIncome?shareType=2"];
    };
    
    ASCellInfo *separatorCell = [ASCellInfo new];
    separatorCell.cellReuseIdentifier = [WFUserSeparatorCell wf_reuseIdentifier];
    separatorCell.cellClass = [WFUserSeparatorCell class];
    
    ASSectionInfo *shareSection = [ASSectionInfo new];

    shareSection.cellInfos = @[shareHeader, dailyCell, totalCell, unshareCell, separatorCell];
    return shareSection;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _coverImg.frame =CGRectMake(0, 0, self.view.wf_width, - _tableView.contentOffset.y + 100);
}

@end
