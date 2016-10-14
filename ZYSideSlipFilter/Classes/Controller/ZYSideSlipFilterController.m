//
//  ZYSideSlipFilterController.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "ZYSideSlipFilterController.h"

#define SIDE_SLIP_LEADING 80
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ZYSideSlipFilterController ()
@property (copy, nonatomic) SideSlipFilterCommitBlock commitBlock;
@property (strong, nonatomic) UITableView *mainTableView;
@property (strong, nonatomic) UIView *backCover;
@end

@implementation ZYSideSlipFilterController
- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureUI];
    }
    return self;
}

+ (void)showSideSlipFilterWithSponsor:(UIViewController *)sponsor commitBlock:(SideSlipFilterCommitBlock)commitBlock {
    NSAssert(sponsor.navigationController, @"ERROR: sponsor must have the navigationController");
    //show
    ZYSideSlipFilterController *sideSlipFilterController = [[ZYSideSlipFilterController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:sideSlipFilterController];
    [navController setNavigationBarHidden:YES];
    [navController.view setFrame:CGRectMake(SIDE_SLIP_LEADING, 0, SCREEN_WIDTH - SIDE_SLIP_LEADING, SCREEN_HEIGHT)];
    
    [sponsor.navigationController.view addSubview:sideSlipFilterController.backCover];
    [sponsor.navigationController addChildViewController:navController];
    [sponsor.navigationController.view addSubview:navController.view];
}

- (void)configureUI {
    self.mainTableView = [[UITableView alloc] init];
//    NSDictionary *views = @{@"mainTableView":_mainTableView};
//    [_mainTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)backCover {
    if (!_backCover) {
        _backCover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_backCover setBackgroundColor:[UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:0.8]];
        [_backCover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBackCover:)]];
    }
    return _backCover;
}

- (void)clickBackCover:(id)sender {
    NSLog(@"clickBackCover");
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
