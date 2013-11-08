//
//  CWEmotionSelectorView.h
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-5.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWEmotionListScrollView.h"


@protocol CWEmotionSelectorViewDelegate <NSObject>

- (void)emotionSelectedEmotionString:(NSString *)aEmotionString;

@end

@interface CWEmotionSelectorView : UIView <UIScrollViewDelegate>
{
    UIButton *_sendButton;
    CWEmotionListScrollView *_emotionListScrollView;
    UIPageControl *_pageControl;
}

@property (assign, nonatomic) id<CWEmotionSelectorViewDelegate> delegate;

@end
