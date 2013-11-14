//
//  CWBaseModel.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-13.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "CWBaseModel.h"

@implementation CWBaseModel

- (id)init
{
    if (self = [super init]) {
        self.sqlUtility = [CWSQLUtility sharedInstance];
    }
    return self;
}

@end
