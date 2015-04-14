//
//  UIImage+Colors.h
//  CustomTabBarController
//
//  Created by Victor Zhu on 4/14/15.
//  Copyright (c) 2015 IQI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Colors)

+ (UIImage *)imageFromSize:(CGSize)size block:(void(^)(CGContextRef))block;
+ (UIImage *)imageFromColors:(NSArray *)colors verticalLocations:(NSArray *)locationsObjects size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;

@end
