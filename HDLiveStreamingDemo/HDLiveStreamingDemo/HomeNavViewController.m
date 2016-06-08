//
//  HomeNavViewController.m
//  HDLive
//
//  Created by doulai on 3/8/16.
//  Copyright © 2016 doulai. All rights reserved.
//

#import "HomeNavViewController.h"

@interface HomeNavViewController ()

@end

@implementation HomeNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    NSLog(@"should orientation =%ld",(long)interfaceOrientation);
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (BOOL)shouldAutorotate NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED;
{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return   UIInterfaceOrientationMaskPortrait;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
