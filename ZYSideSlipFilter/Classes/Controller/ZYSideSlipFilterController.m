//
//  ZYSideSlipFilterController.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "ZYSideSlipFilterController.h"
#import "ZYSideSlipFilterRegionModel.h"
#import "SideSlipBaseTableViewCell.h"
#import "objc/message.h"
#import "ZYSideSlipFilterConfig.h"
#import "UIColor+hexColor.h"
#import "objc/runtime.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define SLIP_ORIGIN_FRAME CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH - _sideSlipLeading, SCREEN_HEIGHT)
#define SLIP_DISTINATION_FRAME CGRectMake(_sideSlipLeading, 0, SCREEN_WIDTH - _sideSlipLeading, SCREEN_HEIGHT)

const CGFloat ANIMATION_DURATION_DEFAULT = 0.3f;
const CGFloat SIDE_SLIP_LEADING_DEFAULT = 60;

id (*objc_msgSendGetCellIdentifier)(id self, SEL _cmd) = (void *)objc_msgSend;
CGFloat (*objc_msgSendGetCellHeight)(id self, SEL _cmd) = (void *)objc_msgSend;
id (*objc_msgSendCreateCellWithIndexPath)(id self, SEL _cmd, NSIndexPath *) = (void *)objc_msgSend;

@interface ZYSideSlipFilterController () <UITableViewDelegate, UITableViewDataSource, SideSlipBaseTableViewCellDelegate>
@property (copy, nonatomic) SideSlipFilterCommitBlock commitBlock;
@property (copy, nonatomic) SideSlipFilterResetBlock resetBlock;
@property (weak, nonatomic) UINavigationController *filterNavigation;
@property (strong, nonatomic) UITableView *mainTableView;
@property (strong, nonatomic) UIView *backCover;
@property (weak, nonatomic) UIViewController *sponsor;
@property (strong, nonatomic) NSMutableDictionary *templateCellDict;
@end

@implementation ZYSideSlipFilterController
- (instancetype)initWithSponsor:(UIViewController *)sponsor
                    resetBlock:(SideSlipFilterResetBlock)resetBlock
                    commitBlock:(SideSlipFilterCommitBlock)commitBlock {
    self = [super init];
    if (self) {
        NSAssert(sponsor.navigationController, @"ERROR: sponsor must have the navigationController");
        _sponsor = sponsor;
        _resetBlock = resetBlock;
        _commitBlock = commitBlock;
        UINavigationController *filterNavigation = [[NSClassFromString(FILTER_NAVIGATION_CONTROLLER_CLASS) alloc] initWithRootViewController:self];
        [filterNavigation setNavigationBarHidden:YES];
        filterNavigation.navigationBar.translucent = NO;
        [filterNavigation.view setFrame:SLIP_ORIGIN_FRAME];
        self.filterNavigation = filterNavigation;
        [self configureStatic];
        [self configureUI];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)configureUI {
    //bottomView
    UIView *bottomView = [self createBottomView];
    [self.view addSubview:bottomView];
    
    NSDictionary *views = @{@"mainTableView":self.mainTableView, @"bottomView":bottomView};
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bottomView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:BOTTOM_BUTTON_HEIGHT]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mainTableView]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bottomView]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mainTableView][bottomView]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
}

- (void)configureStatic {
    self.animationDuration = ANIMATION_DURATION_DEFAULT;
    self.sideSlipLeading = SIDE_SLIP_LEADING_DEFAULT;
}

- (void)show {
    [_sponsor.navigationController.view addSubview:self.backCover];
    [_sponsor.navigationController addChildViewController:self.navigationController];
    [_sponsor.navigationController.view addSubview:self.navigationController.view];
    
    [_backCover setHidden:YES];
    [UIView animateWithDuration:_animationDuration animations:^{
        [self.navigationController.view setFrame:SLIP_DISTINATION_FRAME];
    } completion:^(BOOL finished) {
        [_backCover setHidden:NO];
    }];
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

- (UIView *)createBottomView {
    UIView *bottomView = [[UIView alloc] init];
    [bottomView setTranslatesAutoresizingMaskIntoConstraints:NO];
    //resetButton
    UIButton *resetButton = [[UIButton alloc] init];
    [resetButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [resetButton addTarget:self action:@selector(clickResetButton:) forControlEvents:UIControlEventTouchUpInside];
    [resetButton.titleLabel setFont:[UIFont systemFontOfSize:BOTTOM_BUTTON_FONT_SIZE]];
    [resetButton setTitleColor:[UIColor hexColor:FILTER_BLACK_STRING] forState:UIControlStateNormal];
    NSString *resetString = LocalString(@"sZYFilterReset");
    if ([resetString isEqualToString:@"sZYFilterReset"]) {
        resetString = @"Reset";
    }
    [resetButton setTitle:resetString forState:UIControlStateNormal];
    [resetButton setBackgroundColor:[UIColor whiteColor]];
    [bottomView addSubview:resetButton];
    //commitButton
    UIButton *commitButton = [[UIButton alloc] init];
    [commitButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [commitButton addTarget:self action:@selector(clickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
    [commitButton.titleLabel setFont:[UIFont systemFontOfSize:BOTTOM_BUTTON_FONT_SIZE]];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    NSString *commitString = LocalString(@"sZYFilterCommit");
    if ([commitString isEqualToString:@"sZYFilterCommit"]) {
        commitString = @"Commit";
    }
    [commitButton setTitle:commitString forState:UIControlStateNormal];
    [commitButton setBackgroundColor:[UIColor hexColor:FILTER_RED_STRING]];
    [bottomView addSubview:commitButton];
    //constraints
    NSDictionary *views = NSDictionaryOfVariableBindings(resetButton, commitButton);
    [bottomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[resetButton][commitButton]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [bottomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[resetButton]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [bottomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[commitButton]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [bottomView addConstraint:[NSLayoutConstraint constraintWithItem:resetButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:commitButton attribute:NSLayoutAttributeWidth multiplier:1.f constant:0.f]];
    return bottomView;
}

- (void)clickResetButton:(id)sender {
    _resetBlock(_dataList);
    [[NSNotificationCenter defaultCenter] postNotificationName:FILTER_NOTIFICATION_NAME_DID_RESET_DATA object:nil];
    [_mainTableView reloadData];
}

- (void)clickCommitButton:(id)sender {
    _commitBlock(_dataList);
    [[NSNotificationCenter defaultCenter] postNotificationName:FILTER_NOTIFICATION_NAME_DID_COMMIT_DATA object:nil];
}

- (void)clickBackCover:(id)sender {
    [self dismiss];
}

- (void)reloadData {
    if (_mainTableView) {
        [_mainTableView reloadData];
    }
}

#pragma mark - DataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYSideSlipFilterRegionModel *model = _dataList[indexPath.row];
    Class cellClazz =  NSClassFromString(model.containerCellClass);
    if ([(id)cellClazz respondsToSelector:@selector(cellHeight)]) {
        CGFloat cellHeight = objc_msgSendGetCellHeight(cellClazz, NSSelectorFromString(@"cellHeight"));
        return cellHeight;
    }
    NSString *identifier = objc_msgSendGetCellIdentifier(cellClazz, NSSelectorFromString(@"cellReuseIdentifier"));
    SideSlipBaseTableViewCell *templateCell = [self.templateCellDict objectForKey:identifier];
    if (!templateCell) {
        templateCell = objc_msgSendCreateCellWithIndexPath(cellClazz, NSSelectorFromString(@"createCellWithIndexPath:"), indexPath);
        templateCell.delegate = self;
        [self.templateCellDict setObject:templateCell forKey:identifier];
    }
    //update
    [templateCell updateCellWithModel:&model indexPath:indexPath];
    //calculate
    NSLayoutConstraint *calculateCellConstraint = [NSLayoutConstraint constraintWithItem:templateCell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:self.view.bounds.size.width];
    [templateCell.contentView addConstraint:calculateCellConstraint];
    CGSize cellSize = [templateCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    [templateCell.contentView removeConstraint:calculateCellConstraint];
    return cellSize.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYSideSlipFilterRegionModel *model = _dataList[indexPath.row];
    Class cellClazz =  NSClassFromString(model.containerCellClass);
    NSString *identifier = objc_msgSendGetCellIdentifier(cellClazz, NSSelectorFromString(@"cellReuseIdentifier"));
    SideSlipBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = objc_msgSendCreateCellWithIndexPath(cellClazz, NSSelectorFromString(@"createCellWithIndexPath:"), indexPath);
        cell.delegate = self;
    }
    //update
    [cell updateCellWithModel:&model indexPath:indexPath];
    return cell;
}

- (void)sideSlipTableViewCellNeedsReload:(NSIndexPath *)indexPath {
    [_mainTableView reloadData];
}

- (void)sideSlipTableViewCellNeedsPushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.navigationController pushViewController:viewController animated:animated];
}

- (void)sideSlipTableViewCellNeedsScrollToCell:(UITableViewCell *)cell atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
    NSIndexPath *indexPath = [_mainTableView indexPathForRowAtPoint:cell.center];
    [_mainTableView scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GetSet
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] init];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        [_mainTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}

- (NSMutableDictionary *)templateCellDict {
    if (!_templateCellDict) {
        _templateCellDict = [NSMutableDictionary dictionary];
    }
    return _templateCellDict;
}

- (UIView *)backCover {
    if (!_backCover) {
        _backCover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_backCover setBackgroundColor:[UIColor hexColor:FILTER_BACKGROUND_COVER_COLOR]];
        [_backCover setAlpha:FILTER_BACKGROUND_COVER_ALPHA];
        [_backCover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBackCover:)]];
    }
    return _backCover;
}

- (UINavigationController *)filterNavigation {
    return objc_getAssociatedObject(_sponsor, _cmd);
}

- (void)setFilterNavigation:(UINavigationController *)filterNavigation {
    //让sponsor持有filterNavigation
    objc_setAssociatedObject(_sponsor, @selector(filterNavigation), filterNavigation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setDataList:(NSArray *)dataList {
    _dataList = [dataList copy];
    if (_mainTableView) {
        [_mainTableView reloadData];
    }
}
@end
