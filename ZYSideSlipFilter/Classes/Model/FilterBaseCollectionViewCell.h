//
//  FilterBaseCollectionViewCell.h
//  ZYSideSlipFilter
//
//  Created by lzy on 16/10/15.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonItemModel.h"

@interface FilterBaseCollectionViewCell : UICollectionViewCell
+ (NSString *)cellReuseIdentifier;
- (void)updateCellWithModel:(CommonItemModel *)model;
- (void)tap2SelectItem:(BOOL)selected;
@end
