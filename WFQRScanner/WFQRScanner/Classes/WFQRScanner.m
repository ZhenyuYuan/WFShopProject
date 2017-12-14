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

@interface WFQRScanner ()

@property (nonatomic, strong) MTBBarcodeScanner *scanner;
@property (nonatomic, strong) UIView *previewView;
@end

@implementation WFQRScanner

ADS_REQUEST_MAPPING(WFQRScanner, "wfshop://qrscan")
ADS_SHOWSTYLE_PUSH_WITHOUT_ANIMATION
ADS_SUPPORT_FLY

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor wf_mainBackgroundColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_scanner) {
        _scanner = [[MTBBarcodeScanner alloc] initWithPreviewView:self.view];
    }
    [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
        if (success) {
            NSError *error = nil;
            [self.scanner startScanningWithResultBlock:^(NSArray *codes) {
                AVMetadataMachineReadableCodeObject *code = [codes firstObject];
                NSURL *url = [NSURL URLWithString:code.stringValue];
                if ([url.scheme isEqualToString:@"wfshop"]) {
                    [[ADSRouter sharedRouter] openUrlString:code.stringValue];
                } else {
                    [[ADSRouter sharedRouter] openUrlString:@""];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
