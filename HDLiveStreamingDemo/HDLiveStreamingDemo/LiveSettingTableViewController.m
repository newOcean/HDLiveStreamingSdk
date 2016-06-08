//
//  LiveSettingTableViewController.m
//  HDLive
//
//  Created by doulai on 2/19/16.
//  Copyright © 2016 doulai. All rights reserved.
//

#import "LiveSettingTableViewController.h"
#import "LivePredefine.h"

#import "CastViewController.h"
#import "HardLiveStreamingSdk.h"


@interface LiveSettingTableViewController ()<UIActionSheetDelegate>
{
    NSArray *dataSource;
    
    UIDocumentInteractionController *documentController ;
    UITextField *urltextfield;
    
    HardLiveStreamingSdk *livesdk;
}
@end

@implementation LiveSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    dataSource =@[(@"服务器地址") ,@"直播视频质量",@"带宽设置",@"技术合作",@"QQ咨询"];
    UIView *tmpView = [[UIView alloc] init];
    [self.view setBackgroundColor: BACKGROUNDCORLOR];
    self.tableView.tableFooterView = tmpView;
    self.title =@"RTMP推流";
    if(!urltextfield)
    {
        urltextfield =[[UITextField alloc] initWithFrame:CGRectMake(8, 2, self.view.frame.size.width-10, 40)];
        urltextfield.borderStyle =UITextBorderStyleRoundedRect;
        urltextfield.placeholder =@"服务器地址";
        urltextfield.clearButtonMode =UITextBorderStyleLine;
        [urltextfield setFont:[UIFont systemFontOfSize:14]];
        urltextfield.returnKeyType = UIReturnKeyDone;
        [urltextfield addTarget:self action:@selector(HideKeyboard) forControlEvents:UIControlEventEditingDidEndOnExit];
        NSString *url =[[NSUserDefaults standardUserDefaults] objectForKey:@"defaultserver"];
      
        urltextfield.text =url;
    }
    
    
}
-(void)HideKeyboard{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIView*)headerview
{
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    UIImageView *imagview =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 68)];
    [imagview setImage:[UIImage imageNamed:@"logo"]];
    imagview.center =view.center;
    [view addSubview:imagview];
    [view setBackgroundColor: BACKGROUNDCORLOR];
    return view;
}
-(void)footview{
    UIButton *lices =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    [lices setTitle:@"软件使用许可及服务协议" forState:UIControlStateNormal];
    [lices setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    CGPoint center =self.view.center;
    CGRect frame =self.view.frame;
    
    center.y =self.view.frame.size.height -116;
    lices.center =center;
    
    [self.view addSubview:lices];
    
    UILabel *about = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 21)];
    about.textAlignment = NSTextAlignmentCenter;
    about.text =@"掌上科技版权所有";
    about.textColor =[UIColor grayColor];
    center.y  = self.view.frame.size.height   -85;
    about.center =center;
    [self.view addSubview:about];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    if (section ==0) {
        return dataSource.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    //    if (section ==1) {
    return 20.;
    //    }
    //    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0)
    {
        
        
        
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"x" ];
        if (!cell) {
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"x"];
        }
        
        cell.textLabel.text =dataSource[indexPath.row];
        
        if (indexPath.row ==0) {
            
            cell.textLabel.text =nil;
            
            [cell addSubview:urltextfield];
            
            
        }else if(indexPath.row==1){
            NSNumber *videoQulity =[[NSUserDefaults standardUserDefaults] objectForKey:kVIDEOQUALITY];
            NSArray *tmp = VIDEO_QUALITY_LIST[[videoQulity integerValue]];
            cell.detailTextLabel.text =tmp[0];
            cell.detailTextLabel.textColor =[UIColor blueColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if(indexPath.row ==2)
        {
            
            NSNumber *videoQulity =[[NSUserDefaults standardUserDefaults] objectForKey:kVIDEOBitratecontrol];
            NSString *tmp = VIDEO_BITRATE_CONTROL[[videoQulity integerValue]];
            cell.detailTextLabel.text =tmp;
            cell.detailTextLabel.textColor =[UIColor blueColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(indexPath.row== 3)
        {
            cell.detailTextLabel.text=@"+8615988879319";
            cell.detailTextLabel.textColor =[UIColor blueColor];
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
            
        }
        else if(indexPath.row== 4)
        {
            cell.detailTextLabel.text=@"153887715";
            cell.detailTextLabel.textColor =[UIColor blueColor];
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
            
        }
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"y" ];
        if (!cell) {
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"y"];
        }
        if (indexPath.section ==1) {
            cell.textLabel.text =@"开始推流";
            cell.textLabel.textColor =[UIColor redColor];
        }else if(indexPath.section ==2)
        {
            cell.textLabel.text =@"开始播放";
            cell.textLabel.textColor =[UIColor blueColor];
        }else if(indexPath.section ==3)
        {
            cell.textLabel.text =@"播放录制视频";
            cell.textLabel.textColor =[UIColor blueColor];
        }
        
        
        cell.textLabel.textAlignment =NSTextAlignmentCenter;
        return cell;
        
    }
    // Configure the cell...
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section ==0) {
        if (indexPath.row ==1) {
            UIActionSheet *sheet =[[UIActionSheet alloc] initWithTitle:@"选择视频质量" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
            for (NSArray *item in VIDEO_QUALITY_LIST) {
                [sheet addButtonWithTitle:item[0]];
            }
            sheet.tag=1;
            [sheet showInView:self.view];
        }else if(indexPath.row ==2)
        {
            UIActionSheet *sheet =[[UIActionSheet alloc] initWithTitle:@"带宽设置" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
            for (NSString *item in VIDEO_BITRATE_CONTROL) {
                [sheet addButtonWithTitle:item];
            }
            sheet.tag =2;
            [sheet showInView:self.view];
        }
        else if (indexPath.row==3){
            UITableViewCell*cell =[tableView cellForRowAtIndexPath:indexPath];
            NSString *phone =cell.detailTextLabel.text;
            //
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phone];
            //            NSLog(@"str======%@",str);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }
        else if (indexPath.row==4){
            UITableViewCell*cell =[tableView cellForRowAtIndexPath:indexPath];
            NSString *phone =cell.detailTextLabel.text;
            [self pressQQ:nil];
            
        }
    }else {
        
        
        NSString*serverurl =urltextfield.text;
        if(serverurl)
            [[NSUserDefaults standardUserDefaults] setObject:serverurl forKey:@"defaultserver"];
        
        if (indexPath.section ==1) {
            [self pressLive];
            
        }else if(indexPath.section ==2){
            
            [self playMovie:serverurl];
        }else if(indexPath.section ==3){
            //
            //            [self playMovie:serverurl];
            [self playRecords];
        }
        
    }
    
}
-(void)playRecords{
    NSArray*tmp= [[NSUserDefaults standardUserDefaults] objectForKey:@"filelist"];
    if (tmp.count ==0) {
        return;
    }
    UIActionSheet*sheet =[[UIActionSheet alloc] initWithTitle:@"choose" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:nil];
    sheet.tag =10;
    for (NSString *item in tmp) {
        [sheet addButtonWithTitle:item];
    }
    [sheet showInView:self.view];
}

-(void)playRecord:(NSString*)file{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    NSString *path =[self dataFilePath:file];
    
    [self sendToQQ:path];
    return;
    
    
    
}
-(void)playMovie:(NSString*)path{
    
    //播放器接口，可以播放各种格式
    if(!livesdk)
        livesdk =[[HardLiveStreamingSdk alloc] init];
    
    [livesdk lib_doulai_single_play_start:self.navigationController playAdress:path];
    
    
}
- (IBAction)pressQQ:(id)sender {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSURL *url = [NSURL URLWithString:@"mqq://im/chat?chat_type=wpa&uin=153887715&version=1&src_type=web&msg=live"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    webView.delegate = self;
    [webView loadRequest:request];
    [self.view addSubview:webView];
}
-(void)sendToQQ:(NSString*)filepath{
    
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filepath])
        return;
    
    NSString *cachePath =filepath;
    
    
    documentController =
    
    
    [UIDocumentInteractionController
     
     interactionControllerWithURL:[NSURL fileURLWithPath:cachePath]];
    
    documentController.delegate = self;
    
    
    [documentController presentOpenInMenuFromRect:CGRectZero
     
                                           inView:self.view
     
                                         animated:YES];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ( buttonIndex >0) {
        if (actionSheet.tag ==1) {
            NSNumber *video =[NSNumber numberWithInteger:buttonIndex-1] ;
            [[NSUserDefaults standardUserDefaults] setObject:video forKey:kVIDEOQUALITY];
            NSNumber *fps =@15;
            if (buttonIndex ==1) {
                fps =@25;
            }
            [[NSUserDefaults standardUserDefaults] setObject:fps forKey:@"kVIDEO_FPS"];
            
        }else if(actionSheet.tag==10)
        {
            NSArray*tmp= [[NSUserDefaults standardUserDefaults] objectForKey:@"filelist"];
            if (buttonIndex>0 &&buttonIndex <=tmp.count) {
                
                [self playRecord:tmp[buttonIndex-1]];
                
            }
        }else
        {
            NSNumber *video =[NSNumber numberWithInteger:buttonIndex-1] ;
            [[NSUserDefaults standardUserDefaults] setObject:video forKey:kVIDEOBitratecontrol];
        }
        
        [self.tableView reloadData];
        
    }
}
-(void)pressLive{
    CastViewController *detail =[CastViewController new];
    
    detail.uploadUrl = [urltextfield.text lowercaseString];
    if (![detail.uploadUrl hasPrefix:@"rtmp://"]) {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil  message:@"请输入完整RTMP流服务器地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [self presentViewController:detail animated:YES completion:nil];
}

-(NSString *)dataFilePath:(NSString*)file{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent:file];
    
}

@end
