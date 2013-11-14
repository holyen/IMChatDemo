//
//  NSDate+Help.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-13.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "NSDate+Help.h"

@implementation NSDate (Help)

- (NSString *)toStringHasTime:(BOOL)aHastime
{
    NSInteger interval = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:self];
    NSDate *localDate = [self dateByAddingTimeInterval:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (aHastime)
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    else
        [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *retDate = [formatter stringFromDate:localDate];
    return retDate;
}

@end
