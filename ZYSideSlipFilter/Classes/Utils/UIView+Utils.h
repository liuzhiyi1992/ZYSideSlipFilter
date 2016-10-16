//
//  UIView+Utils.h
//  Sport
//
//  Created by haodong  on 13-6-25.
//  Copyright (c) 2013年 haodong . All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,CornerSide) {
    CornerSideLeft = 0,
    CornerSideRight = 1,
    CornerSideAll = 2,
};
@interface UIView (Utils)

- (void)updateOriginX:(CGFloat)originX;
- (void)updateOriginY:(CGFloat)originY;
- (void)updateCenterX:(CGFloat)centerX;
- (void)updateCenterY:(CGFloat)centerY;
- (void)updateWidth:(CGFloat)width;
- (void)updateHeight:(CGFloat)height;
- (void)roundSide:(CornerSide)side
             size:(CGFloat)size
      borderColor:(CGColorRef )cGColor
      borderWidth:(CGFloat)width;
- (void)findControllerWithResultController:(UIViewController **)resultController;
@end
