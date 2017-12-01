//
//  WFNotFoundVC.m
//  ADSRouter
//
//  Created by Andy on 2017/10/17.
//

#import "WFNotFoundVC.h"
#import "ADSRouter.h"

@interface WFNotFoundVC ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation WFNotFoundVC

ADS_REQUEST_MAPPING(WFNotFoundVC, "wfshop://notfound")
ADS_STORYBOARD_IN_BUNDLE("WFNotFound", "WFNotFoundVC", "WFNotFound")
ADS_PARAMETER_MAPPING(WFNotFoundVC, url, "url")

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _label.text = _url;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
