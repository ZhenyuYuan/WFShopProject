//
//  WFShipAddressSelectVC.m
//  ADSRouter
//
//  Created by Andy on 2017/11/13.
//

#import "WFShipAddressSelectVC.h"
#import "WFShipAddressCell.h"
#import "WFUIComponent.h"
#import "UIImageView+WebCache.h"
#import "WFProductModels.h"
#import "WFProductDataService.h"
@interface WFShipAddressSelectVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addNewAddressBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (nonatomic, strong) NSArray<WFProductShipAddress*> *addressArr;

@property (nonatomic, strong) WFProductDataService *productDataService;

@end

@implementation WFShipAddressSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
   
    [self loadData];
}

- (void)setUpUI {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 64.f;
    
    
    _addNewAddressBtn.backgroundColor = [UIColor wf_mainColor];
    [_closeBtn setTitle:@"" forState:UIControlStateNormal];
    [_closeBtn setImage:[UIImage imageNamed:@"close" inBundle:[self _bundle] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
}

- (void)loadData {
    __weak typeof(self) weakSelf = self;
    _productDataService = [WFProductDataService new];
    [_productDataService getShipAddressWithUserId:@"" callback:^(NSArray<WFProductShipAddress *> *addressArr) {
        weakSelf.addressArr = addressArr;
        [weakSelf.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _addressArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WFShipAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:[WFShipAddressCell wf_reuseIdentifier] forIndexPath:indexPath];
    cell.address = _addressArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.didSelectAddress) {
            weakSelf.didSelectAddress(weakSelf.addressArr[indexPath.row]);
        }
    }];
}

- (IBAction)closeBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSBundle*)_bundle {
    return [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"WFProduct" ofType:@"bundle"]];
}

- (NSString*)_pathForFile:(NSString*)fileName extension:(NSString*)extension {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"WFProduct" ofType:@"bundle"];
    NSString *path = [[NSBundle bundleWithPath:bundlePath]  pathForResource:fileName ofType:extension];
    return path;
}

@end
