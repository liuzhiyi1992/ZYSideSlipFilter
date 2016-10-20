//
//  AddressModel.h
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/20.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SELECTED_ADDRESS @"SELECTED_ADDRESS"

@interface AddressModel : NSObject
@property (copy, nonatomic) NSString *addressId;
@property (copy, nonatomic) NSString *addressString;
@end
