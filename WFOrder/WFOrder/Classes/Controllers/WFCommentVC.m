//
//  WFCommentVC.m
//  ADSRouter
//
//  Created by Andy on 2018/1/22.
//

#import "WFCommentVC.h"
#import "WFUIComponent.h"
#import "ADSRouter.h"
#import "WFOrderDataService.h"
#import "UIImageView+WebCache.h"

@interface WFCommentVC () <UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *coverImg;
@property (weak, nonatomic) IBOutlet UIButton *goodBtn;
@property (weak, nonatomic) IBOutlet UIButton *fairBtn;
@property (weak, nonatomic) IBOutlet UIButton *badBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *anonymousBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *addImgBtn;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UIImageView *img5;

@property (nonatomic, strong) NSMutableArray<NSString*> *imgUrls;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) BOOL anonymous;


@property (nonatomic, strong) WFOrderDataService *orderService;

@end

@implementation WFCommentVC

ADS_REQUEST_MAPPING(WFCommentVC, "wfshop://comment")
ADS_STORYBOARD_IN_BUNDLE("WFOrder", "WFCommentVC", "WFOrder")
ADS_PARAMETER_MAPPING(WFCommentVC, orderId, "orderId")

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    _anonymousBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_goodBtn addTarget:self action:@selector(selectLevel:) forControlEvents:UIControlEventTouchUpInside];
    [_fairBtn addTarget:self action:@selector(selectLevel:) forControlEvents:UIControlEventTouchUpInside];
    [_badBtn addTarget:self action:@selector(selectLevel:) forControlEvents:UIControlEventTouchUpInside];
    [_anonymousBtn addTarget:self action:@selector(needAnonymous) forControlEvents:UIControlEventTouchUpInside];
    
    [_cancelBtn setTitleColor:[UIColor wf_lightGrayColor] forState:UIControlStateNormal];
    [_commentBtn setTitleColor:[UIColor wf_mainColor] forState:UIControlStateNormal];
    [DCSpeedy dc_chageControlCircularWith:_cancelBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor wf_lightGrayColor] canMasksToBounds:YES];
    [DCSpeedy dc_chageControlCircularWith:_commentBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor wf_mainColor] canMasksToBounds:YES];
    
    [_addImgBtn addTarget:self action:@selector(addImg) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectLevel:(UIButton*)btn {

    [_goodBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_goodBtn setImage:[UIImage imageNamed:@"good" inBundle:WFGetBundle(@"WFOrder") compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    
    [_fairBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_fairBtn setImage:[UIImage imageNamed:@"fair" inBundle:WFGetBundle(@"WFOrder") compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    
    [_badBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_badBtn setImage:[UIImage imageNamed:@"bad" inBundle:WFGetBundle(@"WFOrder") compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor wf_mainColor] forState:UIControlStateNormal];
    [btn setImage:[btn.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}

- (void)needAnonymous {
    if (_anonymous) {
        [_anonymousBtn setImage:[UIImage imageNamed:@"radio" inBundle:WFGetBundle(@"WFOrder") compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    } else {
        [_anonymousBtn setImage:[[UIImage imageNamed:@"radio-checked" inBundle:WFGetBundle(@"WFOrder") compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }
    _anonymous = !_anonymous;
}

- (void)addImg {
    if (_imgUrls.count > 4) {
        WFShowHud(@"最多5张照片", self.view, 1);
        return;
    }
    UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
    pickVC.delegate = self;
    [self presentViewController:pickVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    MBProgressHUD *hud = WFShowProgressHud(@"上传中", picker.view, 1);
    __weak typeof(self) weakSelf = self;
    [self.orderService uploadImage:image name:@"1.jpg" callback:^(NSString *imgUrl) {
        [weakSelf.imgUrls addObject:imgUrl];
        [weakSelf updateImgs];
        hud.hidden = YES;
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)updateImgs {
    NSArray<UIImageView*> *imgViews = @[_img1, _img2, _img3, _img4, _img5];
    [self.imgUrls enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < imgViews.count) {
            [imgViews[idx] sd_setImageWithURL:[NSURL URLWithString:obj]];
        }
    }];
}

- (WFOrderDataService*)orderService {
    if (!_orderService) {
        _orderService = [WFOrderDataService new];
    }
    return _orderService;
}

- (NSMutableArray<NSString *> *)imgUrls {
    if (!_imgUrls) {
        _imgUrls = [NSMutableArray array];
    }
    return _imgUrls;
}


@end
