//
//  CWRecordUtility.m
//  IMChatDemo
//
//  Created by Holyen Zou on 13-11-8.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "wav.h"
#import "CWRecordUtility.h"

@implementation CWRecordUtility

+ (NSString *)currentTimeString
{
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyyMMddHHmmss"];
    return [dateformat stringFromDate:[NSDate date]];
}

+ (NSString *)voiceDocumentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    return [[paths objectAtIndex:0]stringByAppendingPathComponent:@"Voice"];
}

+ (NSString *)voiceCacheDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (BOOL)fileExistsAtPath:(NSString *)aPath
{
    return [[NSFileManager defaultManager] fileExistsAtPath:aPath];
}

+ (BOOL)deleteFileAtPath:(NSString *)aPath
{
    return [[NSFileManager defaultManager] removeItemAtPath:aPath error:nil];
}

- (void)beginRecordByFileName:(NSString *)aFileName
{
    NSString *newPath = [NSString stringWithFormat:@"%@.wav",aFileName];
    _wavNewPath = [[CWRecordUtility voiceDocumentDirectory] stringByAppendingPathComponent:newPath];

    NSString *amrPath = [NSString stringWithFormat:@"%@.amr",aFileName];
    _amrPath = [[CWRecordUtility voiceDocumentDirectory] stringByAppendingPathComponent:amrPath];
    
    NSString *path = [[CWRecordUtility voiceDocumentDirectory] stringByAppendingPathComponent:newPath];
    _path = path;
    NSLog(@"voice 's path : %@",_path);
    self.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:path]
                                                settings:[CWRecordUtility audioRecorderSettingDict]
                                                   error:nil];
    self.recorder.delegate = self;
    self.recorder.meteringEnabled = YES;
    [self.recorder prepareToRecord];

    [self.recorder record];
}

- (void)stopRecord
{
    if (self.recorder.isRecording)
        [self.recorder stop];
}

- (void)playRecordByPath:(NSString *)aPath
{
    UInt32 doChangeDefaultRoute = 1;
    AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryDefaultToSpeaker,sizeof(doChangeDefaultRoute),&doChangeDefaultRoute);
    
    NSError *error;
    _player = [[AVAudioPlayer alloc] init];
    _player = [_player initWithContentsOfURL:[NSURL URLWithString:aPath] error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    [_player play];
}

/**
 获取录音设置
 [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,//大端还是小端 是内存的组织方式
 [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,//采样信号是整数还是浮点数
 [NSNumber numberWithInt: AVAudioQualityLow],AVEncoderAudioQualityKey,//音频编码质量
 @returns 录音设置
 */
+ (NSDictionary*)audioRecorderSettingDict
{
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey, //采样率
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,//采样位数 默认 16
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,//通道的数目
                                   nil];
    return recordSetting;
}

- (NSInteger)sizeOfFileFromPath:(NSString *)aFilePath
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if ([fileManager fileExistsAtPath:aFilePath]) {
        NSError *error = nil;
        NSDictionary *attributes = [fileManager attributesOfItemAtPath:aFilePath error:&error];
        NSNumber *fileSize;
        if ((fileSize = [attributes objectForKey:NSFileSize])) {
            return [fileSize intValue];
        } else {
            return -1;
        }
    } else {
        return -1;
    }
}

+ (double)durationFromPath:(NSString *)aFilePath
{
    //aFilePath = @"/var/mobile/Applications/EC12D021-211E-4CDC-96EF-33E40266F45F/Documents/20131121163353.wav";
    NSError *error;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:aFilePath] error:&error];
    [player prepareToPlay];
    if (error) {
        NSLog(@"%@", error.description);
    }
    return player.duration;
}

+ (BOOL)amrToWav:(NSString*)aAmrPath savePath:(NSString*)aSavePath
{
    if (DecodeAMRFileToWAVEFile([aAmrPath cStringUsingEncoding:NSASCIIStringEncoding], [aSavePath cStringUsingEncoding:NSASCIIStringEncoding]))
        return YES;
    
    return NO;
}

+ (BOOL)wavToAmr:(NSString*)aWavPath savePath:(NSString*)aSavePath
{
    if (EncodeWAVEFileToAMRFile([aWavPath cStringUsingEncoding:NSASCIIStringEncoding], [aSavePath cStringUsingEncoding:NSASCIIStringEncoding], 1, 16))
        return YES;
    
    return NO;
}

#pragma mark -
#pragma mark - AVAudioRecorderDelegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSLog(@"录音停止");
}

- (void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder
{
    NSLog(@"录音开始");
}

- (void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder withOptions:(NSUInteger)flags
{
    NSLog(@"录音中断");
}

@end
