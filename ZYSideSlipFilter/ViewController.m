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
#import "AddressModel.h"
#import "PriceRangeModel.h"
#import "SideSlipCommonTableViewCell.h"

@interface ViewController ()
@property (strong, nonatomic) ZYSideSlipFilterController *filterController;
@property (weak, nonatomic) IBOutlet UIButton *showFilterButton;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureShowFilterButton];
    self.filterController = [[ZYSideSlipFilterController alloc] initWithSponsor:self
                                                                     resetBlock:^(NSArray *dataList) {
        for (ZYSideSlipFilterRegionModel *model in dataList) {
            //selectedStatus
            for (CommonItemModel *itemModel in model.itemList) {
                [itemModel setSelected:NO];
            }
            //selectedItem
            model.selectedItemList = nil;
        }
    }                                                               commitBlock:^(NSArray *dataList) {
        //配送服务
        ZYSideSlipFilterRegionModel *serviceRegionModel = dataList[0];
        NSMutableString *serviceInfoString = [NSMutableString stringWithString:@"\n配送服务:\n"];
        NSMutableArray *serviceItemSelectedArray = [NSMutableArray array];
        AddressModel *addressModel = [serviceRegionModel.customDict objectForKey:SELECTED_ADDRESS];
        [serviceInfoString appendFormat:@"选中地址:%@-%@\n", addressModel.addressId, addressModel.addressString];
        for (CommonItemModel *itemModel in serviceRegionModel.itemList) {
            if (itemModel.selected) {
                [serviceItemSelectedArray addObject:[NSString stringWithFormat:@"%@-%@", itemModel.itemId, itemModel.itemName]];
            }
        }
        [serviceInfoString appendString:[serviceItemSelectedArray componentsJoinedByString:@", "]];
        NSLog(@"%@", serviceInfoString);
        
        //价格区间
        ZYSideSlipFilterRegionModel *priceRegionModel = dataList[1];
        PriceRangeModel *priceRangeModel = [priceRegionModel.customDict objectForKey:PRICE_RANGE_MODEL];
        NSMutableString *priceRangeString = [NSMutableString stringWithString:@"\n价格区间: "];
        if (priceRangeModel) {
            [priceRangeString appendFormat:@"%@ - %@", priceRangeModel.minPrice, priceRangeModel.maxPrice];
        }
        NSLog(@"%@", priceRangeString);
        
        //Common Region
        NSMutableString *commonRegionString = [NSMutableString string];
        for (int i = 4; i < dataList.count; i ++) {
            ZYSideSlipFilterRegionModel *commonRegionModel = dataList[i];
            [commonRegionString appendFormat:@"\n%@:", commonRegionModel.regionTitle];
            NSMutableArray *commonItemSelectedArray = [NSMutableArray array];
            for (CommonItemModel *itemModel in commonRegionModel.itemList) {
                if (itemModel.selected) {
                    [commonItemSelectedArray addObject:[NSString stringWithFormat:@"%@-%@", itemModel.itemId, itemModel.itemName]];
                }
            }
            [commonRegionString appendString:[commonItemSelectedArray componentsJoinedByString:@", "]];
        }
        NSLog(@"%@", commonRegionString);

    }];
    _filterController.animationDuration = .3f;
    _filterController.sideSlipLeading = 0.15*[UIScreen mainScreen].bounds.size.width;
    _filterController.dataList = [self packageDataList];
}

- (void)configureShowFilterButton {
    _showFilterButton.layer.shadowOffset = CGSizeMake(1, 1);
    _showFilterButton.layer.shadowOpacity = 0.6f;
    _showFilterButton.layer.shadowColor = [UIColor grayColor].CGColor;
}

- (IBAction)clickFilterButton:(id)sender {
    [_filterController show];
}

#pragma mark - 模拟数据源
- (NSArray *)packageDataList {
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:[self serviceFilterRegionModel]];
    [dataArray addObject:[self priceFilterRegionModel]];
    [dataArray addObject:[self allCategoryFilterRegionModel]];
    [dataArray addObject:[self spaceFilterRegionModel]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"品牌" selectionType:BrandTableViewCellSelectionTypeDouble]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"种类" selectionType:BrandTableViewCellSelectionTypeSingle]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"特性" selectionType:BrandTableViewCellSelectionTypeMultiple]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"适用场景" selectionType:BrandTableViewCellSelectionTypeDouble]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"重量" selectionType:BrandTableViewCellSelectionTypeMultiple]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"包装" selectionType:BrandTableViewCellSelectionTypeDouble]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"存储方式" selectionType:BrandTableViewCellSelectionTypeMultiple]];
    [dataArray addObject:[self commonFilterRegionModelWithKeyword:@"货仓" selectionType:BrandTableViewCellSelectionTypeMultiple]];
    return [dataArray mutableCopy];
}

- (ZYSideSlipFilterRegionModel *)commonFilterRegionModelWithKeyword:(NSString *)keyword selectionType:(CommonTableViewCellSelectionType)selectionType {
    ZYSideSlipFilterRegionModel *model = [[ZYSideSlipFilterRegionModel alloc] init];
    model.containerCellClass = @"SideSlipCommonTableViewCell";
    model.regionTitle = keyword;
    model.customDict = @{REGION_SELECTION_TYPE:@(selectionType)};
    model.itemList = @[[self createItemModelWithTitle:[NSString stringWithFormat:@"%@一", keyword] itemId:@"0000" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@二", keyword] itemId:@"0001" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@三", keyword] itemId:@"0002" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@四", keyword] itemId:@"0003" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@五", keyword] itemId:@"0004" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@六", keyword] itemId:@"0005" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@七", keyword] itemId:@"0006" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@八", keyword] itemId:@"0007" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@九", keyword] itemId:@"0008" selected:NO],
                       [self createItemModelWithTitle:[NSString stringWithFormat:@"%@十", keyword] itemId:@"0009" selected:NO]
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
    model.customDict = @{ADDRESS_LIST:[self generateAddressDataList]};
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

- (ZYSideSlipFilterRegionModel *)spaceFilterRegionModel {
    ZYSideSlipFilterRegionModel *model = [[ZYSideSlipFilterRegionModel alloc] init];
    model.containerCellClass = @"SideSlipSpaceTableViewCell";
    return model;
}

- (NSArray *)generateAddressDataList {
    return @[[self createAddressModelWithAddress:@"广州市天河区猎德地铁站" addressId:@"0000"],
             [self createAddressModelWithAddress:@"广州市天河区珠江新城地铁站" addressId:@"0001"],
             [self createAddressModelWithAddress:@"广州市天河区潭村地铁站" addressId:@"0002"],
             [self createAddressModelWithAddress:@"广州市天河区黄埔大道西地铁站" addressId:@"0003"],
             [self createAddressModelWithAddress:@"广州市天河区员村街道员村地铁站临江大道员村二横路自编25号" addressId:@"0004"],
             [self createAddressModelWithAddress:@"广州市天河区昌岗地铁站" addressId:@"0005"]];
}

- (AddressModel *)createAddressModelWithAddress:(NSString *)address addressId:(NSString *)addressId {
    AddressModel *model = [[AddressModel alloc] init];
    model.addressString = address;
    model.addressId = addressId;
    return model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

