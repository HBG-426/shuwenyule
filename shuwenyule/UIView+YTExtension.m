//
//  UIView+YTExtension.m
//  shuwenyule
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "UIView+YTExtension.h"

@implementation UIView (YTExtension)

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat )centerX {
    
    CGPoint cender = self.center;
    
    cender.x = centerX;
    
    self.center = cender;
}

- (void)setCenterY:(CGFloat )centerY {
    
    CGPoint cender = self.center;
    
    cender.y = centerY;
    
    self.center = cender;
}

- (CGFloat)centerX {
    
    return self.center.x;
}
- (CGFloat)centerY {
    
    return self.center.y;
}
@end
