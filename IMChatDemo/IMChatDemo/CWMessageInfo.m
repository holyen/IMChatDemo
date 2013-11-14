//
//  CWMessageInfo.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-11.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWMessageInfo.h"

@implementation CWMessageInfo

- (id)initWithImMessageId:(NSString *)aImMessageId
                     type:(NSInteger)aType
              contentType:(NSInteger)aContentType
                  content:(NSString *)aContent
           fromUserInfoId:(long)aFromUserInfoId
             toUserInfoId:(long)aToUserInfoId
                     time:(NSDate *)aTime
                    state:(NSInteger)aState
                sendState:(NSInteger)aSendState
{
    if (self = [super init]) {
        self.imMessageId = aImMessageId;
        self.type = aType;
        self.contentType = aContentType;
        self.content = aContent;
        self.fromUserInfoId = aFromUserInfoId;
        self.toUserInfoId = aToUserInfoId;
        self.time = aTime;
        self.state = aState;
        self.sendState = aSendState;
    }
    return self;
}

- (void)dealloc
{
    [_imMessageId release];
    [_content release];
    [_time release];
    [super dealloc];
}

- (id)deepCopy
{
    return nil;
}

@end
