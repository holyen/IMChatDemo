//
//  CWMessageModel.h
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-13.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWBaseModel.h"

#define KVO_MESSAGES_PATH                   @"messagesArray"

@interface CWMessageModel : CWBaseModel

@property (retain, nonatomic) NSMutableArray *messagesArray;

- (void)messagesFromUserInfoId:(long)aFromUserInfoId
                  toUserInfoId:(long)aToUserInfoId
                     pageIndex:(NSInteger)pageIndex;

- (BOOL)saveMessage:(CWMessageInfo *)aMessageInfo;

@end
