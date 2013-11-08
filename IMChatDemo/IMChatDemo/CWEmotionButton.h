//
//  CWEmotionButton.h
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-5.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWEmotionButton : UIButton

@property (copy, nonatomic) NSString *imageURL;

@property (assign, nonatomic) NSInteger index;

@property (copy, nonatomic) NSString *emotionString;

+ (id)buttonWithImageURL:(NSString *)aImageURL index:(NSInteger)aIndex width:(CGFloat)aWidth;

@end
