//
//  CWBaseModel.h
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-13.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWSQLUtility.h"

@interface CWBaseModel : NSObject

@property (retain, nonatomic) CWSQLUtility *sqlUtility;

@end
