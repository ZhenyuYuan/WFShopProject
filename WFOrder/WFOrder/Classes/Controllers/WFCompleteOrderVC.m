//
//  WFCompleteOrderVC.m
//  ADSRouter
//
//  Created by Andy on 2017/11/15.
//

#import "WFCompleteOrderVC.h"
#import "ADSRouter.h"

@interface WFCompleteOrderVC ()

@end

@implementation WFCompleteOrderVC

ADS_REQUEST_MAPPING(WFCompleteOrderVC, "wfshop://completeOrder")
ADS_STORYBOARD_IN_BUNDLE("WFOrder", "WFCompleteOrderVC", "WFOrder")

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
