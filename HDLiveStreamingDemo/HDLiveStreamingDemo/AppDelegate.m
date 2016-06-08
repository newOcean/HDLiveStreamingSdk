//
//  AppDelegate.m
//  HDLive
//
//  Created by doulai on 2/18/16.
//  Copyright (c) 2016 doulai. All rights reserved.
//

#import "AppDelegate.h"

#import "LivePredefine.h"

@interface AppDelegate ()
{
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self appearanceConfig];

    NSNumber *videosetting =[[NSUserDefaults standardUserDefaults] objectForKey:kVIDEOQUALITY];
    if (!videosetting) {
        videosetting =@2;
        [[NSUserDefaults standardUserDefaults] setObject:videosetting forKey:kVIDEOQUALITY];
    }
    return YES;
}
- (void)appearanceConfig
{
//    if (IOS7_OR_LATER)
    { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setBackgroundImage:[self statusBar] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18.]}];
}

- (UIImage *)statusBar
{
    UIImage *image;
    UIGraphicsBeginImageContext(CGSizeMake([UIScreen mainScreen].bounds.size.width, 20.));
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20.)];
    CAGradientLayer *gradientLayer1 =  [CAGradientLayer layer];
    gradientLayer1.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20.);
        [gradientLayer1 setColors:@[(id)[UIColor blueColor].CGColor,(id)[UIColor purpleColor].CGColor]];
//    [gradientLayer1 setColors:@[(id)[UIColor colorWithRed:21 green:55 blue:114 alpha:1].CGColor,(id)[UIColor colorWithRed:21 green:55 blue:114 alpha:1].CGColor]];
    [gradientLayer1 setStartPoint:CGPointMake(0, 0)];
    [gradientLayer1 setEndPoint:CGPointMake(1, 0)];
    [view.layer addSublayer:gradientLayer1];
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
