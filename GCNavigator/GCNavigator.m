//
//  GCNavigator.m
//  搜韵
//
//  Created by 陈嘉豪 on 2018/10/5.
//  Copyright © 2018 Gill Chan. All rights reserved.
//

#import "GCNavigator.h"
#import <UIKit/UIKit.h>
#import "GCRouterManager.h"

#define GClock() dispatch_semaphore_wait(self->_lock, DISPATCH_TIME_FOREVER)
#define GCUnlock() dispatch_semaphore_signal(self->_lock)

@interface GCNavigator(){dispatch_semaphore_t _lock;}
@end

@implementation GCNavigator

# pragma mark -
+ (instancetype)shared{
    static dispatch_once_t onceToken;
    static GCNavigator *shared = nil;
    dispatch_once(&onceToken, ^{
        shared = [[GCNavigator alloc]init];
        shared->_lock = dispatch_semaphore_create(1);
    });
    return shared;
}

- (void)configName:(NSString *)plistName{
    NSArray *registry = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"]];
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
}
# pragma mark - Register
- (void)registerURL:(NSURL *)url targetTo:(Class)vcClass{
    if(!url){
        return;
    }
    if (![vcClass isSubclassOfClass:[UIViewController class]]){
        NSAssert(NO, @"不是 ViewController");
    }
    [GCRouterManager registerRouterForURL:url vcClass:vcClass];
}

- (void)unregisterURL:(NSURL *)url
             forClass:(Class)vcClass{
    [GCRouterManager unregisterURL:url forClass:vcClass];
}
# pragma mark - Push and Pop
- (BOOL)pushToURL:(NSURL *)url
         animated:(BOOL)animated
       completion:(void(^)(void))completion{
    UIViewController *selectedVC = [self getTopViewControllerAtApplication];
    UIViewController *toVC = [self getViewControllerWithURL:url];
    if(!selectedVC.navigationController){
        [self handleWithNoNavgationControllerForVC:selectedVC];
        return NO;
    }
    [selectedVC.navigationController pushViewController:toVC animated:animated];
    if([self getParametersWithURL:url]){
        if([toVC respondsToSelector:@selector(gcNavgator:fromURL:recieveParameters:)]){
            [((UIViewController <GCNavigatorDelegate> *)toVC) gcNavgator:self
                                                                 fromURL:url
                                                       recieveParameters:[self getParametersWithURL:url]];
        }
    }
    if(completion){completion();}
    return YES;
}

- (BOOL)pushToURL:(NSURL *)url
    atTabBarIndex:(NSInteger)index
         animated:(BOOL)animated
       completion:(void(^)(void))completion{
    if (index < 0){
        NSAssert(NO, @"index 不能小于零");
        return NO;
    }
    UITabBarController *tabBarController = [self getTabBarController];
    if(!tabBarController){
        return NO;
    }else{
        tabBarController.selectedIndex = index;
        return [self pushToURL:url
                      animated:animated
                    completion:completion];
    }
}

- (BOOL)presentToURL:(NSURL *)url
            animated:(BOOL)animated
          completion:(void(^)(void))completion{
    UIViewController *topVC = [self getTopViewControllerAtApplication];
    UIViewController *toViewController = [self getViewControllerWithURL:url];
    if(!toViewController){
        return NO;
    }
    [topVC presentViewController:toViewController
                        animated:animated
                      completion:completion];
    return YES;
}

- (BOOL)popBackWithAnimated:(BOOL)animated
                 completion:(void(^)(void))completion{
    UIViewController *topVC = [self getTopViewControllerAtApplication];
    if(!topVC.navigationController){
        [topVC dismissViewControllerAnimated:animated completion:completion];
        return NO;
    }
    [topVC.navigationController popViewControllerAnimated:animated];
    if(completion){completion();}
    return YES;
}

- (BOOL)popBackToURL:(NSURL *)url
            animated:(BOOL)animated
          completion:(void(^)(void))completion{
    UIViewController *topVC = [self getTopViewControllerAtApplication];
    UINavigationController *navController = topVC.navigationController;
    if(!navController){
        [topVC dismissViewControllerAnimated:animated completion:completion];
        return NO;
    }
    Class vcClass = [self getViewControllerClassWithURL:url];
    for (UIViewController *navChild in navController.viewControllers){
        if([navChild isKindOfClass:vcClass]){
            [navController popToViewController:navChild animated:animated];
            if(completion){completion();}
            return YES;
        }
    }
    if(completion){completion();}
    return NO;
}

# pragma mark - Private
// 处理没有 NavController 的情况
- (void)handleWithNoNavgationControllerForVC:(UIViewController *)vc{
    NSAssert(NO, @"暂时不支持没有 Nav 的情况");
}

# pragma mark - Get
- (UITabBarController *)getTabBarController{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootVC = keyWindow.rootViewController;
    if([rootVC isKindOfClass:[UITabBarController class]]){
        return (UITabBarController *)rootVC;
    }
    NSAssert(NO, @"错误: TabBar 并不是 app 的 rootVC");
    return nil;
}

- (UIViewController *)getTopViewControllerAtApplication{
    UIViewController *resultVC;
    resultVC = [self _getTopViewControllerAtApplication:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _getTopViewControllerAtApplication:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_getTopViewControllerAtApplication:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _getTopViewControllerAtApplication:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _getTopViewControllerAtApplication:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

- (NSDictionary *)getParametersWithURL:(NSURL *)url{
    return [[url query] fetchQuery];
}

- (UIViewController *)getViewControllerWithURL:(NSURL *)url{
    Class vcClass = [self getViewControllerClassWithURL:url];
    UIViewController *vc = [[vcClass alloc]init];
    return vc;
}

- (Class)getViewControllerClassWithURL:(NSURL *)url{
    GCRouter *router = [GCRouterManager fetchRouterForURL:[url ignoreHTTPS]];
    if(router.vcClass){
        return router.vcClass;
    }else{
        return nil;
    }
}

@end
