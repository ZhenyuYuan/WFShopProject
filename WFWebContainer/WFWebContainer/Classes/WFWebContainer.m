//
//  WFWebContainer.m
//  ADSRouter
//
//  Created by Andy on 2017/10/17.
//

#import "WFWebContainer.h"
#import <WebKit/WebKit.h>
#import "ADSRouter.h"
#import "Masonry.h"
#import "WFHelpers.h"
#import "WFProgressBar.h"
#import "WFUIComponent.h"
#import "WebViewJavascriptBridge.h"

@interface WFWebContainer () <WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (nonatomic, strong) WFProgressBar *progressBar;

@end

@implementation WFWebContainer

ADS_REQUEST_MAPPING(WFWebContainer, "wfshop://webContainer")
ADS_PARAMETER_MAPPING(WFWebContainer, url, "url")
ADS_HIDE_BOTTOM_BAR

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self setUpBridge];
    [self loadPage];
}

- (void)setUpUI {
    [self.view addSubview:self.progressBar];
    [_progressBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(2));
        make.left.right.mas_equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuide);
    }];
    [self.view insertSubview:self.webView belowSubview:_progressBar];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideTop);
        make.left.right.mas_equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
    }];
}

- (void)setUpBridge {
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [WebViewJavascriptBridge enableLogging];
    [_bridge registerHandler:@"getAccessToken" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"accessToken");
    }];
}

- (void)loadPage {
    NSURL *url = [NSURL URLWithString:_url];
    if (!url) {
        WFShowHud(@"链接错误", self.view, 1);
    } else {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([navigationAction.request.URL.scheme isEqualToString:@"wfshop"]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        [[ADSRouter sharedRouter] openUrl:navigationAction.request.URL];
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == _webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        double progress = [[change valueForKey:NSKeyValueChangeNewKey] doubleValue];
        _progressBar.progress = progress;
        NSLog(@"%f", progress);
    }
}

- (WFProgressBar*)progressBar {
    if (!_progressBar) {
        _progressBar = [WFProgressBar new];
        _progressBar.color = [UIColor wf_mainColor];
        _progressBar.hideOnComplete = YES;
        
    }
    return _progressBar;
}

- (WKWebView*)webView {
    if (!_webView) {
        _webView = [WKWebView new];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;
}


- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end
