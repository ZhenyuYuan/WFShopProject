//
//  WFSelectOrderShipAddress.m
//  ADSRouter
//
//  Created by Andy on 2017/12/15.
//

#import "WFSelectOrderShipAddressVC.h"
#import "WFUIComponent.h"
#import "WFSelectOrderAddressCell.h"
#import "WFOrderAddressService.h"
#import "WFAddAddressVC.h"
#import "WFOrderShipAddress.h"

@interface WFSelectOrderShipAddressVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<WFOrderShipAddress*> *addressArr;

@property (nonatomic, strong) WFOrderAddressService *addressService;

@end

@implementation WFSelectOrderShipAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)setUpUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"收货地址";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStylePlain target:self action:@selector(addNewAddress)];
    self.navigationItem.rightBarButtonItem = addBtn;
}

- (void)loadData {
    _addressArr = nil;
    __weak typeof(self) weakSelf = self;
    [self.addressService getAddress:^(NSArray<WFOrderShipAddress *> *addressArr) {
        weakSelf.addressArr = addressArr;
        [weakSelf.tableView reloadData];
        [weakSelf.addressArr enumerateObjectsUsingBlock:^(WFOrderShipAddress * _Nonnull address, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([weakSelf.selectedAddress.addressId isEqualToString:address.addressId]) {
                [weakSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
            }
        }];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _addressArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WFSelectOrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:[WFSelectOrderAddressCell wf_reuseIdentifier] forIndexPath:indexPath];
    cell.address = _addressArr[indexPath.row];
    return cell;
}

- (NSArray<UITableViewRowAction *> * _Nullable)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    UITableViewRowAction *delAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [weakSelf.addressService delAddress:weakSelf.addressArr[indexPath.row] callback:^(BOOL success) {
            WFShowHud( success ? @"删除成功" : @"删除失败", weakSelf.view, 1);
            [weakSelf loadData];
        }];
    }];
    return @[delAction];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_didSelectShipAddress) {
        _didSelectShipAddress(_addressArr[indexPath.row]);
    }
}

- (void)addNewAddress {
    WFAddAddressVC *vc = [[UIStoryboard storyboardWithName:@"WFOrder" bundle:WFGetBundle(@"WFOrder")] instantiateViewControllerWithIdentifier:@"WFAddAddressVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (WFOrderAddressService*)addressService {
    if (!_addressService) {
        _addressService = [WFOrderAddressService new];
    }
    return _addressService;
}

@end
