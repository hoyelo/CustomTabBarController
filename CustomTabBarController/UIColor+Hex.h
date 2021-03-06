//
//  UIColor+Hex.h
//  CustomTabBarController
//
//  Created by Victor Zhu on 4/14/15.
//  Copyright (c) 2015 IQI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHexRGB:(NSUInteger)hex;
+ (UIColor *)colorWithHexRGB:(NSUInteger)hex alpha:(CGFloat)alpha;

@end
