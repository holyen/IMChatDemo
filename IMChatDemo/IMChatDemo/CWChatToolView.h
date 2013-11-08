//
//  CWChatToolView.h
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-4.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWEmotionSelectorView.h"
#import "CWMoreSelectorView.h"
//#import "CXAHyperlinkLabel.h"
//#import "NSString+CXAHyperlinkParser.h"

@class CWChatToolView;
@protocol CWChatToolViewDelegate <NSObject>

- (void)emotionButtonDidTapInChatToolView:(CWChatToolView *)aChatToolView;
- (void)speakButtonDidTapInChatToolView:(CWChatToolView *)aChatToolView;
- (void)moreSelectorViewTapInChatToolView:(CWChatToolView *)aChatToolView type:(NSNumber *)aType;
- (void)addOthersButtonDidTapInChatToolView:(CWChatToolView *)aChatToolView;
@end

@interface CWChatToolView : UIView <CWEmotionSelectorViewDelegate, UITextFieldDelegate>

@property (assign, nonatomic) id<CWChatToolViewDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIButton *pressSpeakButton;
@property (retain, nonatomic) IBOutlet UITextField *messageSendTextField;
@property (retain, nonatomic) IBOutlet UIButton *textModeButton;
@property (retain, nonatomic) IBOutlet UIButton *voiceModeButton;
@property (retain, nonatomic) IBOutlet UIButton *emotionSelectButton;//打开表情按钮
@property (retain, nonatomic) CWEmotionSelectorView *emotionSelectorView;
@property (retain, nonatomic) IBOutlet UIButton *emotionTextModeButton;//表情对应的键盘按钮
@property (retain, nonatomic) CWMoreSelectorView *moreSelectorView;

- (IBAction)textModeButtonTap:(id)sender;
- (IBAction)voiceModeButtonTap:(id)sender;
- (IBAction)emotionSelectButtonTap:(id)sender;
- (IBAction)addOthersButtonTap:(id)sender;
- (IBAction)emotionTextModeButtonTap:(id)sender;

@end
