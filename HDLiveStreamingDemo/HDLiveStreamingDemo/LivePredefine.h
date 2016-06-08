//
//  LivePredefine.h
//  HDLive
//
//  Created by doulai on 2/19/16.
//  Copyright © 2016 doulai. All rights reserved.
//

#ifndef LivePredefine_h
#define LivePredefine_h

#define VIDEO_QUALITY_LIST @[@[@"竖屏",@480,@640,@80],\
@[@"标清",@352,@288,@30],\
@[@"D1 高清",@640,@480,@80],\
@[@"720P 高清",@1280,@720,@120],\
@[@"1080P 超清",@1980,@1080,@500]]\


#define VIDEO_BITRATE_CONTROL @[@"恒定速率",@"动态调节"]

#define kVIDEOQUALITY @"kVideoqulity"
#define kVIDEOBitratecontrol @"kVideobitratecontrol"
#define kNotify_logout @"kNotify_logout"
#define kNotify_login @"kNotify_login"

#define BACKGROUNDCORLOR [UIColor colorWithRed:225./255. green:225./255. blue:233./255. alpha:1.]
#endif /* LivePredefine_h */
