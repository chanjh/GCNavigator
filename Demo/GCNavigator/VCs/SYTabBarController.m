//
//  SYTabBarController.m
//  搜韵
//
//  Created by 陈嘉豪 on 2018/3/24.
//  Copyright © 2018年 Gill Chan. All rights reserved.
//

#import "SYTabBarController.h"
#import "HomeViewController.h"

@interface SYTabBarController ()

@end

@implementation SYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabbar];
}

- (void)setupTabbar{
    HomeViewController *readVC = [[HomeViewController alloc]init];
    [self addChildViewController:readVC
                   withImageName:@"tab_read"
               selectedImageName:@"tab_read_selected"
                           withNavBar:YES];
    
    HomeViewController *VC2 = [[HomeViewController alloc]init];
    [self addChildViewController:VC2
                   withImageName:@"tab_discover"
               selectedImageName:@"tab_discover_selected"
                           withNavBar:NO];
    
    HomeViewController *VC3 = [[HomeViewController alloc]init];
    [self addChildViewController:VC3
                   withImageName:@"tab_write"
               selectedImageName:@"tab_write_selected"
                      withNavBar:YES];
    
    HomeViewController *VC4 = [[HomeViewController alloc]init];
    [self addChildViewController:VC4
                   withImageName:@"tab_personal"
               selectedImageName:@"tab_personal_selected"
                      withNavBar:YES];
    
}

- (void)addChildViewController:(UIViewController *)controller
                 withImageName:(NSString *)imageName
             selectedImageName:(NSString *)selectImageName
                    withNavBar:(BOOL)b_NavBar{
    UIViewController *resultVC;
    if(b_NavBar){
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        resultVC = nav;
    }else{
        resultVC = controller;
    }
    [resultVC.tabBarItem setImage:[UIImage imageNamed:imageName]];
    [resultVC.tabBarItem setSelectedImage:[UIImage imageNamed:selectImageName]];
    [resultVC.tabBarItem setTitle:imageName];
    resultVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    [self addChildViewController:resultVC];
}

@end
