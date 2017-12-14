//
//  WFCartVC.m
//  ADSRouter
//
//  Created by Andy on 2017/11/22.
//

#import "WFCartVC.h"
#import "WFCartItemCell.h"
#import "WFUIComponent.h"
#import "ADSRouter.h"
#import "WFCartModels.h"
#import "WFCartDataService.h"
#import "WFCartHeaderView.h"
#import "WFHelpers.h"
#import "XXNibConvention.h"
#import <objc/runtime.h>
#import "BeeHive.h"
#import "WFUserProtocol.h"

@interface WFCartVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<WFCartItemGroup*> *cartItemGroups;

@property (nonatomic, strong) WFCartDataService *cartDataService;

@property (weak, nonatomic) IBOutlet UIButton *checkAllBtn;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkoutBtn;

@property (nonatomic, assign) BOOL isAllBtnChecked;

@property (nonatomic, assign) CGFloat totalAmount;

@property (nonatomic, strong) id<WFUserProtocol> userService;

@end

@implementation WFCartVC

ADS_REQUEST_MAPPING(WFCartVC, "wfshop://cart")
ADS_STORYBOARD_IN_BUNDLE("WFCart", "WFCartVC", "WFCart")
ADS_HIDE_BOTTOM_BAR

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setEverthingHidden:![self.userService isLogined]];
}

- (void)setEverthingHidden:(BOOL)hidden {
    [_tableView setHidden:hidden];
    [_checkAllBtn setHidden:hidden];
    [_hintLabel setHidden:hidden];
    [_totalAmountLabel setHidden:hidden];
    [_checkoutBtn setHidden:hidden];
}

- (void)loadData {
    __weak typeof(self) weakSelf = self;
    _cartDataService = [WFCartDataService new];
    [_cartDataService getCartDataWithUserId:@"" callback:^(NSArray<WFCartItemGroup *> *cartGroups) {
        weakSelf.cartItemGroups = [cartGroups mutableCopy];
        [weakSelf.tableView reloadData];
    }];
}

- (void)setUpUI {
    self.title = @"购物车";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _hintLabel.font = [UIFont wf_pfr14];
    _totalAmountLabel.font = [UIFont wf_pfr13];
    _checkoutBtn.backgroundColor = [UIColor wf_mainColor];
}

- (IBAction)checkAllBtnClicked:(id)sender {
    _isAllBtnChecked = !_isAllBtnChecked;
    if (_isAllBtnChecked) {
        [_checkAllBtn setImage:[[UIImage imageNamed:@"radio-checked" inBundle:WFGetBundle(@"WFCart") compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    } else {
        [_checkAllBtn setImage:[UIImage imageNamed:@"radio" inBundle:WFGetBundle(@"WFCart") compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    }
    [self checkOrUncheck:_isAllBtnChecked];
    [self updateTotalAmount];
    [self.tableView reloadData];
}

- (void)checkOrUncheck:(BOOL)check {
    [_cartItemGroups enumerateObjectsUsingBlock:^(WFCartItemGroup * _Nonnull group, NSUInteger idx, BOOL * _Nonnull stop) {
        group.isSelected = check;
        [group.cartItems enumerateObjectsUsingBlock:^(WFCartItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
            item.isSelected = check;
        }];
    }];
}


- (void)updateTotalAmount {
    self.totalAmount = [_cartDataService calculateTotalAmount:_cartItemGroups];
}

- (IBAction)checkoutBtnClicked:(id)sender {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _cartItemGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cartItemGroups[section].cartItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 116.f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WFCartItemCell *cell = [tableView dequeueReusableCellWithIdentifier:[WFCartItemCell wf_reuseIdentifier] forIndexPath:indexPath];
    __weak typeof(self) weakSelf = self;
    cell.cartItem = _cartItemGroups[indexPath.section].cartItems[indexPath.row];
    cell.didCheckOrUncheck = ^(BOOL check) {
        weakSelf.cartItemGroups[indexPath.section].cartItems[indexPath.row].isSelected = check;
        [weakSelf updateTotalAmount];
        [weakSelf.tableView reloadData];
    };
    cell.didChangeAmount = ^{
        [weakSelf updateTotalAmount];
    };
    cell.didWantToDel = ^{
        WFAskSomeThing(@"", @"是否删除该商品", weakSelf, ^{
            [weakSelf.cartItemGroups[indexPath.section].cartItems removeObjectAtIndex:indexPath.row];
            if (weakSelf.cartItemGroups[indexPath.section].cartItems.count == 0) {
                [weakSelf.cartItemGroups removeObjectAtIndex:indexPath.section];
            }
            [weakSelf updateTotalAmount];
            [weakSelf.tableView reloadData];
        }, nil);
    };
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    __weak typeof(self) weakSelf = self;
    WFCartHeaderView *headerView = [WFCartHeaderView wf_viewFromXibInBundle:WFGetBundle(@"WFCart")];
    headerView.cartGroup = _cartItemGroups[section];
    headerView.didCheckOrUncheck = ^(BOOL check) {
        [weakSelf.cartItemGroups[section].cartItems enumerateObjectsUsingBlock:^(WFCartItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
            item.isSelected = check;
        }];
        weakSelf.cartItemGroups[section].isSelected = check;
        [weakSelf updateTotalAmount];
        [weakSelf.tableView reloadData];
    };
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1.f;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)setTotalAmount:(CGFloat)totalAmount {
    _totalAmount = totalAmount;
    _totalAmountLabel.text = [NSString stringWithFormat:@"%.2f", _totalAmount];
}

- (IBAction)doLogin:(id)sender {
    [[ADSRouter sharedRouter] openUrlString:@"wfshop://login"];
}

- (id<WFUserProtocol>)userService {
    if (!_userService) {
        _userService = [[BeeHive shareInstance] createService:@protocol(WFUserProtocol)];
    }
    return _userService;
}

@end
