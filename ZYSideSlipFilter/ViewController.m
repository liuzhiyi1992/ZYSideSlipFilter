//
//  ViewController.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "ViewController.h"
#import "ZYSideSlipFilterController.h"
#import "ZYSideSlipFilterRegionModel.h"
#import "CommonItemModel.h"

@interface ViewController ()
@property (strong, nonatomic) ZYSideSlipFilterController *filterController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.filterController = [[ZYSideSlipFilterController alloc] initWithSponsor:self resetBlock:^(NSArray *dataList) {
        for (ZYSideSlipFilterRegionModel *model in dataList) {
            //selectedStatus
            for (CommonItemModel *itemModel in model.itemList) {
                [itemModel setSelected:NO];
            }
            //selectedItem
            model.selectedItemList = nil;
        }
    } commitBlock:^(NSArray *dataList) {
        NSLog(@"commit");
    }];
    _filterController.animationDuration = .3f;
    _filterController.dataList = [self packageDataList];
}

- (IBAction)clickFilterButton:(id)sender {
//    [ZYSideSlipFilterController showSideSlipFilterWithSponsor:self commitBlock:^(NSDictionary *commitDict) {
//        NSLog(@"");
//    }];
    [_filterController show];
}

#pragma mark - 模拟数据源
- (NSArray *)packageDataList {
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:[self commonFilterRegionModelWithKeywork:@"品牌"]];
    [dataArray addObject:[self serviceFilterRegionModel]];
    [dataArray addObject:[self priceFilterRegionModel]];
    [dataArray addObject:[self allCategoryFilterRegionModel]];
    [dataArray addObject:[self commonFilterRegionModelWithKeywork:@"种类"]];
    [dataArray addObject:[self commonFilterRegionModelWithKeywork:@"特性"]];
    [dataArray addObject:[self commonFilterRegionModelWithKeywork:@"适用场景"]];
    [dataArray addObject:[self commonFilterRegionModelWithKeywork:@"附加1"]];
    [dataArray addObject:[self commonFilterRegionModelWithKeywork:@"附加2"]];
    [dataArray addObject:[self commonFilterRegionModelWithKeywork:@"附加3"]];
    [dataArray addObject:[self commonFilterRegionModelWithKeywork:@"附加4"]];
    [dataArray addObject:[self commonFilterRegionModelWithKeywork:@"附加5"]];
    return [dataArray mutableCopy];
}

- (ZYSideSlipFilterRegionModel *)commonFilterRegionModelWithKeywork:(NSString *)keywork {
    ZYSideSlipFilterRegionModel *model = [[ZYSideSlipFilterRegionModel alloc] init];
    model.containerCellClass = @"SideSlipCommonTableViewCell";
    model.regionTitle = keywork;
    model.itemList = @[[self createItemModelWithTitle:@"first" itemId:@"0000" selected:NO],
                       [self createItemModelWithTitle:@"second" itemId:@"0001" selected:NO],
                       [self createItemModelWithTitle:@"third" itemId:@"0002" selected:NO],
                       [self createItemModelWithTitle:@"fourth" itemId:@"0003" selected:NO],
                       [self createItemModelWithTitle:@"fifth" itemId:@"0004" selected:NO],
                       [self createItemModelWithTitle:@"sixth" itemId:@"0005" selected:NO],
                       [self createItemModelWithTitle:@"seventh" itemId:@"0006" selected:NO],
                       [self createItemModelWithTitle:@"eighth" itemId:@"0007" selected:NO],
                       [self createItemModelWithTitle:@"ninth" itemId:@"0008" selected:NO],
                       [self createItemModelWithTitle:@"tenth" itemId:@"0009" selected:NO]
                       ];
    return model;
}

- (CommonItemModel *)createItemModelWithTitle:(NSString *)itemTitle
                                       itemId:(NSString *)itemId
                                     selected:(BOOL)selected {
    CommonItemModel *model = [[CommonItemModel alloc] init];
    model.itemId = itemId;
    model.itemName = itemTitle;
    model.selected = selected;
    return model;
}

- (ZYSideSlipFilterRegionModel *)serviceFilterRegionModel {
    ZYSideSlipFilterRegionModel *model = [[ZYSideSlipFilterRegionModel alloc] init];
    model.containerCellClass = @"SideSlipServiceTableViewCell";
    model.regionTitle = @"配送服务";
    model.itemList = @[[self createItemModelWithTitle:@"商城配送" itemId:@"0000" selected:NO],
                       [self createItemModelWithTitle:@"货到付款" itemId:@"0001" selected:NO],
                       [self createItemModelWithTitle:@"包邮" itemId:@"0002" selected:NO],
                       [self createItemModelWithTitle:@"移动专享" itemId:@"0003" selected:NO],
                       [self createItemModelWithTitle:@"全球购" itemId:@"0004" selected:NO]
                       ];
    return model;
}

- (ZYSideSlipFilterRegionModel *)priceFilterRegionModel {
    ZYSideSlipFilterRegionModel *model = [[ZYSideSlipFilterRegionModel alloc] init];
    model.containerCellClass = @"SideSlipPriceTableViewCell";
    model.regionTitle = @"价格区间";
    return model;
}

- (ZYSideSlipFilterRegionModel *)allCategoryFilterRegionModel {
    ZYSideSlipFilterRegionModel *model = [[ZYSideSlipFilterRegionModel alloc] init];
    model.containerCellClass = @"SideSlipAllCategoryTableViewCell";
    model.regionTitle = @"全部分类";
    return model;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
