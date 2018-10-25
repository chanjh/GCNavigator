//
//  SYSearchResultViewController.m
//  GCNavigatorDemo
//
//  Created by 陈嘉豪 on 2018/10/23.
//  Copyright © 2018 Gill Chan. All rights reserved.
//

#import "SYSearchResultViewController.h"
#import "GCNavigator.h"

@interface SYSearchResultViewController ()<GCNavigatorDelegate>

@end

@implementation SYSearchResultViewController

- (void)gcNavgator:(GCNavigator *)navigator
           fromURL:(NSURL *)url
 recieveParameters:(NSDictionary *)paramters{
    NSLog(@"URL: %@", url);
    NSLog(@"Paramters: %@", paramters);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

@end
