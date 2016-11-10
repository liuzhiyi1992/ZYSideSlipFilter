//
//  SideSlipCommonTableViewCell.h
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideSlipBaseTableViewCell.h"

typedef NS_ENUM(NSUInteger, CommonTableViewCellSelectionType) {
    BrandTableViewCellSelectionTypeSingle = 0,                  //单选
    BrandTableViewCellSelectionTypeMultiple = 1,                //双选
};

/**
 数据源model customDict中可配置的key_value
 */
#define REGION_SELECTION_TYPE @"REGION_SELECTION_TYPE"

@interface SideSlipCommonTableViewCell : SideSlipBaseTableViewCell <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@end
