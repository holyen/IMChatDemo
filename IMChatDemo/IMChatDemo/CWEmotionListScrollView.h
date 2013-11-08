//
//  CWEmotionListScrollView.h
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-4.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWEmotionListScrollView : UIScrollView
{
    NSMutableArray *_emotionArray;
    NSInteger _countOfOneRow;
    NSInteger _countOfRow;
    CGFloat _xMargin;
    CGFloat _yMargin;
    CGFloat _oneItemSize;//width == height;
    CGFloat _yOffset;//all items has a offset.
    id _target;
    SEL _targetSEL;
}

- (id)initWithFrame:(CGRect)frame target:(id)aTarget action:(SEL)aAction;

@end
