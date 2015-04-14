//
//  UIColor+Hex.m
//  CustomTabBarController
//
//  Created by Victor Zhu on 4/14/15.
//  Copyright (c) 2015 IQI. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHexRGB:(NSUInteger)hex
{
	return [self colorWithHexRGB:hex alpha:1];
}

+ (UIColor *)colorWithHexRGB:(NSUInteger)hex alpha:(CGFloat)alpha
{
	CGFloat ff = 255.f;
	CGFloat r = ((hex & 0xff0000) >> 16) / ff;
	CGFloat g = ((hex & 0xff00) >> 8) / ff;
	CGFloat b = (hex & 0xff) / ff;
	return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

@end
