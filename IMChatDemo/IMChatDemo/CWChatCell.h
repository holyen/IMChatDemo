//
//  CWChatCell.h
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-13.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWUtility.h"
#import "CWMessageInfo.h"

@interface CWChatCell : UITableViewCell
{
    UIView *_dateView;
    UIImageView *_dateBGImageView;
    UILabel *_dateLabel;
    
    UIView *_contentView;
    UIImageView *_contentBGImageView;
    UILabel *_contentLabel;
    
    UIImageView *_photoContentImageView;
    
    UILabel *_voiceTimeLabel;
    
    UIImageView *_avatorImageView;
    
    UIFont *_dateFont;
    UIFont *_contentFont;
}

@property (retain, nonatomic) CWMessageInfo *messageInfo;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
        messageInfo:(CWMessageInfo *)aMessageInfo;

@end
