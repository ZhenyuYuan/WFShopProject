//
//  WFRepairVC.m
//  ADSRouter
//
//  Created by Andy on 2018/1/22.
//

#import "WFRepairVC.h"
#import "WFUIComponent.h"
#import "ADSRouter.h"
#import "WFOrderDataService.h"
#import "UIImageView+WebCache.h"

@interface WFRepairVC ()
@property (weak, nonatomic) IBOutlet UILabel *serviceStyleLabel;
@property (weak, nonatomic) IBOutlet UIButton *refundBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UIButton *repairBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property (weak, nonatomic) IBOutlet UIButton *addImgBtn;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UIImageView *img5;

@property (nonatomic, assign) NSInteger serviceType;

@property (nonatomic, strong) NSMutableArray<NSString*> *imgUrls;


@property (nonatomic, strong) WFOrderDataService *orderService;

@end

@implementation WFRepairVC

ADS_REQUEST_MAPPING(WFRepairVC, "wfshop://repair")
ADS_STORYBOARD_IN_BUNDLE("WFOrder", "WFRepairVC", "WFOrder")
ADS_PARAMETER_MAPPING(WFRepairVC, orderId, "orderId")

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI {
    _serviceStyleLabel.font = [UIFont wf_pfr14];
    
    _refundBtn.titleLabel.font = [UIFont wf_pfr13];
    [_refundBtn addTarget:self action:@selector(selectService:) forControlEvents:UIControlEventTouchUpInside];
    [DCSpeedy dc_chageControlCircularWith:_refundBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor wf_lightGrayColor] canMasksToBounds:YES];
    
    _changeBtn.titleLabel.font = [UIFont wf_pfr13];
    [_changeBtn addTarget:self action:@selector(selectService:) forControlEvents:UIControlEventTouchUpInside];
    [DCSpeedy dc_chageControlCircularWith:_changeBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor wf_lightGrayColor] canMasksToBounds:YES];
    
    _repairBtn.titleLabel.font = [UIFont wf_pfr13];
    [_repairBtn addTarget:self action:@selector(selectService:) forControlEvents:UIControlEventTouchUpInside];
    [DCSpeedy dc_chageControlCircularWith:_repairBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor wf_lightGrayColor] canMasksToBounds:YES];
    
    _cancelBtn.titleLabel.font = [UIFont wf_pfr14];
    [DCSpeedy dc_chageControlCircularWith:_cancelBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor wf_lightGrayColor] canMasksToBounds:YES];
    
    _commitBtn.titleLabel.font = [UIFont wf_pfr14];
    [_commitBtn setTitleColor:[UIColor wf_mainColor] forState:UIControlStateNormal];
    [DCSpeedy dc_chageControlCircularWith:_commitBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor wf_mainColor] canMasksToBounds:YES];
    
    [_addImgBtn addTarget:self action:@selector(addImg) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectService:(UIButton*)btn {
    
    [_refundBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [DCSpeedy dc_chageControlCircularWith:_refundBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor wf_lightGrayColor] canMasksToBounds:YES];
    
    [_changeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [DCSpeedy dc_chageControlCircularWith:_changeBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor wf_lightGrayColor] canMasksToBounds:YES];
    
    [_repairBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [DCSpeedy dc_chageControlCircularWith:_repairBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor wf_lightGrayColor] canMasksToBounds:YES];
    
    [btn setTitleColor:[UIColor wf_mainColor] forState:UIControlStateNormal];
    [DCSpeedy dc_chageControlCircularWith:btn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor wf_mainColor] canMasksToBounds:YES];
    if (btn == _refundBtn) {
        _serviceType = 1;
    } else if (btn == _changeBtn) {
        _serviceType = 2;
    } else {
        _serviceType = 3;
    }
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
