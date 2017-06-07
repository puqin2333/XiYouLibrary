//
//  AppDelegate.m
//  西邮图书馆
//
//  Created by 陈普钦 on 16/11/14.
//  Copyright (c) 2016年 陈普钦. All rights reserved.
//

#import "AppDelegate.h"
#import "CCLibraryController.h"
#import "CCNewsController.h"
#import "CCSystemController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];
    
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    
    CCLibraryController *labVC = [[CCLibraryController alloc] init];
    UINavigationController *labNAV = [[UINavigationController alloc] initWithRootViewController:labVC];
    
    CCNewsController *newsVC = [[CCNewsController alloc] init];
    UINavigationController *newsNAV = [[UINavigationController alloc] initWithRootViewController:newsVC];
    
    CCSystemController *systemVC = [[CCSystemController alloc] init];
    UINavigationController *systemNAV = [[UINavigationController alloc] initWithRootViewController:systemVC];
    
    labVC.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];

    newsVC.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];

    systemVC.view.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];

    
    NSArray *VCArray = [NSArray arrayWithObjects:newsNAV,labNAV,systemNAV, nil];
    tabBarVC.viewControllers = VCArray;
    
    tabBarVC.tabBar. barStyle = UIBarStyleDefault;
    tabBarVC.tabBar.backgroundColor = [UIColor blueColor];
    tabBarVC.tabBar.translucent = NO;
    

    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
