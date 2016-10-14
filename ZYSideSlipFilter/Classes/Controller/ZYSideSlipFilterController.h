//
//  ZYSideSlipFilterController.h
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/14.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SideSlipFilterCommitBlock)(NSDictionary *commitDict);

@interface ZYSideSlipFilterController : UIViewController
@property (assign, nonatomic) CGFloat animationDuration;
+ (void)showSideSlipFilterWithSponsor:(UIViewController *)sponsor commitBlock:(SideSlipFilterCommitBlock)commitBlock;
- (instancetype)initWithSponsor:(UIViewController *)sponsor;
- (void)show;
@end
