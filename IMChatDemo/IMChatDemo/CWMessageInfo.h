//
//  CWMessageInfo.h
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-11.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWMessageInfo : NSObject

@property (nonatomic, copy) NSString            *imMessageId;

@property (nonatomic, assign) NSInteger         type;               //消息类型 1个人 2系统；

@property (nonatomic, copy) NSString            *content;           //消息内容

@property (nonatomic, assign) NSInteger         contentType;        //消息内容类型 1文本+表情消息 2纯图片消息 3语音

@property (nonatomic, assign) long              fromUserInfoId;

@property (nonatomic, assign) long              toUserInfoId;

@property (nonatomic, copy) NSDate              *time;

@property (nonatomic, assign) NSInteger         state;

@property (nonatomic, assign) NSInteger         sendState;          //消息发送状态  成功：0 失败：1 正在处理：2 成功

- (id)initWithImMessageId:(NSString *)aImMessageId
                     type:(NSInteger)aType
              contentType:(NSInteger)aContentType
                  content:(NSString *)aContent
           fromUserInfoId:(long)aFromUserInfoId
             toUserInfoId:(long)aToUserInfoId
                     time:(NSDate *)aTime
                    state:(NSInteger)aState
                sendState:(NSInteger)sendState;

- (id)deepCopy;

@end
