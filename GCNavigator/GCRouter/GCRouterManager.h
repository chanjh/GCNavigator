//
//  GCRouterManager.h
//  GCNavigatorDemo
//
//  Created by 陈嘉豪 on 2018/10/24.
//  Copyright © 2018 Gill Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCRouter.h"
#define GCRouterSharedManager [GCRouterManager shared]
NS_ASSUME_NONNULL_BEGIN
@interface GCRouterManager : NSObject
+ (instancetype)shared;
+ (GCRouter *)registerRouterForURL:(NSURL *)url
                           vcClass:(Class)vcClass;
+ (void)unregisterURL:(NSURL *)url
             forClass:(Class)vcClass;
+ (GCRouter *)fetchRouterForURL:(NSURL *)url;
@end
NS_ASSUME_NONNULL_END
