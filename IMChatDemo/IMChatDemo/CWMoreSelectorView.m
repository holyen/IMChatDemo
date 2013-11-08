//
//  CWMoreSelectorView.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-6.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWMoreSelectorView.h"


@implementation CWMoreSelectorView

- (id)initWithFrame:(CGRect)frame target:(id)aTarget targetSEL:(SEL)aTargetSEL
{
    self = [super initWithFrame:frame];
    if (self) {
        _target = aTarget;
        _targetSEL = aTargetSEL;
        self.backgroundColor = [UIColor grayColor];
        _photoButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _photoButton.frame = CGRectMake(20, 20, 54, 54);
        [_photoButton setBackgroundImage:[UIImage imageNamed:@"sharemore_pic.png"]
                                forState:UIControlStateNormal];
        [_photoButton setBackgroundImage:[UIImage imageNamed:@"sharemore_pic.png"]
                                forState:UIControlStateHighlighted];
        [_photoButton setBackgroundImage:[UIImage imageNamed:@"sharemore_pic.png"]
                                forState:UIControlStateSelected];
        [_photoButton addTarget:self
                         action:@selector(photoButtonTap:)
               forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_photoButton];
        
        _cameraButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _cameraButton.frame = CGRectMake(94, 20, 54, 54);
        [_cameraButton setBackgroundImage:[UIImage imageNamed:@"sharemore_video.png"]
                                forState:UIControlStateNormal];
        [_cameraButton setBackgroundImage:[UIImage imageNamed:@"sharemore_video.png"]
                                forState:UIControlStateHighlighted];
        [_cameraButton setBackgroundImage:[UIImage imageNamed:@"sharemore_video.png"]
                                forState:UIControlStateSelected];
        [_cameraButton addTarget:self
                          action:@selector(cameraButtonTap:)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cameraButton];
    }
    return self;
}

- (void)dealloc
{
    [_photoButton release];
    [_cameraButton release];
    [super dealloc];
}

- (void)photoButtonTap:(UIButton *)aButton
{
    if (_target && _targetSEL) {
        [_target performSelector:_targetSEL withObject:[NSNumber numberWithInteger:MORE_SELECTOR_PHOTO]];
    }
}

- (void)cameraButtonTap:(UIButton *)aButton
{
    if (_target && _targetSEL) {
        [_target performSelector:_targetSEL withObject:[NSNumber numberWithInteger:MORE_SELECTOR_CAMERA]];
    }
}

@end
