//
//  ZYSideSlipFilterController.h
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SideSlipFilterCommitBlock)(NSArray *dataList);
typedef void (^SideSlipFilterResetBlock)(NSArray *dataList);

@interface ZYSideSlipFilterController : UIViewController
@property (assign, nonatomic) CGFloat animationDuration;
@property (assign, nonatomic) CGFloat sideSlipLeading;
@property (copy, nonatomic) NSArray *dataList;
- (instancetype)initWithSponsor:(UIViewController *)sponsor
                     resetBlock:(SideSlipFilterResetBlock)resetBlock
                    commitBlock:(SideSlipFilterCommitBlock)commitBlock;
- (void)show;
- (void)dismiss;
- (void)reloadData;
@end
