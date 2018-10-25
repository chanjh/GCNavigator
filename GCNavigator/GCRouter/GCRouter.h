//
//  GCRouter.h
//  GCNavigatorDemo
//
//  Created by 陈嘉豪 on 2018/10/24.
//  Copyright © 2018 Gill Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface GCRouter : NSObject
@property (nonatomic, strong, readonly) NSString *scheme;
@property (nonatomic, strong, readonly) NSString *path;
@property (nonatomic, strong, readonly) Class vcClass;
- (instancetype)initWithURL:(NSURL *)url
                    vcClass:(Class)vcClass;
@end
NS_ASSUME_NONNULL_END
