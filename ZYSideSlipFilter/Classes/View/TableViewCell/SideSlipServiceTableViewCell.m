//
//  SideSlipServiceTableViewCell.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "SideSlipServiceTableViewCell.h"
#import "ZYSideSlipFilterRegionModel.h"
#import "CommonItemModel.h"
#import "FilterCommonCollectionViewCell.h"
#import "UIView+Utils.h"

#define LINE_SPACE_COLLECTION_ITEM 8
#define GAP_COLLECTION_ITEM 8
#define NUM_OF_ITEM_ONCE_ROW 3.f
#define ITEM_WIDTH ((self.frame.size.width - (NUM_OF_ITEM_ONCE_ROW+1)*GAP_COLLECTION_ITEM)/NUM_OF_ITEM_ONCE_ROW)
#define ITEM_HEIGHT 25

@interface SideSlipServiceTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *addressButton;
@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;
@property (strong, nonatomic) ZYSideSlipFilterRegionModel *regionModel;
@property (strong, nonatomic) NSArray *dataList;
@property (strong, nonatomic) NSMutableArray *selectedItemList;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
@end

@implementation SideSlipServiceTableViewCell
+ (NSString *)cellReuseIdentifier {
    return @"SideSlipServiceTableViewCell";
}

+ (instancetype)createCellWithIndexPath:(NSIndexPath *)indexPath {
    SideSlipServiceTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"SideSlipServiceTableViewCell" owner:nil options:nil][0];
    [cell configureCell];
    return cell;
}

- (void)configureCell {
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    _mainCollectionView.contentInset = UIEdgeInsetsMake(0, GAP_COLLECTION_ITEM, 0, GAP_COLLECTION_ITEM);
    [_mainCollectionView registerClass:[FilterCommonCollectionViewCell class] forCellWithReuseIdentifier:[FilterCommonCollectionViewCell cellReuseIdentifier]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)updateCellWithModel:(ZYSideSlipFilterRegionModel *__autoreleasing *)model {
    self.regionModel = *model;
    //title
    [_titleLabel setText:_regionModel.regionTitle];
    //content
    self.dataList = _regionModel.itemList;
    //UI
    [self fitCollectonViewHeight];
    [_mainCollectionView reloadData];
}

//根据数据源个数决定collectionView高度
- (void)fitCollectonViewHeight {
    CGFloat displayNumOfRow;
    displayNumOfRow = ceil(_dataList.count/NUM_OF_ITEM_ONCE_ROW);
    CGFloat collectionViewHeight = displayNumOfRow*ITEM_HEIGHT + (displayNumOfRow - 1)*LINE_SPACE_COLLECTION_ITEM;
    _collectionViewHeightConstraint.constant = collectionViewHeight;
    [_mainCollectionView updateHeight:collectionViewHeight];
}

- (BOOL)tap2SelectItem:(NSIndexPath *)indexPath {
    NSArray *itemArray = _regionModel.itemList;
    CommonItemModel *model = [itemArray objectAtIndex:indexPath.row];
    model.selected = !model.selected;
    [self updateSelectedItemListWithItem:model];
    return model.selected;
}

- (void)updateSelectedItemListWithItem:(CommonItemModel *)model {
    if (model.selected) {
        [self.selectedItemList addObject:model];
    } else {
        [self.selectedItemList removeObject:model];
    }
    //update Data
    _regionModel.selectedItemList = _selectedItemList;
}

#pragma mark - DataSource Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FilterCommonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[FilterCommonCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
    CommonItemModel *model = [_dataList objectAtIndex:indexPath.row];
    [cell updateCellWithModel:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return LINE_SPACE_COLLECTION_ITEM;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return GAP_COLLECTION_ITEM;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    FilterCommonCollectionViewCell *cell = (FilterCommonCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell tap2SelectItem:[self tap2SelectItem:indexPath]];
}
@end
