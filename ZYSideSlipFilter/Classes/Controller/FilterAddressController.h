//
//  FilterAddressController.h
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/19.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressModel;
@protocol FilterAddressControllerDelegate <NSObject>
- (void)addressControllerDidSelectedAddress:(AddressModel *)addressModel;
@end

@interface FilterAddressController : UIViewController
@property (weak, nonatomic) id<FilterAddressControllerDelegate> delegate;
- (instancetype)initWithDataList:(NSArray *)dataList selectedAddressId:(NSString *)selectedAddressId;
@end
