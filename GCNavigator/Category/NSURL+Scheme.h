//
//  NSURL+Scheme.h
//  搜韵
//
//  Created by 陈嘉豪 on 2018/10/5.
//  Copyright © 2018 Gill Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL(Scheme)

- (NSString *)absolutePath;
- (BOOL)isHTTPorHTTPS;
- (NSURL *)ignoreHTTPS;
@end

NS_ASSUME_NONNULL_END
