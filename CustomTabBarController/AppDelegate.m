//
//  AppDelegate.m
//  CustomTabBarController
//
//  Created by Victor Zhu on 4/14/15.
//  Copyright (c) 2015 IQI. All rights reserved.
//

#import "AppDelegate.h"
#import "UIColor+Hex.h"
#import "UIImage+Colors.h"
#import "CustomTabBarController.h"
#import "HomeViewController.h"
#import "HistoryViewController.h"
#import "ProfileViewController.h"

@interface AppDelegate () <CustomTabBarControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[self loadAppearance];
	[self loadRootView];
	[self.window makeKeyAndVisible];
	return YES;
}

- (void)loadRootView
{
	UINavigationController *home = [[UINavigationController alloc] initWithRootViewController:[HomeViewController new]];
	home.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"home" image:nil tag:0];
	
	UINavigationController *history = [[UINavigationController alloc] initWithRootViewController:[HistoryViewController new]];
	history.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"history" image:nil tag:0];
	
	UINavigationController *camera = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
	camera.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"camera" image:nil tag:TABBAR_CAMERA_TAG];
	
	UINavigationController *profile = [[UINavigationController alloc] initWithRootViewController:[ProfileViewController new]];
	profile.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"profile" image:nil tag:0];
	
	UINavigationController *logout = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
	logout.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"logout" image:nil tag:0];
	
	CustomTabBarController *tabBar = [CustomTabBarController new];
	tabBar.delegate = self;
	tabBar.viewControllers = @[home, history, camera, profile, logout];
	self.window.rootViewController = tabBar;
}

- (void)loadAppearance
{
	self.window.backgroundColor = [UIColor whiteColor];
	id appearance = [SegmentedControl appearance];
	
	UIColor *offColor = [UIColor colorWithHexRGB:0x323A45];
	UIColor *onColor = [UIColor colorWithHexRGB:0x20252D];
	UIImage *leftOnDivider = [UIImage imageFromSize:CGSizeMake(1, 1) block:^(CGContextRef context) {
		CGRect rect = CGRectMake(0, 0, LINE_HEIGHT, 1);
		CGContextSetFillColorWithColor(context, [offColor CGColor]);
		CGContextFillRect(context, rect);
	}];
	UIImage *rightOnDivider = [UIImage imageFromSize:CGSizeMake(1, 1) block:^(CGContextRef context) {
		CGRect rect = CGRectMake(1 - LINE_HEIGHT, 0, LINE_HEIGHT, 1);
		CGContextSetFillColorWithColor(context, [offColor CGColor]);
		CGContextFillRect(context, rect);
	}];
	UIImage *offDivider = [UIImage imageFromSize:CGSizeMake(1, 1) block:^(CGContextRef context) {
		CGRect rect = CGRectMake(1 - LINE_HEIGHT, 0, LINE_HEIGHT, 1);
		CGContextSetFillColorWithColor(context, [offColor CGColor]);
		CGContextFillRect(context, rect);
	}];
	
	[appearance setDividerImage:leftOnDivider forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	[appearance setDividerImage:rightOnDivider forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
	[appearance setDividerImage:offDivider forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	
	UIImage *offImage = [UIImage imageFromColors:@[offColor]
							   verticalLocations:@[@1]
											size:CGSizeMake(1, TABBAR_HEIGHT)
									cornerRadius:0];
	
	UIImage *onImage = [UIImage imageFromColors:@[onColor]
							  verticalLocations:@[@1]
										   size:CGSizeMake(1, TABBAR_HEIGHT)
								   cornerRadius:0];
	
	[appearance setBackgroundImage:offImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	[appearance setBackgroundImage:onImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
	[appearance setBackgroundImage:onImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
}

#pragma mark - CustomTabBarControllerDelegate

- (void)tabBarController:(CustomTabBarController *)controller didSelectViewController:(UIViewController *)viewController atIndex:(NSInteger)index
{
	NSLog(@"Select %ld", (long)index);
}

- (void)tabBarControllerDidTapCamera:(CustomTabBarController *)controller
{
	[[[UIAlertView alloc] initWithTitle:nil message:@"Tap camera" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
}

- (void)tabBarControllerDidTapLogout:(CustomTabBarController *)controller
{
	[[[UIAlertView alloc] initWithTitle:nil message:@"Do you want to logout?" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout", nil] show];
}

@end
