//
//  FilterBaseCollectionViewCell.m
//  ZYSideSlipFilter
//
//  Created by lzy on 16/10/15.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import "FilterBaseCollectionViewCell.h"

@implementation FilterBaseCollectionViewCell
+ (NSString *)cellReuseIdentifier {
    NSAssert(NO, @"\nERROR: Must realize this function in subClass %s", __func__);
    return @"";
}
@end
