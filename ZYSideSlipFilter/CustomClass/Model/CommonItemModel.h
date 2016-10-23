//
//  CommonItemModel.h
//  ZYSideSlipFilter
//
//  Created by lzy on 16/10/16.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonItemModel : NSObject
@property (copy, nonatomic) NSString *itemId;
@property (copy, nonatomic) NSString *itemName;
@property (assign, nonatomic) BOOL selected;
@end
