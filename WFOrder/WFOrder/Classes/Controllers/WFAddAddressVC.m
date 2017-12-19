//
//  WFAddAddressVC.m
//  ADSRouter
//
//  Created by Andy on 2017/12/18.
//

#import "WFAddAddressVC.h"
#import "WFOrderAddressService.h"
#import "WFUIComponent.h"
#import "WFOrderShipAddress.h"

@interface WFAddAddressVC ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UITextField *phoneInput;
@property (weak, nonatomic) IBOutlet UITextField *provinceInput;
@property (weak, nonatomic) IBOutlet UITextField *cityInput;
@property (weak, nonatomic) IBOutlet UITextField *detailInput;

@property (nonatomic, strong) WFOrderAddressService *addressService;

@end

@implementation WFAddAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    
}

- (IBAction)okBtnClicked:(id)sender {
    WFOrderShipAddress *address = [WFOrderShipAddress new];
    address.receiverName = _nameInput.text;
    address.receiverPhone = _phoneInput.text;
    address.province = _provinceInput.text;
    address.city = _cityInput.text;
    address.detail = _detailInput.text;
    __weak typeof(self) weakSelf = self;
    [self.addressService addAddress:address callback:^(BOOL success) {
        WFShowHud(success ? @"添加成功" : @"添加失败", weakSelf.view, 1);
        if (success) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }
    }];
}

- (WFOrderAddressService*)addressService {
    if (!_addressService) {
        _addressService = [WFOrderAddressService new];
    }
    return _addressService;
}

@end
