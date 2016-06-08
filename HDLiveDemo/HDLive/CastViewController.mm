//
//  CastViewController.m
//  HDLive
//
//  Created by doulai on 2/22/16.
//  Copyright © 2016 doulai. All rights reserved.
//

#import "CastViewController.h"
#import "HardLiveStreamingSdk.h"
#import "LivePredefine.h"
//#import "NetworkTask.h"
#import "Reachability.h"
//#import "XFBPredefine.h"
@interface CastViewController ()<ReportDelegate>
{
    HardLiveStreamingSdk *livesdk;
    NSTimer *timer;
    NSTimer *startTimer;
    UIView *startView;
    int eclipetime ;
    NSTimeInterval starttime;
    double bitratesum;
    //tap
    UITapGestureRecognizer *tapR;
    UIView *tapView;
    BOOL btnstates[6];
    
    NSArray *imgNormalName;
    NSArray *imgSelectedName;
    
}

@end

@implementation CastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    livesdk =[[HardLiveStreamingSdk alloc] init];
    livesdk.delegate =self;
    livesdk.encoderType =0;//软编码，1，2为硬编码
    bitratesum  =0;
    
    
    imgNormalName =@[@"麦克风",@"禁止闪光灯",@"切换摄像头",@"聚焦",@"播放"];
    imgSelectedName =@[@"禁止麦克风",@"闪光灯",@"切换摄像头",@"聚焦",@"播放"];
    for (int i =0 ; i<6; i++) {
        btnstates[i] =NO;
        
    }
    
    for (int i=1; i<6; i++) {
        UIButton *tmp =[self.view viewWithTag:(i)];
        [tmp setBackgroundImage:[UIImage imageNamed:imgNormalName[i-1]] forState:UIControlStateNormal];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification object:nil]; //监听是否触发home键挂起程序.
}
-(void)viewDidAppear:(BOOL)animated{
    eclipetime  =2;
    startTimer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    NSNumber *qulity =[[NSUserDefaults standardUserDefaults] objectForKey:kVIDEOQUALITY];
    NSArray *choosed =VIDEO_QUALITY_LIST[[qulity integerValue]];
    NSNumber* w =choosed[1] ;
    NSNumber *h =choosed[2] ;
    NSNumber *br =choosed[3];
    NSNumber *daikuan = [[NSUserDefaults standardUserDefaults] objectForKey:kVIDEOBitratecontrol];
    if ([daikuan integerValue]==1) {
        br =@0;
    }
    
    //    开始预览
    [livesdk lib_doulai_record_start_preview:self.view videoWidth:[w intValue] height:[h intValue] bitrate:[br intValue]];
    
    startView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    startView.center =self.view.center;
    [startView setBackgroundColor:[UIColor clearColor]];
    
    UILabel *tmp =[[UILabel alloc] initWithFrame:CGRectMake(10, 15, 40, 30)];
    tmp.text =@"";
    [tmp setFont:[UIFont systemFontOfSize:40]];
    [tmp setTextColor:[UIColor blueColor]];
    [tmp setBackgroundColor:[UIColor clearColor]];
    [tmp setTextAlignment:NSTextAlignmentCenter];
    tmp.tag =1;
    //    tmp.center =startView.center;
    [startView addSubview:tmp];
    [self.view addSubview:startView];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [startTimer invalidate];
    [timer invalidate];
    
}
-(void)applicationWillResignActive:(id)sender{
    [self stopLive];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark view init

-(void)timerStart:(NSTimer*)sender{
    startView.center =self.view.center;
    
    UILabel *tmp =[startView viewWithTag:1];
    tmp.text =[NSString stringWithFormat:@"%d",eclipetime ];
    
    
    if (eclipetime ==0) {
        [startTimer invalidate];
        [startView removeFromSuperview];
        [sender invalidate ];
        
        starttime =[[NSDate date] timeIntervalSince1970];
        
        
        [ [ UIApplication sharedApplication] setIdleTimerDisabled:YES ] ;
        [self performSelectorInBackground:@selector(startLiveCast) withObject:nil];
    }
    eclipetime-= sender.timeInterval;
    
    
}
-(void)startLiveCast{
    [livesdk lib_doulai_record_start_upload:[self.uploadUrl UTF8String]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)reportFps:(int)fps bitrate:(int)bitrate width:(int)w height:(int)h ;{
    
    UILabel *wifi =[self.view viewWithTag:10];
    NSTimeInterval timelen =[[NSDate date] timeIntervalSince1970];
    timelen -=starttime;
    NSDateFormatter *format =[[NSDateFormatter alloc] init];
    if (timelen >=60*60) {
        [format setDateFormat:@"HH:mm:ss"];
    }else
        [format setDateFormat:@"mm:ss"];
    bitratesum +=bitrate;
    NSString *bitstr= [NSString stringWithFormat:@"%.2fM",bitratesum/1024.0];
    
    NSString *timestr =[format stringFromDate:[NSDate dateWithTimeIntervalSince1970:timelen]];
    NSMutableAttributedString *wifiattr =[[NSMutableAttributedString alloc] init];
    NSString *wifitype =[NSString stringWithFormat: @"%@网络在线  ",[Reachability GetNetWorkType]];
    [wifiattr appendAttributedString:[[NSAttributedString alloc] initWithString:wifitype attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}]];
    [wifiattr appendAttributedString:[[NSAttributedString alloc] initWithString:timestr attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}]];
    
    [wifiattr appendAttributedString:[[NSAttributedString alloc] initWithString:@"  流量  " attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}]];
    [wifiattr appendAttributedString:[[NSAttributedString alloc] initWithString:bitstr attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}]];
    
    
    
    
    wifi.attributedText =wifiattr;
    UILabel *size =[self.view viewWithTag:11];
    size.text =[NSString stringWithFormat:@"size:%dx%d fps:%d br:%dkbps",w,h,fps,bitrate];
    
}
#pragma mark button
- (IBAction)stopCastPress:(UIButton *)sender {
    
    if (btnstates[sender.tag]) {
        btnstates[sender.tag] = NO;
        [sender setBackgroundImage:[UIImage imageNamed:imgNormalName[sender.tag-1]] forState:UIControlStateNormal];
    }else
    {
        [sender setBackgroundImage:[UIImage imageNamed:imgSelectedName[sender.tag-1]] forState:UIControlStateNormal];
        btnstates[sender.tag] =YES;
    }
    BOOL state =btnstates[sender.tag];
    switch (sender.tag) {
        case 1://
            
            
            
            [livesdk lib_doulai_audio_switchMute];
            break;
        case 2:
            if (state) {
                [livesdk lib_doulai_video_setFlashMode:1];
                
            }else
            {
                [livesdk lib_doulai_video_setFlashMode:0];
                
            }
            
            break;
        case 3:
            [livesdk lib_doulai_video_switchCapture];
            break;
            
        case 4://focus
        {
            if (state) {
                tapView  =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
                [tapView setBackgroundColor:[UIColor clearColor]];
                tapView.layer.borderWidth = 2;
                tapView.layer.borderColor = [[UIColor greenColor] CGColor];
                tapView.center =self.view.center;
                [self.view addSubview:tapView];
                tapR =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapview:)];
                [self.view addGestureRecognizer:tapR];
                
            }else
            {
                
                [self.view removeGestureRecognizer:tapR];
                [tapView removeFromSuperview];
            }
            
            
            
        }
            break;
        case 5:
        {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"是否停止直播？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            break;
        }
            
        default:
            break;
    }
    
}


-(void)stopLive{
    
    
    
    [ [ UIApplication sharedApplication] setIdleTimerDisabled:NO ] ;
    [livesdk lib_doulai_record_stop_upload];
    [livesdk lib_doulai_record_stop_preview];
    livesdk.delegate =nil;
    
    [timer invalidate];
    [startTimer invalidate];
    
    
    
}
-(void)tapview:(UITapGestureRecognizer*)sender{
    CGPoint point=  [sender locationInView:self.view];
    if (point.x<45+tapView.frame.size.width/2 || point.x >self.view.frame.size.width-45-tapView.frame.size.width/2) {
        return;
    }
    tapView.center =point;
    
    CGPoint p =CGPointMake(point.x/self.view.frame.size.width, point.y/self.view.frame.size.height);
    [livesdk lib_doulai_video_switchFocus:p];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    NSLog(@"should orientation =%ld",(long)interfaceOrientation);
    
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
- (NSUInteger)supportedInterfaceOrientations
{
    
    NSNumber *qulity =[[NSUserDefaults standardUserDefaults] objectForKey:kVIDEOQUALITY];
    if ([qulity integerValue]==0) {
        return UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskLandscapeRight;
}
#pragma mark private
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( buttonIndex ==1)
    {
        [self performSelectorInBackground:@selector(stopLive) withObject:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}



@end
