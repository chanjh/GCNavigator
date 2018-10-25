//
//  NSURL+Scheme.m
//  搜韵
//
//  Created by 陈嘉豪 on 2018/10/5.
//  Copyright © 2018 Gill Chan. All rights reserved.
//

#import "NSURL+Scheme.h"

@implementation NSURL(Scheme)

- (NSString *)absolutePath{
    return [NSString stringWithFormat:@"%@://%@%@", self.scheme, self.host, self.path];
}

- (BOOL)isHTTPorHTTPS{
    return [self.scheme isEqualToString:@"https"] || [self.scheme isEqualToString:@"http"];
}

- (NSURL *)ignoreHTTPS{
    if([self.scheme isEqualToString:@"https"]){
        NSString *str;
        if(self.query){
            str = [NSString stringWithFormat:@"%@?%@", [self absolutePath],self.query];
        }else{
            str = [self absolutePath];
        }
        return [NSURL URLWithString:str];
    }else{
        return self;
    }
}

@end
