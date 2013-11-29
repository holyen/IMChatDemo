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
#import "CWRecordUtility.h"
#import "CWMessageModel.h"

//#import "CXAHyperlinkLabel.h"
//#import "NSString+CXAHyperlinkParser.h"

@class CWChatToolView;
@protocol CWChatToolViewDelegate <NSObject>

- (void)emotionButtonDidTapInChatToolView:(CWChatToolView *)aChatToolView;
- (void)speakButtonDidTapInChatToolView:(CWChatToolView *)aChatToolView;
- (void)moreSelectorViewTapInChatToolView:(CWChatToolView *)aChatToolView type:(NSNumber *)aType;
- (void)addOthersButtonDidTapInChatToolView:(CWChatToolView *)aChatToolView;
- (void)message:(CWMessageInfo *)aMessageInfo didSendInChatToolView:(CWChatToolView *)aChatToolView;

@end

@interface CWChatToolView : UIView <CWEmotionSelectorViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>
{
    CWRecordUtility *_recordUtility;
    CWMessageModel *_messageModel;
    NSString *_recordVoicePath;
}

@property (assign, nonatomic) id<CWChatToolViewDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIButton *pressSpeakButton;
@property (retain, nonatomic) IBOutlet UITextField *messageSendTextField;
@property (retain, nonatomic) IBOutlet UIButton *textModeButton;
@property (retain, nonatomic) IBOutlet UIButton *voiceModeButton;
@property (retain, nonatomic) IBOutlet UIButton *emotionSelectButton;
@property (retain, nonatomic) CWEmotionSelectorView *emotionSelectorView;
@property (retain, nonatomic) IBOutlet UIButton *emotionTextModeButton;//表情对应的键盘按钮
@property (retain, nonatomic) CWMoreSelectorView *moreSelectorView;

- (IBAction)textModeButtonTap:(id)sender;
- (IBAction)voiceModeButtonTap:(id)sender;
- (IBAction)emotionSelectButtonTap:(id)sender;
- (IBAction)addOthersButtonTap:(id)sender;
- (IBAction)emotionTextModeButtonTap:(id)sender;

@end
