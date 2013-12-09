//
//  CWUtility.h
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-4.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+Base64.h"

@interface CWUtility : NSObject

//- (NSInteger) numberOfFilesFromDirectionPath:(NSString *)aDiretionPath
//{
//    [[NSFileManager defaultManager] ];
//}


+ (NSString *)documentPath:(NSString *)subPath;

+ (UIImage *)stretchableImage:(UIImage *)img edgeInsets:(UIEdgeInsets)edgeInsets;

+ (BOOL)saveToFileWithImage:(UIImage *)aImage path:(NSString *)aPath;

+ (NSString *)image2String:(UIImage *)image;

+ (UIImage *)string2Image:(NSString *)string;

@end
