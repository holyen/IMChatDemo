//
//  CWNewsCell.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-27.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWNewsCell.h"
#import "CWUtility.h"

@implementation CWNewsCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
        messageInfo:(CWMessageInfo *)aMessageInfo
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        217,128
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_contentView];
        
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_contentView addSubview:_bgImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 176, 33)];
        _titleLabel.numberOfLines = 3;
        _titleLabel.text = @"易百科:快速读懂土地增值税";
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [_contentView addSubview:_titleLabel];
        
        _coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 52, 60, 60)];
        _coverImageView.image = [UIImage imageNamed:@"new_cover.png"];
        [_contentView addSubview:_coverImageView];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 60)];
        _contentLabel.text = @"土地增值税怎样计算? 清算土地增值税是怎么回事?";
        _contentLabel.numberOfLines = 4;
        _contentLabel.font = [UIFont systemFontOfSize:15];
        [_contentView addSubview:_contentLabel];
        
        _avatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sharemore_friendcard.png"]];
        [self.contentView addSubview:_avatorImageView];
        
        self.messageInfo = aMessageInfo;
    }
    return self;
}
- (void)setMessageInfo:(CWMessageInfo *)messageInfo
{
    if (messageInfo != _messageInfo) {
        [_messageInfo release];
        _messageInfo = [messageInfo retain];
        
        if ([self isSelfMessageWithMessageInfo:_messageInfo]) {
            //自己
            _contentView.frame = CGRectMake(0, 0, 320 - (10 + 40 + 10), 128 + 12 + 12);
            _bgImageView.frame = CGRectMake(40, 20, 217, 128);
            _bgImageView.image = [CWUtility stretchableImage:[UIImage imageNamed:@"contant_im_chatto_bg_on.png"] edgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
            _titleLabel.frame = CGRectMake(40 + 10, 25, 185, 35);
            _coverImageView.frame = CGRectMake(40 + 10, 72, 60, 60);
            _contentLabel.frame = CGRectMake(40 + 10 + 60 + 10, 72, 120, 50);
            _avatorImageView.frame = CGRectMake(320 - 10 - 40, 20, 40, 40);

        } else {
            
            _contentView.frame = CGRectMake(10 + 40 + 10, 0, 10 + 217 + 10 + 10, 128 + 12 + 12);
            _bgImageView.frame = CGRectMake(0, 20, 217, 128);
            _titleLabel.frame = CGRectMake(20, 25, 185, 35);
            _coverImageView.frame = CGRectMake(20, 72, 60, 60);
            _contentLabel.frame = CGRectMake(10 + 60 + 10, 72, 120, 50);
            _avatorImageView.frame = CGRectMake(10, 20, 40, 40);

            _bgImageView.image = [CWUtility stretchableImage:[UIImage imageNamed:@"contant_im_chatfrom_bg_press.png"] edgeInsets:UIEdgeInsetsMake(20, 40, 20, 20)];
        }
    }
}

- (BOOL)isSelfMessageWithMessageInfo:(CWMessageInfo *)aMessageInfo
{
    //!!! FIX ME - NOT IMPLEMENTATION
    if (aMessageInfo.fromUserInfoId != 1000) {
        return NO;
    }
    return YES;
}

- (void)dealloc
{
    [_contentView release];
    [_bgImageView release];
    [_titleLabel release];
    [_coverImageView release];
    [_contentLabel release];
    [_avatorImageView release];
    
    [_messageInfo release];
    [super dealloc];
}


@end
