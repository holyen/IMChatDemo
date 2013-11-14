//
//  CWUserInfo.h
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-11.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWUserInfo : NSObject

@property (nonatomic, assign) long          userInfoID;

@property (nonatomic, copy) NSString        *remarkName;

@property (nonatomic, copy) NSString        *nickname;

@property (nonatomic, copy) NSString        *sortKey;

@property (nonatomic, copy) NSDate          *birthday;

@property (nonatomic, assign) NSString      *avatorURL;

- (id)initWithUserInfoID:(long)aUserInfoID
              remarkName:(NSString *)aRemarkName
                nickName:(NSString *)aNickName
                 sortKey:(NSString *)aSortKey
                birthday:(NSDate *)aBirthday
               avatorURL:(NSString *)aAvatorURL;

@end
