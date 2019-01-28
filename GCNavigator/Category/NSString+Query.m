//
//  NSString+Query.m
//  搜韵
//
//  Created by 陈嘉豪 on 2018/10/5.
//  Copyright © 2018 Gill Chan. All rights reserved.
//

#import "NSString+Query.h"
#import "NSString+URLCode.h"
@implementation NSString(Query)
- (NSDictionary *)fetchQuery{
    NSArray *queryStrs = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSString *queryStr in queryStrs){
        if([queryStr containsString:@"="]){
            NSArray *result = [queryStr componentsSeparatedByString:@"="];
            NSString *key = [result.firstObject URLDecodedString];
            NSString *value = [result.lastObject URLDecodedString];
            if(!key || !value) {
                NSAssert(NO, @"URL 转码错误");
            } else {
                [dict addEntriesFromDictionary:@{key: value}];
            }
            
        }
    }
    if(dict.allKeys.count){
        return [dict copy];
    }else{
        return nil;
    }
}
@end
