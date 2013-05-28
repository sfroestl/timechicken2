//
//  AppDelegate.m
//  TimeChicken
//
//  Created by Christian Schäfer on 15.01.13.
//  Copyright (c) 2013 Christian Schäfer. All rights reserved.
//

#import "AppDelegate.h"
#import "TaskListVC.h"
#import "TCTaskStore.h"
#import "TCWebserviceStore.h"
#import "UIColor+TimeChickenAdditions.h"
#import "UIImage+TimeChickenAdditions.h"
#import "WebserviceListVC.h"
#import "TimeSessionListVC.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"App started!");
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *taskListViewController = [[TaskListVC alloc] init];
    UIViewController *webserviceVC = [[WebserviceListVC alloc] init];
    
    // TaskList Navigation Controller    
    UINavigationController *taskListNavC = [[UINavigationController alloc] initWithRootViewController:taskListViewController];
    UITabBarItem *tab1 = [[UITabBarItem alloc] initWithTitle:@"Tasks" image:[UIImage imageNamed:@"tasks-icon"] tag:1];    
    [tab1 setFinishedSelectedImage:[UIImage imageNamed:@"tasks-icon"] withFinishedUnselectedImage:nil];
    [taskListNavC setTabBarItem:tab1];
    
    // Webservices Navigation Controller
    UINavigationController *webserviceNavC = [[UINavigationController alloc] initWithRootViewController:webserviceVC];
    UITabBarItem *tab2 = [[UITabBarItem alloc] initWithTitle:@"Import Tasks" image:[UIImage imageNamed:@"cloud-icon.png"] tag:2];
    [tab2 setFinishedSelectedImage:[UIImage imageNamed:@"cloud-icon"] withFinishedUnselectedImage:nil];
    [webserviceNavC setTabBarItem:tab2];    
        
//    UINavigationBar *navigationBar = [UINavigationBar appearance];
//	[navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-background"] forBarMetrics:UIBarMetricsDefault];

    
    UINavigationBar *taskBar = [taskListNavC navigationBar];
    [taskBar setTintColor:[UIColor tcThemeColor]];
//    [taskBar setBackgroundImage:[UIImage tcNavBackgroundMini] forBarMetrics:UIBarMetricsDefault];
//    [taskBar setBackgroundImage:[UIImage tcNavBackgroundMini] forBarMetrics:UIBarMetricsLandscapePhone];
    
    UINavigationBar *wsBar = [webserviceNavC navigationBar];
    [wsBar setTintColor:[UIColor tcThemeColor]];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[taskListNavC, webserviceNavC];

    //Adds Badge for openTasks
//    if ([[[TCTaskStore taskStore]tasks]count] == 0)
//        [[self.tabBarController.tabBar.items objectAtIndex:0] setBadgeValue:nil];
//    else
//        [[self.tabBarController.tabBar.items objectAtIndex:0] setBadgeValue:[NSString stringWithFormat:@"%d", [[[TCTaskStore taskStore] getOpenTasks]count]]];
    
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //persistent saving to files, when app goes in background
    BOOL successTasks = [[TCTaskStore taskStore] saveChanges];
    if(successTasks){
        NSLog(@"Saved all of the tasks");
    }
    else{
        NSLog(@"Could not save any of the Tasks");
    }
    
    BOOL successWebservices = [[TCWebserviceStore wsStore] saveChanges];
    if(successWebservices){
        NSLog(@"Saved all of the webservices");
    }
    else{
        NSLog(@"Could not save any of the Webservices");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
