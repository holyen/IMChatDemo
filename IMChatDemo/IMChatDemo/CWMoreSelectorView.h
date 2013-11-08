//
//  CWMoreSelectorView.h
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-6.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MORE_SELECTOR_PHOTO = 0,
    MORE_SELECTOR_CAMERA,
    MORE_SELECTOR_POSITION,
} SelectorMode;

@interface CWMoreSelectorView : UIView
{
    UIButton *_photoButton;
    UIButton *_cameraButton;
    id _target;
    SEL _targetSEL;
}

- (id)initWithFrame:(CGRect)frame target:(id)aTarget targetSEL:(SEL)aTargetSEL;

@end
