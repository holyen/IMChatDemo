//
//  CWEmotionListScrollView.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-4.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWEmotionListScrollView.h"
#import "CWEmotionButton.h"

@implementation CWEmotionListScrollView

- (id)initWithFrame:(CGRect)frame target:(id)aTarget action:(SEL)aAction
{
    self = [super initWithFrame:frame];
    if (self) {
        _target = aTarget;
        _targetSEL = aAction;
        _emotionArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 104; i ++) {
            NSString *emotionStr = [NSString stringWithFormat:@"Expression_%d.png", i];
            [_emotionArray addObject:emotionStr];
        }
        _yOffset = 5.0;
        _oneItemSize = 32.0;
        _countOfOneRow = 7;
        _countOfRow = 3;
        _xMargin = ((CGFloat)self.bounds.size.width - (_countOfOneRow * _oneItemSize)) / (_countOfOneRow + 1);
        _yMargin = ((CGFloat)175.0 - (_countOfRow *_oneItemSize)) / (_countOfRow + 1);
        NSInteger num = ceil((CGFloat)[_emotionArray count] / (_countOfOneRow * _countOfRow));
        self.contentSize = CGSizeMake(320 * num, self.bounds.size.height);
        
        for (int i = 0; i < num; i ++) {
            for (int j = 0; j < _countOfRow; j ++) {
                for (int z = 0; z < _countOfOneRow; z ++) {
                    NSInteger index = i * (_countOfRow * _countOfOneRow) + j * _countOfOneRow + z;//FIX ME
                    if (index > [_emotionArray count] - 1) {
                        goto c;
                    }
                    CWEmotionButton *emotionButton = [CWEmotionButton buttonWithImageURL:[_emotionArray objectAtIndex:index] index:index width:_oneItemSize];
                    emotionButton.frame = CGRectMake((i * self.bounds.size.width) + _xMargin * (z + 1) + z * _oneItemSize, _yMargin * (j + 1) + j * _oneItemSize + _yOffset, _oneItemSize, _oneItemSize);
                    [emotionButton addTarget:self
                                      action:@selector(emotionButtonTap:)
                            forControlEvents:UIControlEventTouchUpInside];
                    emotionButton.emotionString = @"[大哭]";
                    [self addSubview:emotionButton];
                }
            }
        }
        
        c:
        self.scrollEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
    }
    return self;
}

- (void)dealloc
{
    [_emotionArray release];
    [super dealloc];
}

- (void)emotionButtonTap:(CWEmotionButton *)aButton
{
    if (_target && _targetSEL) {
        [_target performSelector:_targetSEL withObject:self withObject:aButton];
    }
}

@end
