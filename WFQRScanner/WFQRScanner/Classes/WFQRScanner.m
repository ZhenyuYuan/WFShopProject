//
//  WFQRScanner.m
//  ADSRouter
//
//  Created by Andy on 2017/10/16.
//

#import "WFQRScanner.h"
#import "ADSRouter.h"
#import "UIColor+WFColor.h"
#import "Masonry.h"
#import "MTBBarcodeScanner.h"
#import "WFURLDispatcherProtocol.h"
#import "BeeHive.h"

@interface WFQRScanner ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scannerBarTop;
@property (nonatomic, strong) MTBBarcodeScanner *scanner;
@property (nonatomic, strong) UIView *previewView;
@property (nonatomic, strong) id<WFURLDispatcherProtocol> urlDispatcher;
@end

@implementation WFQRScanner

ADS_REQUEST_MAPPING(WFQRScanner, "wfshop://qrscan")
ADS_SHOWSTYLE_PUSH_WITHOUT_ANIMATION
ADS_STORYBOARD_IN_BUNDLE("WFQRScanner", "WFQRScanner", "WFQRScanner")
ADS_HIDE_BOTTOM_BAR
ADS_SUPPORT_FLY

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor wf_mainBackgroundColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    __weak typeof(self) weakSelf = self;
    if (!_scanner) {
        _scanner = [[MTBBarcodeScanner alloc] initWithPreviewView:self.view];
        _scanner.didStartScanningBlock = ^{
            weakSelf.scanner.scanRect = CGRectMake(30, 150, 300, 300);
        };
    }
    [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
        if (success) {
            NSError *error = nil;
            [weakSelf startScannerBarAnimation];
            [weakSelf.scanner startScanningWithResultBlock:^(NSArray *codes) {
                AVMetadataMachineReadableCodeObject *code = [codes firstObject];
                NSURL *url = [NSURL URLWithString:code.stringValue];
                if (url) {
                    [self.urlDispatcher openUrl:url];
                }
                
                [self.scanner stopScanning];
            } error:&error];
            
        } else {
            // The user denied access to the camera
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"显示视图:%f", [NSDate date].timeIntervalSince1970);
    NSLog(@"实例:%p", self);
}

- (void)startScannerBarAnimation {
    __weak typeof(self) weakSelf = self;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        if (weakSelf) {
            weakSelf.scannerBarTop.constant = 290;
            [weakSelf.view setNeedsLayout];
            [weakSelf.view layoutIfNeeded];
        }
    } completion:^(BOOL finished) {
        weakSelf.scannerBarTop.constant = 0;
    }];
    
}

- (id<WFURLDispatcherProtocol>)urlDispatcher {
    if (!_urlDispatcher) {
        _urlDispatcher = [[BeeHive shareInstance] createService:@protocol(WFURLDispatcherProtocol)];
    }
    return _urlDispatcher;
}

@end
