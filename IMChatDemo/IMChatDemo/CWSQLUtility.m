//
//  CWSQLUtility.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-11.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWSQLUtility.h"
#import "CWUtility.h"

#define ONCE_MESSAGE_COUNT      10

#define DBPATH @"contacts.db"

#define SELECT_ALL_CONTACTS                             @"SELECT * FROM Contacts ORDER BY rTime DESC"

#define CREATE_CONTACTS_TABLE                           @"CREATE TABLE IF NOT EXISTS Contacts (userInfoID BIGINT, remarkName TEXT, nickname TEXT, sortKey TEXT, birthday TIMESTAMP, avatorURL TEXT, PRIMARY KEY(userInfoID))"

#define CREATE_MESSAGES_TABLE                           @"CREATE TABLE IF NOT EXISTS Messages (imMessageId TEXT, type INTEGER, content TEXT, contentType INTEGER, fromUserInfoId BIGINT, toUserInfoId BIGINT, time TIMESTAMP, state INTEGER, sendState INTEGER, PRIMARY KEY(imMessageId, toUserInfoId, fromUserInfoId))"

#define INSERT_CONTACT                                  @"INSERT OR REPLACE INTO Contacts (userInfoID, remarkName, nickname, sortKey, birthday, avatorURL) VALUES (?,?,?,?,?,?)"

#define INSERT_MESSAGE                                  @"INSERT OR REPLACE INTO Messages (imMessageId, type, content, contentType, fromUserInfoId, toUserInfoId, time, state,sendState) VALUES (?,?,?,?,?,?,?,?,?)"

#define DELETE_MESSAGE                                  @"DELETE FROM Messages WHERE imMessageId = ? AND toUserInfoId = ? AND fromUserInfoId = ?"

#define SELECT_MESSAGES                                 @"SELECT * FROM Messages WHERE (fromUserInfoId=? and toUserInfoId=?) or (fromUserInfoId=? and toUserInfoId=?)  order by time desc limit ? offset ?"


@implementation CWSQLUtility

+ (CWSQLUtility *)sharedInstance
{
    static CWSQLUtility *_sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init
{
    if (self = [super init]) {
        _dataBase = [[FMDatabase alloc] initWithPath:[CWUtility documentPath:DBPATH]];
        [_dataBase open];
        [_dataBase executeUpdate:CREATE_CONTACTS_TABLE];
        [_dataBase executeUpdate:CREATE_MESSAGES_TABLE];
        [_dataBase close];
    }
    return self;
}

- (void)dealloc
{
    [_dataBase release];
    [super dealloc];
}

- (NSArray *)messagesFromUserInfoId:(long)aFromUserInfoId
                       toUserInfoId:(long)aToUserInfoId
                          pageIndex:(NSInteger)pageIndex
{
    [_dataBase open];
    NSInteger offset = pageIndex * ONCE_MESSAGE_COUNT;
    NSString *fromUserInfoId = [NSString stringWithFormat:@"%ld",aFromUserInfoId];
    NSString *toUserInfoId = [NSString stringWithFormat:@"%ld", aToUserInfoId];
    FMResultSet *resultSet = [_dataBase executeQuery:SELECT_MESSAGES, fromUserInfoId, toUserInfoId, toUserInfoId, fromUserInfoId, [NSNumber numberWithInteger:ONCE_MESSAGE_COUNT], [NSNumber numberWithInteger:offset]];
    NSMutableArray *messagesArray = [NSMutableArray array];
    while ([resultSet next]) {
        NSString *messageID = [resultSet stringForColumn:@"imMessageId"];
        NSInteger type = [resultSet intForColumn:@"content"];
        NSString *content = [resultSet stringForColumn:@"content"];
        NSInteger contentType = [resultSet intForColumn:@"contentType"];
        long fromUserInfoId = [resultSet longForColumn:@"fromUserInfoId"];
        long toUserInfoId = [resultSet longForColumn:@"toUserInfoId"];
        NSDate *time = [resultSet dateForColumn:@"time"];
        NSInteger state = [resultSet intForColumn:@"state"];
        NSInteger sendState = [resultSet intForColumn:@"sendState"];
        CWMessageInfo *messageInfo = [[[CWMessageInfo alloc] initWithImMessageId:messageID
                                                                            type:type
                                                                     contentType:contentType
                                                                         content:content
                                                                  fromUserInfoId:fromUserInfoId
                                                                    toUserInfoId:toUserInfoId
                                                                            time:time
                                                                           state:state
                                                                       sendState:sendState] autorelease];
        [messagesArray addObject:messageInfo];
    }
    [_dataBase close];
    return messagesArray;
}

- (BOOL)insertMessage:(CWMessageInfo *)aMessageInfo
{
    [_dataBase open];
    BOOL result = [_dataBase executeUpdate:INSERT_MESSAGE, aMessageInfo.imMessageId, [NSNumber numberWithInteger:aMessageInfo.type], aMessageInfo.content, [NSNumber numberWithInteger:aMessageInfo.contentType], [NSNumber numberWithLong:aMessageInfo.fromUserInfoId], [NSNumber numberWithLong:aMessageInfo.toUserInfoId], aMessageInfo.time, [NSNumber numberWithInteger:aMessageInfo.state], [NSNumber numberWithInteger:aMessageInfo.sendState]];
    [_dataBase close];
    return result;
}

- (NSArray *)allContacts
{
    [_dataBase open];
    FMResultSet *resultSet = [_dataBase executeQuery:SELECT_ALL_CONTACTS];
    NSMutableArray *userInfosArray = [NSMutableArray array];
    while ([resultSet next]){
        
        long userInfoID = [resultSet longForColumn:@"userInfoID"];//long
        
        NSString *remarkName = [resultSet stringForColumn:@"remarkName"];
        
        NSString *nickname = [resultSet stringForColumn:@"nickname"];
        
        NSString *sortKey = [resultSet stringForColumn:@"sortKey"];
        
        NSDate *birthday = [resultSet dateForColumn:@"birthday"];
        
        NSString *avatorURL = [resultSet stringForColumn:@"avatorURL"];
        
        CWUserInfo *userInfo = [[[CWUserInfo alloc] initWithUserInfoID:userInfoID
                                                           remarkName:remarkName
                                                             nickName:nickname
                                                              sortKey:sortKey
                                                             birthday:birthday
                                                            avatorURL:avatorURL] autorelease];
        [userInfosArray addObject:userInfo];
    }
    [_dataBase close];
    return userInfosArray;
}



@end
