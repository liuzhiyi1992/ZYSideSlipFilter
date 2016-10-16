//
//  UIView+Utils.m
//  Sport
//
//  Created by haodong  on 13-6-25.
//  Copyright (c) 2013年 haodong . All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

- (void)updateOriginX:(CGFloat)originX
{
    self.frame = CGRectMake(originX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)updateOriginY:(CGFloat)originY
{
    self.frame = CGRectMake(self.frame.origin.x, originY, self.frame.size.width, self.frame.size.height);
}

- (void)updateCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (void)updateCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (void)updateWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (void)updateHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (void)roundSide:(CornerSide)side
             size:(CGFloat)size
      borderColor:(CGColorRef )cGColor
      borderWidth:(CGFloat)width {
    UIBezierPath *maskPath;
    
    if (side == CornerSideLeft) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft)
                                               cornerRadii:CGSizeMake(size, size)];
    }else if (side == CornerSideRight) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight)
                                               cornerRadii:CGSizeMake(size, size)];
        
    } else {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:UIRectCornerAllCorners
                                               cornerRadii:CGSizeMake(size, size)];
        
    }
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the image view's layer
    self.layer.mask = maskLayer;
    
    //Add border
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.path = maskLayer.path;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = cGColor;
    borderLayer.lineWidth = width;
    borderLayer.frame = self.bounds;
    [self.layer addSublayer:borderLayer];
    
    [self.layer setMasksToBounds:YES];
}

- (void)findControllerWithResultController:(UIViewController **)resultController {
    UIResponder *responder = [self nextResponder];
    if (nil == responder) {
        return;
    }
    if ([responder isKindOfClass:[UIViewController class]]) {
        *resultController = (UIViewController *)responder;
    } else if ([responder isKindOfClass:[UIView class]]) {
        [(UIView *)responder findControllerWithResultController:resultController];
    }
}

@end
