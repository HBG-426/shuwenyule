//
//  UIView+YTExtension.h
//  shuwenyule
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YTExtension)

/**宽度*/
@property (nonatomic,assign) CGFloat width;
/**高度*/
@property (nonatomic,assign) CGFloat height;
/**X值*/
@property (nonatomic,assign) CGFloat x;
/**Y值*/
@property (nonatomic,assign) CGFloat y;
/**中心点的X*/
@property (nonatomic,assign) CGFloat centerX;
/**中心点的Y*/
@property (nonatomic,assign) CGFloat centerY;

// 在分类重中写属性只会声明 set get 方法的声明

@end
