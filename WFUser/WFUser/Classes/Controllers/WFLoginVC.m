//
//  WFLoginVC.m
//  ADSRouter
//
//  Created by Andy on 2017/12/14.
//

#import "WFLoginVC.h"
#import "ADSRouter.h"
#import "WFUIComponent.h"
#import "WFUserCenter.h"
#import "WFUserToken.h"
#import "WFUserLoginDataService.h"

@interface WFLoginVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *forgetPwdBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UILabel *pageHeader;
@property (weak, nonatomic) IBOutlet UITextField *accountInput;
@property (weak, nonatomic) IBOutlet UIView *accontInputBottomLine;
@property (weak, nonatomic) IBOutlet UITextField *passInput;
@property (weak, nonatomic) IBOutlet UIView *passInputBottomLine;
@property (weak, nonatomic) IBOutlet UIButton *changeLoginTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendSmsBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqBtn;

@property (nonatomic, strong) WFUserLoginDataService *loginService;
@end

@implementation WFLoginVC

//ADS_REQUEST_MAPPING(WFLoginVC, "wfshop://login")
//ADS_STORYBOARD_IN_BUNDLE("WFUser", "WFLoginVC", "WFUser")
//ADS_PARAMETER_MAPPING(WFLoginVC, loginType, "type")
//ADS_SHOWSTYLE_PRESENT

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)setUpUI {
    _pageHeader.font = [UIFont wf_pfr18];
    _forgetPwdBtn.titleLabel.font = [UIFont wf_pfr13];
    _accountInput.font = [UIFont wf_pfr15];
    _passInput.font = [UIFont wf_pfr15];
    _sendSmsBtn.titleLabel.font = [UIFont wf_pfr13];
    _changeLoginTypeBtn.titleLabel.font = [UIFont wf_pfr13];
    _loginBtn.titleLabel.font = [UIFont wf_pfr18];
    
    _accountInput.delegate = self;
    _passInput.delegate = self;
    _accontInputBottomLine.backgroundColor = [UIColor wf_lightGrayColor];
    _passInputBottomLine.backgroundColor = [UIColor wf_lightGrayColor];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBlankArea)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    if (_loginType == WFLoginTypePhone) {
        [self setUpUIForPhoneLogin];
    } else {
        [self setUpUIForAccountLogin];
    }
}

- (void)setUpUIForPhoneLogin {
    [_forgetPwdBtn setHidden:YES];
    _pageHeader.text = @"手机号登录";
    _accountInput.placeholder = @"请输入手机号";
    _passInput.placeholder = @"请输入短信验证码";
    [_changeLoginTypeBtn setTitle:@"用账号密码登录 >" forState:UIControlStateNormal];
    [_sendSmsBtn setHidden:NO];
}

- (void)setUpUIForAccountLogin {
    [_forgetPwdBtn setHidden:NO];
    _pageHeader.text = @"账号密码登录";
    _accountInput.placeholder = @"请输入手机号/邮箱";
    _passInput.placeholder = @"请输入密码";
    [_changeLoginTypeBtn setTitle:@"用手机号登录 >" forState:UIControlStateNormal];
    [_sendSmsBtn setHidden:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _accountInput) {
        _accontInputBottomLine.backgroundColor = [UIColor wf_mainColor];
    } else {
        _passInputBottomLine.backgroundColor = [UIColor wf_mainColor];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _accountInput) {
        _accontInputBottomLine.backgroundColor = [UIColor wf_lightGrayColor];
    } else {
        _passInputBottomLine.backgroundColor = [UIColor wf_lightGrayColor];
    }
}

- (void)highlight:(UITextField*)textField {
    if (textField == _accountInput) {
        _accontInputBottomLine.backgroundColor = [UIColor wf_mainColor];
        _passInputBottomLine.backgroundColor = [UIColor wf_lightGrayColor];
    } else {
        _accontInputBottomLine.backgroundColor = [UIColor wf_lightGrayColor];
        _passInputBottomLine.backgroundColor = [UIColor wf_mainColor];
    }
}

- (IBAction)closeBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginBtnClicked:(id)sender {
    NSString *errorMsg;
    NSString *account = _accountInput.text;
    NSString *pwd = _passInput.text;
    if (!account || [account isEqualToString:@""]) {
        if (_loginType == WFLoginTypePhone) {
            errorMsg = @"请填写手机号";
        } else {
            errorMsg = @"请填写账号";
        }
    }
    if (!pwd || [pwd isEqualToString:@""]) {
        if (_loginType == WFLoginTypePhone) {
            errorMsg = @"请填写验证码";
        } else {
            errorMsg = @"请填写密码";
        }
    }
    if (errorMsg) {
        WFShowHud(errorMsg, self.view, 1);
        return;
    }
    __weak typeof(self) weakSelf = self;
    void(^callback)(WFUserToken *userToken) = ^(WFUserToken *userToken) {
        if (userToken) {
            WFUserCenter *userCenter = [WFUserCenter sharedCenter];
            [userCenter setUserToken:userToken];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        } else {
            WFShowHud(@"登录失败", weakSelf.view, 1);
        }
    };
    if (_loginType == WFLoginTypePhone) {
        [self.loginService verifyCodeWithPhoneNumber:account code:pwd callback:callback];
    } else {
        [self.loginService loginWithAccount:account pwd:pwd callback:callback];
    }
}


- (IBAction)changeLoginType:(id)sender {
    if (_loginType == WFLoginTypePhone) {
        [self setUpUIForAccountLogin];
        _loginType = WFLoginTypeEmail;
    } else {
        [self setUpUIForPhoneLogin];
        _loginType = WFLoginTypePhone;
    }
}

- (IBAction)sendSms:(id)sender {
    NSString *account = _accountInput.text;
    if (!account || [account isEqualToString:@""]) {
        WFShowHud(@"请填写手机号", self.view, 1);
        return;
    }
    [self.loginService sendSmsWithPhoneNumber:account callback:^(BOOL success) {
        if (success) {
            WFShowHud(@"发送成功", self.view, 1);
        } else {
            WFShowHud(@"发送失败", self.view, 1);
        }
    }];
}

- (void)clickBlankArea {
    [_accountInput resignFirstResponder];
    [_passInput resignFirstResponder];
}

- (WFUserLoginDataService*)loginService {
    if (!_loginService) {
        _loginService = [WFUserLoginDataService new];
    }
    return _loginService;
}
@end
