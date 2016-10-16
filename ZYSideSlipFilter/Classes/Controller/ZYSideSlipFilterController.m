//
//  ZYSideSlipFilterController.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "ZYSideSlipFilterController.h"
#import "ZYSideSlipFilterItemModel.h"
#import "SideSlipBaseTableViewCell.h"
#import "objc/message.h"

#define SIDE_SLIP_LEADING 60
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define SLIP_ORIGIN_FRAME CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH - SIDE_SLIP_LEADING, SCREEN_HEIGHT)
#define SLIP_DISTINATION_FRAME CGRectMake(SIDE_SLIP_LEADING, 0, SCREEN_WIDTH - SIDE_SLIP_LEADING, SCREEN_HEIGHT)

const CGFloat ANIMATION_DURATION_DEFAULT = 0.3f;

id (*objc_msgSendGetCellIdentifier)(id self, SEL _cmd) = (void *)objc_msgSend;
id (*objc_msgSendCreateCell)(id self, SEL _cmd) = (void *)objc_msgSend;

@interface ZYSideSlipFilterController () <UITableViewDelegate, UITableViewDataSource, SideSlipBaseTableViewCellDelegate>
@property (copy, nonatomic) SideSlipFilterCommitBlock commitBlock;
@property (strong, nonatomic) UINavigationController *navController;//强引用着self.navigationController
@property (strong, nonatomic) UITableView *mainTableView;
@property (strong, nonatomic) UIView *backCover;
@property (weak, nonatomic) UIViewController *sponsor;
@property (strong, nonatomic) NSMutableDictionary *templateCellDict;
@end

@implementation ZYSideSlipFilterController
- (instancetype)initWithSponsor:(UIViewController *)sponsor commitBlock:(SideSlipFilterCommitBlock)commitBlock {
    self = [super init];
    if (self) {
        _sponsor = sponsor;
        _navController = [[UINavigationController alloc] initWithRootViewController:self];
        [_navController setNavigationBarHidden:YES];
        [_navController.view setFrame:SLIP_ORIGIN_FRAME];
        [self configureStatic];
        [self configureUI];
    }
    return self;
}

//todo 考虑不用 不方便配置各种参数
+ (void)showSideSlipFilterWithSponsor:(UIViewController *)sponsor commitBlock:(SideSlipFilterCommitBlock)commitBlock {
    NSAssert(sponsor.navigationController, @"ERROR: sponsor must have the navigationController");
    //ZYSideSlipFilterController
    ZYSideSlipFilterController *sideSlipFilterController = [[ZYSideSlipFilterController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:sideSlipFilterController];
    [navController setNavigationBarHidden:YES];
    [navController.view setFrame:SLIP_ORIGIN_FRAME];
    //show
    [sponsor.navigationController.view addSubview:sideSlipFilterController.backCover];
    [sponsor.navigationController addChildViewController:navController];
    [sponsor.navigationController.view addSubview:navController.view];
    
    [sideSlipFilterController.backCover setAlpha:0.f];
    [UIView animateWithDuration:sideSlipFilterController.animationDuration animations:^{
        [navController.view setFrame:SLIP_DISTINATION_FRAME];
    } completion:^(BOOL finished) {
        [sideSlipFilterController.backCover setAlpha:1.f];
    }];
}

- (void)show {
    [_sponsor.navigationController.view addSubview:self.backCover];
    [_sponsor.navigationController addChildViewController:self.navigationController];
    [_sponsor.navigationController.view addSubview:self.navigationController.view];
    
    [_backCover setAlpha:0.f];
    [UIView animateWithDuration:_animationDuration animations:^{
        [self.navigationController.view setFrame:SLIP_DISTINATION_FRAME];
    } completion:^(BOOL finished) {
        [_backCover setAlpha:1.f];
    }];
}

- (void)configureUI {
    self.mainTableView = [[UITableView alloc] init];
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    NSDictionary *views = @{@"mainTableView":_mainTableView};
    [_mainTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_mainTableView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mainTableView]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mainTableView]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
}

- (void)configureStatic {
    if (_animationDuration == 0) {
        self.animationDuration = ANIMATION_DURATION_DEFAULT;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self dismiss];
}

- (void)dismiss {
    [UIView animateWithDuration:_animationDuration animations:^{
        [self.navigationController.view setFrame:SLIP_ORIGIN_FRAME];
    } completion:^(BOOL finished) {
        [_backCover removeFromSuperview];
        [self.navigationController.view removeFromSuperview];
        [self.navigationController removeFromParentViewController];
    }];
}

#pragma mark - DataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYSideSlipFilterItemModel *model = _dataList[indexPath.row];
    Class cellClazz =  NSClassFromString(model.containerCellClass);
    NSString *identifier = objc_msgSendGetCellIdentifier(cellClazz, NSSelectorFromString(@"cellReuseIdentifier"));
    SideSlipBaseTableViewCell *templateCell = [self.templateCellDict objectForKey:identifier];
    if (!templateCell) {
        templateCell = objc_msgSendCreateCell(cellClazz, NSSelectorFromString(@"createCell"));
        [self.templateCellDict setObject:templateCell forKey:identifier];
    }
    //update
    [templateCell updateCellWithModel:&model];
    //calculate
    NSLayoutConstraint *calculateCellConstraint = [NSLayoutConstraint constraintWithItem:templateCell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:self.view.bounds.size.width];
    [templateCell.contentView addConstraint:calculateCellConstraint];
    CGSize cellSize = [templateCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    [templateCell.contentView removeConstraint:calculateCellConstraint];
    return cellSize.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYSideSlipFilterItemModel *model = _dataList[indexPath.row];
    Class cellClazz =  NSClassFromString(model.containerCellClass);
    NSString *identifier = objc_msgSendGetCellIdentifier(cellClazz, NSSelectorFromString(@"cellReuseIdentifier"));
    SideSlipBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = objc_msgSendCreateCell(cellClazz, NSSelectorFromString(@"createCell"));
        cell.delegate = self;
    }
    //update
    [cell updateCellWithModel:&model];
    return cell;
}

- (void)sideSlipTableViewCellNeedsReload:(SideSlipBaseTableViewCell *)cell {
    NSIndexPath *indexPath = [_mainTableView indexPathForCell:cell];
    [_mainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - GetSet
- (NSMutableDictionary *)templateCellDict {
    if (!_templateCellDict) {
        _templateCellDict = [NSMutableDictionary dictionary];
    }
    return _templateCellDict;
}

@end
