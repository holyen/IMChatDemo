//
//  CWUserInfo.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-11.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWUserInfo.h"

@implementation CWUserInfo

- (id)initWithUserInfoID:(long)aUserInfoID
              remarkName:(NSString *)aRemarkName
                nickName:(NSString *)aNickName
                 sortKey:(NSString *)aSortKey
                birthday:(NSDate *)aBirthday
               avatorURL:(NSString *)aAvatorURL
{
    if (self = [super init]) {
        self.userInfoID = aUserInfoID;
        self.remarkName = aRemarkName;
        self.nickname = aNickName;
        self.sortKey = aSortKey;
        self.birthday = aBirthday;
        self.avatorURL = aAvatorURL;
    }
    return self;
}

- (void)dealloc
{
    [_remarkName release];
    [_nickname release];
    [_sortKey release];
    [_birthday release];
    [_avatorURL release];
    [super dealloc];
}

@end
