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

+ (BOOL)saveToFileWithImage:(UIImage *)aImage path:(NSString *)aPath
{
    // Create paths to output images
    NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.png"];
    //[[CWUtility documentPath:@"photos"] stringByAppendingPathComponent:@"/Test.png"];
    
    // Write a UIImage to JPEG with minimum compression (best quality)
    // The value 'image' must be a UIImage object
    // The value '1.0' represents image compression quality as value from 0.0 to 1.0
    //[UIImageJPEGRepresentation(image, 1.0) writeToFile:jpgPath atomically:YES];
    
    // Write image to PNG
    [UIImagePNGRepresentation(aImage) writeToFile:pngPath atomically:YES];
    
    // Let's check to see if files were successfully written...
    
    // Create file manager
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    // Point to Document directory
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    // Write out the contents of home directory to console
    NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);
    
    if (!error) {
        return YES;
    } else {
        //NSAssert(0, @"save image to file error");
        return NO;
    }
}

//+ (NSString *)file2StringByFilePath:(NSString *)aFilePath
//{
//    
//}

//+ (NSString *)string2FileByFilePath:(NSString *)string
//{
//    
//}

+ (NSString *)image2String:(UIImage *)image
{
    float o = 0.5;
	if (!image){
		return @"";
	}

	NSData* pictureData = UIImageJPEGRepresentation(image, o);
	NSString* pictureDataString = [pictureData base64Encoding];
	
	return pictureDataString;
}

+ (UIImage *)string2Image:(NSString *)string
{
	UIImage *image = [UIImage imageWithData:[NSData dataWithBase64EncodedString:string]];
	return image;
}

@end
