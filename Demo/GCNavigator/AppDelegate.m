//
//  AppDelegate.m
//  GCNavigator
//
//  Created by 陈嘉豪 on 2018/10/25.
//  Copyright © 2018 Gill Chan. All rights reserved.
//

#import "AppDelegate.h"
#import "SYTabBarController.h"
#import "GCNavigator.h"
#import "HomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 注册
    [GCSharedNavigator configName:@"GCNavigatorRegistry"];
    // 初始化 ViewController
    SYTabBarController *tabController = [[SYTabBarController alloc]init];
    HomeViewController *home = [[HomeViewController alloc]init];
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:home];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:tabController];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
