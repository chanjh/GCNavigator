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
    NSArray *registry = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"GCNavigatorRegistry" ofType:@"plist"]];
    for (NSDictionary *meg in registry){
        NSString *className;
        NSURL *url;
        if([meg valueForKey:@"className"]){
            className = meg[@"className"];
        }
        if([meg valueForKey:@"url"]){
            url = [NSURL URLWithString:meg[@"url"]];
        }
        if(className && url){
            [GCSharedNavigator registerURL:url targetTo:NSClassFromString(className)];
        }
    }
    
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
