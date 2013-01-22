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

#import "WebserviceListVC.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"App started!");
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *taskListViewController = [[TaskListVC alloc] init];
    UIViewController *webserviceVC = [[WebserviceListVC alloc] init];
    
    UINavigationController *taskListNavC = [[UINavigationController alloc] initWithRootViewController:taskListViewController];
    UINavigationController *webserviceNavC = [[UINavigationController alloc] initWithRootViewController:webserviceVC];
    
    UINavigationBar *taskBar = [taskListNavC navigationBar];
    [taskBar setTintColor:[UIColor colorWithRed:0.0f/255.0f green:109.0f/255.0f blue:14.0f/255.0f alpha:1.0f]];
    
    UINavigationBar *wsBar = [webserviceNavC navigationBar];
    [wsBar setTintColor:[UIColor colorWithRed:0.0f/255.0f green:109.0f/255.0f blue:14.0f/255.0f alpha:1.0f]];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[taskListNavC, webserviceNavC];
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
    //persistent saving to file, when app goes in background
    BOOL success = [[TCTaskStore taskStore] saveChanges];
    if(success){
        NSLog(@"Saved all of the tasks");
    }
    else{
        NSLog(@"Could not save any of the Tasks");
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
