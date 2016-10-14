//
//  ZYSideSlipFilterController.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "ZYSideSlipFilterController.h"

@interface ZYSideSlipFilterController ()
@property (copy, nonatomic) SideSlipFilterCommitBlock commitBlock;
@end

@implementation ZYSideSlipFilterController
+ (void)showSideSlipFilter:(UIViewController *)sponsor commitBlock:(SideSlipFilterCommitBlock)commitBlock {
    NSAssert(sponsor.navigationController, @"ERROR: sponsor must have the navigationController");
    //show
    ZYSideSlipFilterController *sideSlipFilterController = [[ZYSideSlipFilterController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:sideSlipFilterController];
    [sponsor.navigationController addChildViewController:navController];
    [sponsor.view addSubview:navController.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
