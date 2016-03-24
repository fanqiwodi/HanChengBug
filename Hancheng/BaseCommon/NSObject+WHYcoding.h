//
//  NSObject+WHYcoding.h
//  Hancheng
//
//  Created by apple on 15/12/24.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (WHYcoding)
/**
 *  解码
 */
- (void)why_decode:(NSCoder *)decoder;
/**
 *  编码
 */
- (void)why_encode:(NSCoder *)encoder;

@end

#define WHYCodingImplementation \
- (id)initWithCoder:(NSCoder *)decoder \
{ \
if (self = [super init]) { \
[self why_decode:decoder]; \
} \
return self; \
} \
\
- (void)encodeWithCoder:(NSCoder *)encoder \
{ \
[self why_encode:encoder]; \
}

#define CodingImplementation WHYCodingImplementation