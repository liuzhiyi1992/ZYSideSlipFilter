//
//  ZYSideSlipFilterConfig.h
//  ZYSideSlipFilter
//
//  Created by zhiyi on 16/10/17.
//  Copyright © 2016年 zhiyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface ZYSideSlipFilterConfig : NSObject
#define LocalString(s) NSLocalizedString(s, nil)

//color
extern NSString * const FILTER_RED_STRING;
extern NSString * const FILTER_BLACK_STRING;
extern NSString * const FILTER_COLLECTION_ITEM_COLOR_NORMAL_STRING;
extern NSString * const FILTER_COLLECTION_ITEM_COLOR_SELECTED_STRING;

//UI
extern CGFloat const BOTTOM_BUTTON_FONT_SIZE;
@end
