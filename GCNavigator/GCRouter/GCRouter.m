//
//  GCRouter.m
//  GCNavigatorDemo
//
//  Created by 陈嘉豪 on 2018/10/24.
//  Copyright © 2018 Gill Chan. All rights reserved.
//

#import "GCRouter.h"
#import "NSString+URLCode.h"
@interface GCRouter()
@property (nonatomic, strong) NSString *p_scheme;
@property (nonatomic, strong) NSString *p_path;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) Class p_vcClass;
@end

@implementation GCRouter

- (instancetype)initWithURL:(NSURL *)url
                    vcClass:(Class)vcClass{
    self = [super init];
    self.p_path = [url.path URLDecodedString];
    self.p_scheme = [url.scheme URLDecodedString];
    self.p_vcClass = vcClass;
    if(url.host && url.scheme){
        self.url = [url.absoluteString URLDecodedString];
    }
    return self;
}
- (BOOL)isMatchAtURL:(NSURL *)url{
    if(!url.host || !url.scheme || !self.url){
        return NO;
    }else if([[url.absoluteString URLDecodedString] isEqualToString:self.url]){
        return YES;
    }else{
        return NO;
    }
}

- (NSString *)scheme{return _p_scheme;}
- (NSString *)path{return _p_path;}
- (Class)vcClass{return _p_vcClass;}

@end
