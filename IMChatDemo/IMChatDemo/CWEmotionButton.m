//
//  CWEmotionButton.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-5.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWEmotionButton.h"

@implementation CWEmotionButton

+ (id)buttonWithImageURL:(NSString *)aImageURL index:(NSInteger)aIndex width:(CGFloat)aWidth
{
    CWEmotionButton *button = [super buttonWithType:UIButtonTypeCustom];
    button.imageURL = aImageURL;
    button.index = aIndex;
    [button setBackgroundImage:[UIImage imageNamed:aImageURL] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:aImageURL] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:aImageURL] forState:UIControlStateSelected];
    CGRect buttonFrame = button.frame;
    buttonFrame.size.width = aWidth;
    buttonFrame.size.height = aWidth;
    button.frame = buttonFrame;
    
    return button;
}

- (void)dealloc
{
    [_imageURL release];
    [_emotionString release];
    [super dealloc];
}

@end
