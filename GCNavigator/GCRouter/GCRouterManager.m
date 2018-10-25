//
//  GCRouterManager.m
//  GCNavigatorDemo
//
//  Created by 陈嘉豪 on 2018/10/24.
//  Copyright © 2018 Gill Chan. All rights reserved.
//

#import "GCRouterManager.h"
#import "NSString+URLCode.h"
#import "NSURL+Scheme.h"
#define GClock() dispatch_semaphore_wait(self->_lock, DISPATCH_TIME_FOREVER)
#define GCUnlock() dispatch_semaphore_signal(self->_lock)
@interface GCRouter()
- (BOOL)isMatchAtURL:(NSURL *)url;
@end
@interface GCRouterManager(){dispatch_semaphore_t _lock;}
@property (nonatomic, strong) NSMutableDictionary *routers;
@end
@implementation GCRouterManager

+ (instancetype)shared{
    static dispatch_once_t onceToken;
    static GCRouterManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[GCRouterManager alloc]init];
        manager.routers = [NSMutableDictionary dictionary];
        manager->_lock = dispatch_semaphore_create(1);
    });
    return manager;
}
+ (GCRouter *)registerRouterForURL:(NSURL *)url
                           vcClass:(Class)vcClass{
    return [GCRouterSharedManager registerRouterForURL:[url ignoreHTTPS] vcClass:vcClass];
}
- (GCRouter *)registerRouterForURL:(NSURL *)url
                           vcClass:(Class)vcClass{
    GCRouter *router = [[GCRouter alloc]initWithURL:url vcClass:vcClass];
    [self addRouter:router];
    return router;
}
+ (void)unregisterURL:(NSURL *)url
             forClass:(Class)vcClass{
    [GCRouterSharedManager unregisterURL:[url ignoreHTTPS] forClass:vcClass];
}
- (void)unregisterURL:(NSURL *)url
             forClass:(Class)vcClass{
    if([self.routers.allKeys containsObject:[url.path URLDecodedString]]){
        for (GCRouter *router in self.routers[[url.path URLDecodedString]]){
            if([router.vcClass isKindOfClass:vcClass]){
                NSMutableArray *routers = [NSMutableArray arrayWithArray:self.routers[router.path]];
                [routers removeObject:router];
                GClock();
                self.routers[router.path] = [routers copy];
                GCUnlock();
                return;
            }
        }
    }
}

- (void)addRouter:(GCRouter *)router{
    if([self.routers.allKeys containsObject:router.path]){
        NSMutableArray *routers = [NSMutableArray arrayWithArray:self.routers[router.path]];
        [routers addObject:router];
        GClock();
        self.routers[router.path] = [routers copy];
        GCUnlock();
    }else{
        GClock();
        [self.routers addEntriesFromDictionary:@{router.path:@[router]}];
        GCUnlock();
    }
}

+ (GCRouter *)fetchRouterForURL:(NSURL *)url{
    return [GCRouterSharedManager fetchRouterForURL:[url ignoreHTTPS]];
}
- (GCRouter *)fetchRouterForURL:(NSURL *)url{
    if(![self.routers.allKeys containsObject:[url.path URLDecodedString]]){
        return nil;
    }
    if(!url.scheme || !url.host){
        return nil;
    }
    NSArray *routers = self.routers[[url.path URLDecodedString]];
    if(routers.count == 1){
        return routers.firstObject;
    }else{
        for(GCRouter *router in routers){
            if([router isMatchAtURL:url]){
                return router;
            }
        }
        return nil;
    }
}

@end
