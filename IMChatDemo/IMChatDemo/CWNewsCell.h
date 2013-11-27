//
//  CWNewsCell.h
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-27.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWMessageInfo.h"

@interface CWNewsCell : UITableViewCell
{
    UIView *_contentView;
    UIImageView *_bgImageView;
    UILabel *_titleLabel;
    UIImageView *_coverImageView;
    UILabel *_contentLabel;
    
    UIImageView *_avatorImageView;
}

@property (retain, nonatomic) CWMessageInfo *messageInfo;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
        messageInfo:(CWMessageInfo *)aMessageInfo;

@end
