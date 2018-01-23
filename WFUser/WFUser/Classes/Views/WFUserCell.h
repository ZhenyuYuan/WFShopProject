//
//  WFUserCell.h
//  ADSRouter
//
//  Created by Andy on 2017/12/14.
//

#import <UIKit/UIKit.h>

@class WFUser, WFWechatUser;
@interface WFUserCell : UITableViewCell

@property (nonatomic, strong) WFUser *user;
@property (nonatomic, strong) WFWechatUser *wechatUser;

@property (nonatomic, copy) dispatch_block_t doLogin;
@property (nonatomic, copy) dispatch_block_t userAvatarClicked;

@end
