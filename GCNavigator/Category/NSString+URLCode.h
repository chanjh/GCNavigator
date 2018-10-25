//
//  NSString+URLCode.h
//  搜韵
//
//  Created by 陈嘉豪 on 2018/4/18.
//  Copyright © 2018年 Gill Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(URLCode)

/**
 *  URLEncode
 */
- (NSString *)URLEncodedString;

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString;

@end
