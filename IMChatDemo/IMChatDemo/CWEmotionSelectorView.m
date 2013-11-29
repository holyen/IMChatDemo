//
//  CWEmotionSelectorView.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-5.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWEmotionSelectorView.h"
#import "CWEmotionButton.h"

@implementation CWEmotionSelectorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _emotionListScrollView = [[CWEmotionListScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 216) target:self action:@selector(emotionListScrollView:button:)];
        _emotionListScrollView.delegate = self;
        [self addSubview:_emotionListScrollView];
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 168, 320, 40)];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.userInteractionEnabled = NO;
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.numberOfPages = 5;
        [self addSubview:_pageControl];
        
        _sendButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        CGFloat buttonWidth = 70;
        CGFloat buttonHeight = 37;
        _sendButton.frame = CGRectMake(self.bounds.size.width - buttonWidth, self.bounds.size.height - buttonHeight, buttonWidth, buttonHeight);
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"EmotionsSendBtnBlue.png"]
                               forState:UIControlStateNormal];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"EmotionsSendBtnBlue.png"]
                               forState:UIControlStateHighlighted];
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"EmotionsSendBtnBlue.png"]
                               forState:UIControlStateSelected];
        [_sendButton setTitle:@"  发送" forState:UIControlStateNormal];
        [_sendButton setTitle:@"  发送" forState:UIControlStateHighlighted];
        [_sendButton setTitle:@"  发送" forState:UIControlStateSelected];
        [_sendButton addTarget:self
                        action:@selector(emotionSendButtonTap:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sendButton];
    }
    return self;
}

-(void)dealloc
{
    [_sendButton release];
    [_emotionListScrollView release];
    [_pageControl release];
    [super dealloc];
}

- (void)emotionListScrollView:(CWEmotionListScrollView *)aEmotionListScrollView
                       button:(CWEmotionButton *)aButton
{
    if ([_delegate respondsToSelector:@selector(emotionSelectedEmotionString:)]) {
        [_delegate performSelector:@selector(emotionSelectedEmotionString:) withObject:aButton.emotionString];
    }
}

- (void)emotionSendButtonTap:(UIButton *)aButton
{
    if ([_delegate respondsToSelector:@selector(emotionSendButtonTap)]) {
        [_delegate performSelector:@selector(emotionSendButtonTap)];
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x)/self.frame.size.width;
    _pageControl.currentPage = index;
}

@end
