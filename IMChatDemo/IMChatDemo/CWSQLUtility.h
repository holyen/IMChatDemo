//
//  CWSQLUtility.h
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-11.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "CWUserInfo.h"
#import "CWMessageInfo.h"

@interface CWSQLUtility : NSObject
{
    FMDatabase *_dataBase;
}

+ (CWSQLUtility *)sharedInstance;

- (NSArray *)messagesFromUserInfoId:(long)aFromUserInfoId
                       toUserInfoId:(long)aToUserInfoId
                          pageIndex:(NSInteger)pageIndex;

- (NSArray *)allContacts;

- (BOOL)insertMessage:(CWMessageInfo *)aMessageInfo;

@end
