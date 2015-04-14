//
//  TabBarController.m
//  CustomTabBarController
//
//  Created by Victor Zhu on 4/14/15.
//  Copyright (c) 2015 IQI. All rights reserved.
//

#import "TabBarController.h"
#import "UIColor+Hex.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.tabBar.barTintColor = [UIColor colorWithHexRGB:0x323A45];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self addCenterButtonWithImage:[UIImage imageNamed:@"camera_off"] highlightImage:nil];
}

- (CGFloat)tabBarItemWidth
{
	NSInteger count = self.viewControllers.count;
	return CGRectGetWidth(self.tabBar.bounds) / count;
}

- (void)addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage
{
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
	[button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
	button.frame = CGRectMake(0, 0, self.tabBarItemWidth, CGRectGetHeight(self.tabBar.bounds));
	[button setImage:buttonImage forState:UIControlStateNormal];
	[button setImage:highlightImage forState:UIControlStateHighlighted];
	
	CGFloat heightDifference = buttonImage.size.height - CGRectGetHeight(self.tabBar.bounds);
	if (heightDifference < 0) {
		button.center = self.tabBar.center;
	} else {
		CGPoint center = self.tabBar.center;
		center.y = center.y - heightDifference / 2;
		button.center = center;
	}
	[self.view addSubview:button];
}

- (void)buttonPressed:(id)sender
{
	[[[UIAlertView alloc] initWithTitle:nil message:@"Tap camera" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
}

@end
