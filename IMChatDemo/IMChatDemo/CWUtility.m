//
//  CWUtility.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-4.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWUtility.h"

@implementation CWUtility

+ (NSString *)documentPath:(NSString *)subPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if (!subPath || [subPath isEqualToString:@""]) {
        return [paths objectAtIndex:0];
    }else{
        return [[paths objectAtIndex:0] stringByAppendingPathComponent:subPath];
    }
}

+ (UIImage *)stretchableImage:(UIImage *)img edgeInsets:(UIEdgeInsets)edgeInsets
{
    edgeInsets.left < 1 ? edgeInsets.left = 12 : 0;
    edgeInsets.top  < 1 ? edgeInsets.top = 12 : 0;
    return [img stretchableImageWithLeftCapWidth:edgeInsets.top topCapHeight:edgeInsets.left];
#if defined __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_5_0
    return [img resizableImageWithCapInsets:edgeInsets];
#else
    return [img stretchableImageWithLeftCapWidth:edgeInsets.top topCapHeight:edgeInsets.left];
#endif
}

@end
