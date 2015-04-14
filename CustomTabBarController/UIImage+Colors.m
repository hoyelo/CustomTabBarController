//
//  UIImage+Colors.m
//  CustomTabBarController
//
//  Created by Victor Zhu on 4/14/15.
//  Copyright (c) 2015 IQI. All rights reserved.
//

#import "UIImage+Colors.h"

@implementation UIImage (Colors)

+ (UIImage *)imageFromSize:(CGSize)size block:(void(^)(CGContextRef))block
{
	UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
	block(context);
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}

+ (UIImage *)imageFromColors:(NSArray *)colors verticalLocations:(NSArray *)locationsObjects size:(CGSize)size cornerRadius:(CGFloat)cornerRadius
{
	return [self imageFromSize:size block:^(CGContextRef context) {
		CGRect rect = (CGRect){.size = size};
		UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
		CGContextAddPath(context, path.CGPath);
		
		NSMutableArray *convertedColorArray = [NSMutableArray arrayWithCapacity:colors.count];
		for (UIColor *color in colors) {
			[convertedColorArray addObject:(__bridge id)[color CGColor]];
		}
		
		CGFloat locations[locationsObjects.count];
		for (int i = 0; i < locationsObjects.count; i++) {
			locations[i] = [locationsObjects[i] floatValue];
		}
		CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
		CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)convertedColorArray, locations);
		CFRelease(colorSpace);
		CGContextClip(context);
		CGContextDrawLinearGradient(context, gradient, CGPointMake(0.5, 0), CGPointMake(0.5, size.height), 0);
		CFRelease(gradient);
	}];
}

@end
