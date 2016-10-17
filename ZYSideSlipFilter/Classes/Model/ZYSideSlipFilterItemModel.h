//
//  ZYSideSlipFilterItemModel.h
//  ZYSideSlipFilter
//
//  Created by lzy on 16/10/15.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYSideSlipFilterItemModel : NSObject
@property (copy, nonatomic) NSString *containerCellClass;
//@property (strong, nonatomic) NSDictionary *dataDict;//title. content
@property (copy, nonatomic) NSString *regionTitle;
@property (strong, nonatomic) NSArray *itemList;
@property (assign, nonatomic) BOOL isShowAll;
@end
