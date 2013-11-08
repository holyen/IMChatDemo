//
//  CWChatToolView.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-4.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWChatToolView.h"

@implementation CWChatToolView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _messageSendTextField.delegate = self;
    //!!! FOR TEST
    /**
    CXAHyperlinkLabel *label = [[CXAHyperlinkLabel alloc] initWithFrame:CGRectMake(100, 60, 200, 200)];
    label.numberOfLines = 5;
    label.backgroundColor = [UIColor redColor];
    NSArray *URLs;
    NSArray *URLRanges;
    label.attributedText = [self attributedString:&URLs URLRanges:&URLRanges content:@"<a href='http://www.trigger.com' title='http://www.trigger.com'>http://www.trigger.com</a> 我是天朝百姓~~~ 啊 度工在fdklcfdlk颉罟<a href='http://www.trigger.com' title='http://www.trigger.com'>http://www.trigger.com</a>"];
    [label setURLs:URLs forRanges:URLRanges];
    
    label.URLClickHandler = ^(CXAHyperlinkLabel *label, NSURL *URL, NSRange range, NSArray *textRects){
        [[[UIAlertView alloc] initWithTitle:@"URLClickHandler" message:[NSString stringWithFormat:NSLocalizedString(@"Click on the URL %@", nil), [URL absoluteString]] delegate:nil cancelButtonTitle:NSLocalizedString(@"Dismiss", nil) otherButtonTitles:nil] show];
    };
    label.URLLongPressHandler = ^(CXAHyperlinkLabel *label, NSURL *URL, NSRange range, NSArray *textRects){
        [[[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"URLLongPressHandler for URL: %@", [URL absoluteString]] delegate:nil cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:nil] showInView:self];
    };
    [self addSubview:label];
     */
}

//!!! FOR TEST
/*
- (NSAttributedString *)attributedString:(NSArray *__autoreleasing *)outURLs
                               URLRanges:(NSArray *__autoreleasing *)outURLRanges
                                 content:(NSString *)aContent
{
    NSString *HTMLText = aContent;
    NSArray *URLs;
    NSArray *URLRanges;
    UIColor *color = [UIColor blackColor];
    UIFont *font = [UIFont fontWithName:@"Baskerville" size:19.];
    NSMutableParagraphStyle *mps = [[NSMutableParagraphStyle alloc] init];
    mps.lineSpacing = ceilf(font.pointSize * .5);
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor whiteColor];
    shadow.shadowOffset = CGSizeMake(0, 1);
    NSString *str = [NSString stringWithHTMLText:HTMLText baseURL:[NSURL URLWithString:@"http://en.wikipedia.org/"] URLs:&URLs URLRanges:&URLRanges];
    NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] initWithString:str attributes:@
                                      {
                                          NSForegroundColorAttributeName : color,
                                          NSFontAttributeName            : font,
                                          NSParagraphStyleAttributeName  : mps,
                                          NSShadowAttributeName          : shadow,
                                      }];
    [URLRanges enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        [mas addAttributes:@
         {
             NSForegroundColorAttributeName : [UIColor blueColor],
             NSUnderlineStyleAttributeName  : @(NSUnderlineStyleSingle)
         } range:[obj rangeValue]];
    }];
    
    *outURLs = URLs;
    *outURLRanges = URLRanges;
    
    return [mas copy];
}
 */

- (void)dealloc
{
    [_pressSpeakButton release];
    [_messageSendTextField release];
    [_textModeButton release];
    [_voiceModeButton release];
    [_emotionSelectButton release];
    [_emotionSelectorView release];
    [_emotionTextModeButton release];
    [_moreSelectorView release];
    [super dealloc];
}

- (void)updateIMModeIsTextMode:(BOOL)isTextMode
{
    if (isTextMode) {
        self.textModeButton.hidden = YES;
        self.voiceModeButton.hidden = NO;
        self.messageSendTextField.hidden = NO;
        self.pressSpeakButton.hidden = YES;
        [self.messageSendTextField becomeFirstResponder];
    } else {
        self.textModeButton.hidden = NO;
        self.voiceModeButton.hidden = YES;
        self.messageSendTextField.hidden = YES;
        self.pressSpeakButton.hidden = NO;
        [self.messageSendTextField resignFirstResponder];
    }
}

- (IBAction)textModeButtonTap:(id)sender {
    [self updateIMModeIsTextMode:YES];
}

- (IBAction)voiceModeButtonTap:(id)sender {
    [self updateIMModeIsTextMode:NO];
    self.emotionSelectButton.hidden = NO;
    self.emotionTextModeButton.hidden = YES;
    if ([_delegate respondsToSelector:@selector(speakButtonDidTapInChatToolView:)]) {
        [_delegate performSelector:@selector(speakButtonDidTapInChatToolView:) withObject:self];
    }
}

- (IBAction)addOthersButtonTap:(id)sender {
    if (!_moreSelectorView) {
        _moreSelectorView = [[CWMoreSelectorView alloc] initWithFrame:CGRectMake(0, 44, 320, 216) target:self targetSEL:@selector(moreSelectorViewTap:)];
    }
    [self updateSelectorViewToMoreUI];
}

- (IBAction)emotionTextModeButtonTap:(id)sender {
    [self updateIMModeIsTextMode:YES];
    _emotionTextModeButton.hidden = YES;
    _emotionSelectButton.hidden = NO;
    
}

- (IBAction)emotionSelectButtonTap:(id)sender {
    if (!_emotionSelectorView ) {
        _emotionSelectorView = [[CWEmotionSelectorView alloc] initWithFrame:CGRectMake(0, 44, 320, 216)];
        _emotionSelectorView.delegate = self;
    }
    [self updateSelectorViewToEmotionUI];
}

- (void)moreSelectorViewTap:(NSNumber *)aType
{
    if ([_delegate respondsToSelector:@selector(moreSelectorViewTapInChatToolView:type:)]) {
        [_delegate performSelector:@selector(moreSelectorViewTapInChatToolView:type:) withObject:self withObject:aType];
    }


}

- (void)updateSelectorViewToEmotionUI
{
    if ([_moreSelectorView superview]) {
        [_moreSelectorView removeFromSuperview];
    }
    if (![_emotionSelectorView superview]) {
        [self addSubview:_emotionSelectorView];
    }
    
    [self.messageSendTextField resignFirstResponder];

    self.messageSendTextField.hidden = NO;
    self.pressSpeakButton.hidden = YES;
    
    _voiceModeButton.hidden = NO;
    _textModeButton.hidden = YES;
    _emotionTextModeButton.hidden = NO;
    _emotionSelectButton.hidden = YES;
    if ([_delegate respondsToSelector:@selector(emotionButtonDidTapInChatToolView:)]) {
        [_delegate performSelector:@selector(emotionButtonDidTapInChatToolView:) withObject:self];
    }
}

- (void)updateSelectorViewToMoreUI
{
    if ([_emotionSelectorView superview]) {
        [_emotionSelectorView removeFromSuperview];
    }
    if (![_moreSelectorView superview]) {
        [self addSubview:_moreSelectorView];
    }
    [self.messageSendTextField resignFirstResponder];
    //!!! FIX ME
    if ([_delegate respondsToSelector:@selector(addOthersButtonDidTapInChatToolView:)]) {
        [_delegate performSelector:@selector(addOthersButtonDidTapInChatToolView:) withObject:self];
    }
    
}

- (void)saveToDBWithMessageContent:(NSString *)aContent
{
    NSError *error;
    NSString *regulaStr = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:aContent
                                                options:0
                                                  range:NSMakeRange(0, [aContent length])];
    NSMutableArray *httpStrs = [NSMutableArray array];
    NSMutableArray *httpRanges = [NSMutableArray array];
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSString* substringForMatch = [aContent substringWithRange:match.range];
        [httpRanges addObject:[NSValue valueWithRange:match.range]];
        [httpStrs addObject:substringForMatch];
    }
    //!!! FIX ME BUG:when it has two more the same ip address.
    for (int i = [httpStrs count] - 1; i >= 0; i --) {
        NSString *str = [httpStrs objectAtIndex:i];
        NSString *strHandle = [NSString stringWithFormat:@"<a href='%@' title='%@'>%@</a>",str,str,str];
        NSRange rang = [[httpRanges objectAtIndex:i] rangeValue];
        aContent = [aContent stringByReplacingCharactersInRange:rang withString:strHandle];
    }
    NSLog(@"message's content %@", aContent);
}

#pragma mark -
#pragma mark - CWEmotionSelectorViewDelegate
- (void)emotionSelectedEmotionString:(NSString *)aEmotionString
{
    _messageSendTextField.text = [_messageSendTextField.text stringByAppendingString:aEmotionString];
}

#pragma mark -
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self saveToDBWithMessageContent:textField.text];
    return YES;
}

@end
