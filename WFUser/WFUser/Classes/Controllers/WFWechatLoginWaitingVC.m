//
//  WFWechatLoginWaitingVC.m
//  ADSRouter
//
//  Created by Andy on 2018/1/19.
//

#import "WFWechatLoginWaitingVC.h"
#import "WFWechatLoginService.h"
#import "ADSRouter.h"
#import "WFHelpers.h"
#import "WFWechatAuthorizeObj.h"
#import "MBProgressHUD.h"

@interface WFWechatLoginWaitingVC ()

@property (nonatomic, strong) WFWechatLoginService *loginService;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation WFWechatLoginWaitingVC

ADS_REQUEST_MAPPING(WFWechatLoginWaitingVC, "wfshop://wechatAuthorize")
ADS_PARAMETER_MAPPING(WFWechatLoginWaitingVC, code, "code")
ADS_STORYBOARD_IN_BUNDLE("WFUser", "WFWechatLoginWaitingVC", "WFUser")

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_code && ![_code isEqualToString:@""]) {
        _hud = WFShowProgressHud(@"加载中", self.view, 1);
        [self startAuthorize];
    } else {
        WFShowHud(@"出错,请返回，重新授权", self.view, 1);
    }
}

- (void)startAuthorize {
    __weak typeof(self) weakSelf = self;
    [self.loginService getWechatUserWithCode:_code callback:^(WFWechatAuthorizeObj *user) {
        [weakSelf.loginService saveWechatUser:user];
        [weakSelf.hud hideAnimated:YES];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (WFWechatLoginService*)loginService {
    if (!_loginService) {
        _loginService = [WFWechatLoginService new];
    }
    return _loginService;
}

@end
