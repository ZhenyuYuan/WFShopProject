//
//  WFWechatLoginVC.m
//  ADSRouter
//
//  Created by Andy on 2018/1/18.
//

#import "WFWechatLoginVC.h"
#import "ADSRouter.h"
#import "WXApi.h"

@interface WFWechatLoginVC ()

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation WFWechatLoginVC

ADS_REQUEST_MAPPING(WFWechatLoginVC, "wfshop://login")
ADS_STORYBOARD_IN_BUNDLE("WFUser", "WFWechatLoginVC", "WFUser")
ADS_SHOWSTYLE_PRESENT
ADS_HIDE_NAV

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (![WXApi isWXAppInstalled]) {
        [self disableLoginBtn];
    }
}

- (void)disableLoginBtn {
    [_loginBtn setEnabled:NO];
    [_loginBtn setTitle:@"请先安装微信客户端" forState:UIControlStateNormal];
}

- (IBAction)loginBtnClicked:(id)sender {
    SendAuthReq* req = [SendAuthReq new];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    [WXApi sendReq:req];
}

- (IBAction)closeBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
