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
+ (void)showSideSlipFilter:(UIViewController *)sponsor commitBlock:(SideSlipFilterCommitBlock)commitBlock;
@end
