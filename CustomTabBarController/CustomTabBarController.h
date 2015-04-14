//
//  CustomTabBarController.h
//  CustomTabBarController
//
//  Created by Victor Zhu on 4/14/15.
//  Copyright (c) 2015 IQI. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LINE_HEIGHT			1 / [UIScreen mainScreen].scale
#define TABBAR_HEIGHT		40
#define TABBAR_CAMERA_TAG	10
#define TABBAR_CAMERA_WIDTH (56 - 2 * LINE_HEIGHT)

@protocol CustomTabBarControllerDelegate;

@interface SegmentedControl : UISegmentedControl
@end

@interface CustomTabBarController : UIViewController

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic) NSUInteger selectedIndex;
@property (nonatomic, weak) id <CustomTabBarControllerDelegate> delegate;

@end

@protocol CustomTabBarControllerDelegate <NSObject>

- (void)tabBarController:(CustomTabBarController *)controller didSelectViewController:(UIViewController *)viewController atIndex:(NSInteger)index;
- (void)tabBarControllerDidTapCamera:(CustomTabBarController *)controller;
- (void)tabBarControllerDidTapLogout:(CustomTabBarController *)controller;

@end