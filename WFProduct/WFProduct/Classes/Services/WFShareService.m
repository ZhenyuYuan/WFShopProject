//
//  WFShareService.m
//  ADSRouter
//
//  Created by Andy on 2018/1/10.
//

#import "WFShareService.h"
#import <Social/Social.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

@implementation WFShareItem
@end

@interface WFShareService()<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>

@property (nonatomic, weak) UIViewController *fromVC;
@property (nonatomic, strong) SLComposeViewController *shareVC;

@end

@implementation WFShareService

-(void)shareItem:(WFShareItem *)item fromVC:(UIViewController *)vc viaPlatform:(NSString *)platformId callback:(void (^)(BOOL, NSString *))callback {
    _fromVC = vc;
    if ([platformId isEqualToString:@"sms"]) {
        if(![MFMessageComposeViewController canSendText]){
            if (callback) {
                callback(NO, @"设备不能发短信");
            }
            return;
        }
        MFMessageComposeViewController *shareVC = [[MFMessageComposeViewController alloc] init];
        shareVC.messageComposeDelegate = self;
        NSString *bodySting = @"";
        bodySting = [bodySting stringByAppendingString:item.shareText];
        bodySting = [bodySting stringByAppendingString:item.shareUrl.absoluteString];
        shareVC.body = bodySting;
        [vc presentViewController:shareVC animated:YES completion:nil];
    } else if ([platformId isEqualToString:@"mail"]) {
        if (![MFMailComposeViewController canSendMail]) {
            if (callback) {
                callback(NO, @"设备不能发短信");
            }
            return;
        }
        MFMailComposeViewController *shareVC = [[MFMailComposeViewController alloc] init];
        shareVC.mailComposeDelegate = self;
        [shareVC setSubject:item.shareText];
        [shareVC setMessageBody:item.shareUrl.absoluteString isHTML:YES];
        NSData *imageData = UIImagePNGRepresentation(item.shareImage);
        [shareVC addAttachmentData:imageData mimeType:@"image/png" fileName:@"图片.png"];
        [vc presentViewController:shareVC animated:YES completion:nil];
    } else if ([platformId isEqualToString:@"copyLink"]) {
        [[UIPasteboard generalPasteboard] setString:item.shareUrl.absoluteString];
    } else {
        SLComposeViewController *shareVC = [SLComposeViewController composeViewControllerForServiceType:platformId];
        if (shareVC == nil){
            if (callback) {
                callback(NO, @"分享失败");
            }
            return;
        }
        if (![SLComposeViewController isAvailableForServiceType:platformId]) {
            if (callback) {
                callback(NO, @"未安装对应应用");
            }
            return;
        }
        [shareVC setInitialText:item.shareText];
        [shareVC addImage:item.shareImage];
        [shareVC addURL:item.shareUrl];
        shareVC.completionHandler = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                NSLog(@"点击了取消");
            } else {
                NSLog(@"点击了发送");
            }
        };
        [vc presentViewController:shareVC animated:YES completion:^{
            
        }];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
