//
//  AppDelegate.m
//  UITabBarController
//
//  Created by Victor Zhu on 4/14/15.
//  Copyright (c) 2015 IQI. All rights reserved.
//

#import "AppDelegate.h"
#import "UIColor+Hex.h"
#import "TabBarController.h"
#import "HomeViewController.h"
#import "HistoryViewController.h"
#import "ProfileViewController.h"
#import "SettingsViewController.h"

@interface AppDelegate () <UITabBarControllerDelegate>

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
	home.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:[[UIImage imageNamed:@"home_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:0];
	
	UINavigationController *history = [[UINavigationController alloc] initWithRootViewController:[HistoryViewController new]];
	history.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"History" image:[[UIImage imageNamed:@"history_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:0];
	
	UINavigationController *camera = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
	camera.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:nil tag:0];
	
	UINavigationController *profile = [[UINavigationController alloc] initWithRootViewController:[ProfileViewController new]];
	profile.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:[[UIImage imageNamed:@"profile_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:0];
	
	UINavigationController *settings = [[UINavigationController alloc] initWithRootViewController:[SettingsViewController new]];
	settings.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:[[UIImage imageNamed:@"home_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:0];
	
	TabBarController *tabBar = [TabBarController new];
	tabBar.delegate = self;
	tabBar.viewControllers = @[home, history, camera, profile, settings];
	self.window.rootViewController = tabBar;
}

- (void)loadAppearance
{
	self.window.tintColor = [UIColor whiteColor];
}

#pragma mark - UITabBarController delegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
	NSLog(@"Select %lu", (unsigned long)tabBarController.selectedIndex);
}

@end
