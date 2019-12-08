//
//  GCNavigator.h
//  搜韵
//
//  Created by 陈嘉豪 on 2018/10/5.
//  Copyright © 2018 Gill Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSURL+Scheme.h"
#import "NSString+Query.h"
#import "NSString+URLCode.h"
@class GCNavigator;

#define GCSharedNavigator [GCNavigator shared]

@protocol GCNavigatorDelegate <NSObject>
@optional
- (void)gcNavgator:(GCNavigator *)navigator
           fromURL:(NSURL *)url
 recieveParameters:(NSDictionary *)paramters;
@end

@interface GCNavigator : NSObject

+ (instancetype)shared;

# pragma mark - Register
/**
 * 可用于注册的 Plist 文件
 * 多次调用会覆盖
 * 格式：[
        {"className": vcClass
         "url": url},
        ]
 */
- (void)configName:(NSString *)plistName;
/**
 * GCNavigator 支持多种 URL Scheme
 * 如果注册 URL 的 Scheme 或者 Host 为空，会认为忽略二者的影响，后期同一个 URL_Path 都会跳转到同一个视图
 * 如果需要注册强关联 URL Scheme 和 Host 的逻辑，请同时带上二者
 * PS: 统一跳转会忽略 HTTPS 和 HTTP Scheme 的区别
 */
- (void)registerURL:(NSURL *)url
           targetTo:(Class)vcClass;
- (void)unregisterURL:(NSURL *)url
             forClass:(Class)vcClass;
# pragma mark - ViewController
+ (UIViewController *)getTopViewControllerAtApplication;
# pragma mark - Push & Present

- (BOOL)pushToViewController:(UIViewController *)toVC
                    animated:(BOOL)animated
                  completion:(void(^)(void))completion;

- (BOOL)presentToViewController:(UIViewController *)toVC
                       animated:(BOOL)animated
                     completion:(void(^)(void))completion;

- (BOOL)pushToURL:(NSURL *)url
         animated:(BOOL)animated
       completion:(void(^)(void))completion;
/**
 * 可以指定某个 Tab bar 的 navigationController 去 push
 * 步骤：
 * 判断当前的 TopViewControoler 的 root VC 是不是 TabBar
 * 如果是，进行选中后 push 的动作
 * 如果不是，返回 NO
 */
- (BOOL)pushToURL:(NSURL *)url
    atTabBarIndex:(NSInteger)index
         animated:(BOOL)animated
       completion:(void(^)(void))completion;
/**
 *  在当前控制器内直接 Model 一个控制器
 */
- (BOOL)presentToURL:(NSURL *)url
            animated:(BOOL)animated
          completion:(void(^)(void))completion;
# pragma mark - Pop Back
/**
 * 回到的上一个 VC
 */
- (BOOL)popBackWithAnimated:(BOOL)animated
                 completion:(void(^)(void))completion;
/**
 * 回到当前栈里的 VC
 * 如果存在两个一样的 VC Class 的实例
 * 会弹回到最顶部的 VC 实例
 */
- (BOOL)popBackToURL:(NSURL *)url
            animated:(BOOL)animated
          completion:(void(^)(void))completion;


@end
