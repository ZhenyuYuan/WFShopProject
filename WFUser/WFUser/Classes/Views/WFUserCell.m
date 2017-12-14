//
//  WFUserCell.m
//  ADSRouter
//
//  Created by Andy on 2017/12/14.
//

#import "WFUserCell.h"
#import "UIImageView+WebCache.h"
#import "WFUser.h"
#import "WFHelpers.h"
@interface WFUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation WFUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _avatarImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarClicked)];
    [_avatarImgView addGestureRecognizer:gestureRecognizer];
    
    [_loginBtn addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(WFUser *)user {
    _user = user;
    if (_user) {
        [_avatarImgView sd_setImageWithURL:[NSURL URLWithString:_user.avatarUrl]];
        [_loginBtn setTitle:_user.name forState:UIControlStateNormal];
    } else {
        [_avatarImgView setImage:[UIImage imageNamed:@"avatar" inBundle:WFGetBundle(@"WFUser") compatibleWithTraitCollection:nil]];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    }
}
- (void)avatarClicked {
    if (_userAvatarClicked) _userAvatarClicked();
}

- (void)loginBtnClicked {
    if (_doLogin && !_user) {
        _doLogin();
    }
}
@end
