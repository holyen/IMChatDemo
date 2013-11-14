//
//  CWChatCell.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-13.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWChatCell.h"
#import "NSDate+Help.h"

@implementation CWChatCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
        messageInfo:(CWMessageInfo *)aMessageInfo
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _dateFont = [UIFont systemFontOfSize:13];
        _contentFont = [UIFont systemFontOfSize:16];
        _dateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        [self.contentView addSubview:_dateView];
        _dateBGImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AlbumTimeLineTipBkg.png"]];
        [_dateView addSubview:_dateBGImageView];
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dateLabel.font = _dateFont;
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.backgroundColor = [UIColor clearColor];
        [_dateView addSubview:_dateLabel];

        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320 - (10 + 40 + 10), 0)];
        [self.contentView addSubview:_contentView];
        
        _contentBGImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"contant_im_chatto_bg_on.png"]];
        [_contentView addSubview:_contentBGImageView];
        
        _avatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sharemore_friendcard.png"]];
        [self.contentView addSubview:_avatorImageView];
        
        self.messageInfo = aMessageInfo;
        
    }
    return self;
}

- (BOOL)isSelfMessageWithMessageInfo:(CWMessageInfo *)aMessageInfo
{
    //!!! FIX ME - NOT IMPLEMENTATION
//    if (aMessageInfo.fromUserInfoId != 1000) {
//        return NO;
//    }
    return YES;
}

- (void)setMessageInfo:(CWMessageInfo *)messageInfo
{
    if (messageInfo != _messageInfo) {
        [_messageInfo release];
        _messageInfo = [messageInfo retain];
        NSString *dateStr = [messageInfo.time toStringHasTime:NO];
        _dateLabel.text = dateStr;
        CGSize dateSize = [dateStr sizeWithFont:_dateFont constrainedToSize:CGSizeMake(320, 16) lineBreakMode:NSLineBreakByWordWrapping];
        _dateLabel.frame = CGRectMake(((320 - dateSize.width) / 2), 0, dateSize.width, dateSize.height);
        CGRect rectOfDateBGImageView = _dateBGImageView.frame;
        rectOfDateBGImageView.origin.x = ((320 - dateSize.width) / 2);
        rectOfDateBGImageView.size.width = dateSize.width;
        rectOfDateBGImageView.size.height = 20;
        _dateBGImageView.frame = rectOfDateBGImageView;
        
        CGSize contentSize = CGSizeZero;
        switch (_messageInfo.contentType) {
            case 1:
            {
                //文本 + 表情
                contentSize = [messageInfo.content sizeWithFont:_contentFont
                                                     constrainedToSize:CGSizeMake(190, 100000)
                                                         lineBreakMode:NSLineBreakByWordWrapping]; // !!! FIX ME
                
            }
                break;
            case 2:
            {
                //纯图片
                
            }
                break;
            case 3:
            {
                //语音
            }
                break;
            default:
                break;
        }
        
        if ([self isSelfMessageWithMessageInfo:_messageInfo]) {
            //自己
            _contentView.frame = CGRectMake(0, 20, 320 - (10 + 40 + 10), contentSize.height + 2 * 12);
            
            _contentBGImageView.frame = CGRectMake(320 - (10 + 40 +10) - contentSize.width + 10 + 10 + 10 + 10, 0, 10 + contentSize.width + 10 + 10, contentSize.height + 12 + 12);
            
            _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, contentSize.width, contentSize.height)];
            _contentLabel.font = _contentFont;
            _contentLabel.textColor = [UIColor blackColor];
            _contentLabel.backgroundColor = [UIColor clearColor];
            [_contentView addSubview:_contentLabel];
            _contentLabel.text = messageInfo.content;
            
            _avatorImageView.frame = CGRectMake(320 - 10 - 40, 20, 40, 40);
        }
    }
}

- (void)dealloc
{
    
    [_dateView release];
    [_dateBGImageView release];
    [_dateLabel release];
    
    [_contentView release];
    [_contentBGImageView release];
    [_contentLabel release];
    
    [_voiceTimeLabel release];
    
    [_avatorImageView release];
    
    [_dateFont release];
    [_contentFont release];
    
    [_messageInfo release];
    [super dealloc];
}

@end
