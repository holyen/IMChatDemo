//
//  CWRecordUtility.h
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-8.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <AVFoundation/AVFoundation.h>
#import "AudioToolbox/AudioToolbox.h"
#import "amrFileCodec.h"
#import "interf_dec.h"
#import "dec_if.h"
#import "interf_enc.h"

@interface CWRecordUtility : NSObject <AVAudioRecorderDelegate>

@property (copy, nonatomic) NSString *path;//录音后的wav path

@property (copy, nonatomic) NSString *amrPath;//从wav 转成amr的路径.

@property (copy, nonatomic) NSString *wavNewPath;//从amr转换成wav后的新路径

@property (assign, nonatomic) NSInteger maxRecordTime;//最大录音时间

@property (copy, nonatomic) NSString *recordFileName;

@property (copy, nonatomic) NSString *recordFilePath;

@property (retain, nonatomic) AVAudioRecorder *recorder;

@property (retain, nonatomic) AVAudioPlayer *player;


+ (NSString *)currentTimeString;

+ (NSString *)voiceDocumentDirectory;

+ (NSString *)voiceCacheDirectory;

+ (BOOL)fileExistsAtPath:(NSString *)aPath;

+ (BOOL)deleteFileAtPath:(NSString *)aPath;

- (void)beginRecordByFileName:(NSString *)aFileName;

- (void)stopRecord;

+ (NSDictionary*)audioRecorderSettingDict;

- (void)playRecordByPath:(NSString *)aPath;

- (NSInteger)sizeOfFileFromPath:(NSString *)aFilePath;

+ (BOOL)amrToWav:(NSString*)aAmrPath savePath:(NSString*)aSavePath;

+ (BOOL)wavToAmr:(NSString*)aWavPath savePath:(NSString*)aSavePath;

+ (double)durationFromPath:(NSString *)aFilePath;

@end
