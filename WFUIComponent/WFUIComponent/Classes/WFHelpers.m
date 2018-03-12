//
//  WFHelpers.m
//  ADSRouter
//
//  Created by Andy on 2017/10/24.
//

#import "WFHelpers.h"
#import "MBProgressHUD.h"

CGFloat WFGetScreenWidth() {
    return CGRectGetWidth([UIScreen mainScreen].bounds);
}

CGFloat WFGetScreenHeight() {
    return CGRectGetHeight([UIScreen mainScreen].bounds);
}

void WFShowHud(NSString *msg, UIView *toView, CGFloat duration) {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    hud.label.textColor = [UIColor whiteColor];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:duration];
}

MBProgressHUD* WFShowProgressHud(NSString *msg, UIView *toView, CGFloat duration) {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = msg;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

NSBundle* WFGetBundle(NSString *bundleName) {
    return [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"]];
}

NSString* WFGetPathForFile(NSString *fileName, NSString *extension, NSString *bundleName) {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    NSString *path = [[NSBundle bundleWithPath:bundlePath]  pathForResource:fileName ofType:extension];
    return path;
}


void WFAskSomething(NSString *title, NSString *msg, UIViewController *vc, dispatch_block_t yesBlk, dispatch_block_t noBlk) {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"是否删除商品" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (yesBlk) yesBlk();
    }];
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (noBlk) noBlk();
    }];
    [alertVC addAction:yes];
    [alertVC addAction:no];
    [vc presentViewController:alertVC animated:YES completion:nil];
}

@implementation WFHelpers

@end
