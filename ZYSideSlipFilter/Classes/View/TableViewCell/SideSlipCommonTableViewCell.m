//
//  SideSlipCommonTableViewCell.m
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "SideSlipCommonTableViewCell.h"
#import "FilterCommonCollectionViewCell.h"

@interface SideSlipCommonTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *controlIcon;
@property (weak, nonatomic) IBOutlet UILabel *controlLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;
@property (strong, nonatomic) NSArray *dataList;
@end

@implementation SideSlipCommonTableViewCell
+ (NSString *)cellReuseIdentifier {
    return @"SideSlipCommonTableViewCell";
}

+ (instancetype)createCell {
    SideSlipCommonTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"SideSlipCommonTableViewCell" owner:nil options:nil][0];
    cell.mainCollectionView.delegate = cell;
    cell.mainCollectionView.dataSource = cell;
    [cell.mainCollectionView registerClass:[FilterCommonCollectionViewCell class] forCellWithReuseIdentifier:[FilterCommonCollectionViewCell cellReuseIdentifier]];
    return cell;
}

- (void)updateCellWithDataDict:(NSDictionary *)dataDict {
    //title
    [self.titleLabel setText:dataDict[@"title"]];
    //content
    NSArray *itemsArray = dataDict[@"content"];
    self.dataList = itemsArray;
    [_mainCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FilterCommonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[FilterCommonCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
    NSDictionary *dataDict = [_dataList objectAtIndex:indexPath.row];
    [cell updateCellWithDataDict:dataDict];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(60, 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 8.f;
}

- (IBAction)clickShowMoreButton:(id)sender {
    NSLog(@"show more");
}







- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
