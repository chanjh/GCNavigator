//
//  NSString+URLCode.m
//  搜韵
//
//  Created by 陈嘉豪 on 2018/4/18.
//  Copyright © 2018年 Gill Chan. All rights reserved.
//

#import "NSString+URLCode.h"

@implementation NSString(URLCode)
/**
 *  URLEncode
 */
- (NSString *)URLEncodedString
{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString
{
    return [self stringByRemovingPercentEncoding];
}
@end
