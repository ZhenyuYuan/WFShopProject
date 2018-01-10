//
//  WFShareService.h
//  ADSRouter
//
//  Created by Andy on 2018/1/10.
//

#import <Foundation/Foundation.h>

/*
 * 调用以下代码获取手机中装的App的所有Share Extension的ServiceType
 
 SLComposeViewController *composeVc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
 
 * 我获得的部分数据
 
 com.taobao.taobao4iphone.ShareExtension  淘宝
 com.apple.share.Twitter.post  推特
 com.apple.share.Facebook.post 脸书
 com.apple.share.SinaWeibo.post 新浪微博
 com.apple.share.Flickr.post 雅虎
 com.burbn.instagram.shareextension   instagram
 com.amazon.AmazonCN.AWListShareExtension 亚马逊
 com.apple.share.TencentWeibo.post 腾讯微博
 com.smartisan.notes.SMShare 锤子便签
 com.zhihu.ios.Share 知乎
 com.tencent.mqq.ShareExtension QQ
 com.tencent.xin.sharetimeline 微信
 com.alipay.iphoneclient.ExtensionSchemeShare 支付宝
 com.apple.mobilenotes.SharingExtension  备忘录
 com.apple.reminders.RemindersEditorExtension 提醒事项
 com.apple.Health.HealthShareExtension      健康
 com.apple.mobileslideshow.StreamShareService  iCloud
 
 */

@interface WFShareItem: NSObject

@property (nullable, nonatomic, strong) NSString *shareText;
@property (nullable, nonatomic, strong) UIImage *shareImage;
@property (nullable, nonatomic, strong) NSURL *shareUrl;

@end

@interface WFShareService : NSObject

- (void)shareItem:(WFShareItem*)item fromVC:(UIViewController*)vc viaPlatform:(NSString*)platformId callback:(void(^)(BOOL success, NSString *msg)) callback;

@end
