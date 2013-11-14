//
//  CWMessageModel.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-13.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWMessageModel.h"

@implementation CWMessageModel

- (void)messagesFromUserInfoId:(long)aFromUserInfoId
                  toUserInfoId:(long)aToUserInfoId
                     pageIndex:(NSInteger)pageIndex
{
    NSArray *messagesArray = [self.sqlUtility messagesFromUserInfoId:aFromUserInfoId
                                                        toUserInfoId:aToUserInfoId
                                                           pageIndex:pageIndex];
    self.messagesArray = messagesArray;
}

- (void)dealloc
{
    [_messagesArray release];
    [super dealloc];
}

@end
