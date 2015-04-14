//
//  CustomTabBarController.m
//  CustomTabBarController
//
//  Created by Victor Zhu on 4/14/15.
//  Copyright (c) 2015 IQI. All rights reserved.
//

#import "CustomTabBarController.h"
#import "UIColor+Hex.h"

@implementation SegmentedControl

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSInteger oldValue = self.selectedSegmentIndex;
	[super touchesEnded:touches withEvent:event];
	if (oldValue == self.selectedSegmentIndex) {
		[self sendActionsForControlEvents:UIControlEventValueChanged];
	}
}

@end

@interface CustomTabBarController ()

@property (nonatomic, strong) SegmentedControl *tabsControl;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIViewController *selectedViewController;

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.edgesForExtendedLayout = UIRectEdgeNone;
	self.view.backgroundColor = [UIColor clearColor];
	
	UIView *containerView = [UIView new];
	containerView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:_containerView = containerView];
	
	SegmentedControl *tabsControl = [SegmentedControl new];
	tabsControl.translatesAutoresizingMaskIntoConstraints = NO;
	tabsControl.tintColor = [UIColor clearColor];
	tabsControl.backgroundColor = [UIColor colorWithHexRGB:0x323A45];
	[tabsControl addTarget:self action:@selector(changeTabs:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:_tabsControl = tabsControl];
	
	UIButton *cameraButton = [UIButton new];
	cameraButton.translatesAutoresizingMaskIntoConstraints = NO;
	[cameraButton setImage:[UIImage imageNamed:@"camera_off"] forState:UIControlStateNormal];
	[cameraButton addTarget:self action:@selector(cameraDidTap:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:cameraButton];
	
	NSDictionary *metrics = @{@"TABBAR_HEIGHT": @TABBAR_HEIGHT};
	NSDictionary *views = NSDictionaryOfVariableBindings(containerView, tabsControl, cameraButton);
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[containerView]|" options:0 metrics:nil views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView][tabsControl(TABBAR_HEIGHT)]|" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:metrics views:views]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:cameraButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:tabsControl attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:cameraButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:tabsControl attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
	
	[self loadAllTabs];
}

- (void)setViewControllers:(NSArray *)viewControllers
{
	_viewControllers = viewControllers;
	if (self.isViewLoaded) {
		[self loadAllTabs];
	}
}

- (void)loadAllTabs
{
	[self.tabsControl removeAllSegments];
	NSInteger count = self.viewControllers.count;
	[self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *controller, NSUInteger idx, BOOL *stop) {
		[self.tabsControl insertSegmentWithTitle:controller.tabBarItem.title atIndex:idx animated:NO];
		if (controller.tabBarItem.tag == TABBAR_CAMERA_TAG) {
			[self.tabsControl setWidth:TABBAR_CAMERA_WIDTH forSegmentAtIndex:idx];
			[self.tabsControl setEnabled:NO forSegmentAtIndex:idx];
		}
		if (idx == count - 1) {
			self.selectedIndex = 0;
			*stop = YES;
		}
	}];
}

- (void)updateTabs
{
	[self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *controller, NSUInteger idx, BOOL *stop) {
		NSString *imageName = [NSString stringWithFormat:@"%@_%@", controller.tabBarItem.title, self.selectedIndex == idx ? @"on": @"off"];
		UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		[self.tabsControl setImage:image forSegmentAtIndex:idx];
	}];
}

- (void)changeTabs:(UISegmentedControl *)tabsControl
{
	if (tabsControl.selectedSegmentIndex == tabsControl.numberOfSegments - 1) {
		tabsControl.selectedSegmentIndex = self.selectedIndex;
		[self.delegate tabBarControllerDidTapLogout:self];
		return;
	}
	self.selectedIndex = tabsControl.selectedSegmentIndex;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
	_selectedIndex = selectedIndex;
	if (self.tabsControl.numberOfSegments > selectedIndex) {
		self.tabsControl.selectedSegmentIndex = selectedIndex;
		if (self.isViewLoaded) {
			[self showControllerAtIndex:selectedIndex];
		}
	}
	[self updateTabs];
}

- (void)showControllerAtIndex:(NSUInteger)index
{
	UIViewController *newController = self.viewControllers[index];
	UIViewController *oldController = self.selectedViewController;
	self.selectedViewController = newController;
	
	if (oldController == newController) {
		[self.delegate tabBarController:self didSelectViewController:newController atIndex:index];
		return;
	}
	
	if (oldController) {
		[oldController willMoveToParentViewController:nil];
		[oldController.view removeFromSuperview];
		[oldController removeFromParentViewController];
	}
	
	if (newController) {
		[self addChildViewController:newController];
		newController.view.frame = self.containerView.frame;
		[self.containerView addSubview:newController.view];
		[newController didMoveToParentViewController:self];
	}
	[self.delegate tabBarController:self didSelectViewController:newController atIndex:index];
}

- (void)cameraDidTap:(id)sender
{
	[self.delegate tabBarControllerDidTapCamera:self];
}

@end
