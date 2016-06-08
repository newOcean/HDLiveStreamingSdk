//
//  HardLiveStreamingSdk.h
//  HardLiveStreamingSdk
//
//  Created by doulai on 6/8/16.
//  Copyright © 2016 doulai. All rights reserved.
//

//readme
//调用者必须是.mm文件

//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <pthread.h>
#define ERROR_NETWORK -10
#define ERROR_CAMERA -11
#define ERROR_AUDIO -12
#define ERROR_PERMISSION -13
#define IOS8VT [[[UIDevice currentDevice] systemVersion]floatValue]>=8

@protocol ReportDelegate <NSObject>

@optional

-(void)reportFps:(int)fps bitrate:(int)bitrate width:(int)w height:(int)h ;
@end


@interface HardLiveStreamingSdk : NSObject
@property (assign) id<ReportDelegate> delegate;
@property int encoderType; //0 software ,1 HaredWare1,2 HaredWareFile


//播放接口，支持各种视频格式
- (void)lib_doulai_single_play_start:(UINavigationController *) nav playAdress:(NSString *)path;



- (int)  lib_doulai_record_support;
//视频预览
- (void) lib_doulai_record_start_preview:(UIView *)parentView videoWidth:(int)w height:(int)h bitrate:(int)br;

- (void) lib_doulai_record_stop_preview;
//开始推流
- (void) lib_doulai_record_start_upload:(const char*)url;
- (void) lib_doulai_record_stop_upload;
//视频控制接口
- (void) lib_doulai_video_switchCapture;
- (int)  lib_doulai_video_hasFlashMode;
- (void) lib_doulai_video_setFlashMode:(int)flashmode;
- (void) lib_doulai_audio_switchMute;
-(void)lib_doulai_video_switchFocus:(CGPoint)forcusP;


@property (readwrite) BOOL playing;
@property (readwrite) BOOL previewing;
@property (readwrite) BOOL uploading;

@end
