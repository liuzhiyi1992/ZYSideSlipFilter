//
//  ZYSideSlipFilterRegionModel.h
//  ZYSideSlipFilter
//
//  Created by lzy on 16/10/15.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYSideSlipFilterRegionModel : NSObject
@property (copy, nonatomic) NSString *containerCellClass;
@property (copy, nonatomic) NSString *regionTitle;
@property (strong, nonatomic) NSArray *itemList;
@property (assign, nonatomic) BOOL isShowAll;
@property (strong, nonatomic) NSArray *selectedItemList;//hold selectedItem orderly
@property (strong, nonatomic) NSDictionary *customDict;//hold custom Data;
@end
