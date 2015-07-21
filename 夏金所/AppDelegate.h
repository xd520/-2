//
//  AppDelegate.h
//  夏金所
//
//  Created by mac on 15/5/30.
//  Copyright (c) 2015年 ApexSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorUtil.h"
#import "MBProgressHUD.h"
#import "NetworkModule.h"
#import "Toast+UIView.h"
#import "SBJson.h"
#import "SRRefreshView.h"
#import "SHLUILabel.h"
#import "ASIHTTPRequest.h"
#import "LoginViewController.h"
#import "MoreViewController.h"
#import "OpenUDID.h"
#import "LoginViewController.h"
#import "HMSegmentedControlLast.h"
#import "LogOutViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

#define NUMBERS @"0123456789\n"
//#define SERVERURL @"http://192.168.1.110:8803"
//#define SERVERURL @"http://192.168.2.11:8080/account"
//#define SERVERURL  @"http://192.168.8.156:8088/account"


//#define SERVERURL @"http://117.25.173.213:8888"


//#define SERVERURL @"http://192.168.8.168:8090/account"
//#define SERVERURL @"http://xiajinsuo.com"
//192.168.2.111:8080/account
//#define SERVERURL @"http://10.10.10.2:8080"
#define SERVERURL @"https://www.fyfae.com"

//天津投
//#define SERVERURL @"http://192.168.1.110:8805"

@class LoginViewController,CPVSTabBarViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>{
    UIBackgroundTaskIdentifier bgTask;
}



@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableDictionary *dictionary;
@property (strong, nonatomic) NSMutableDictionary *dic;
@property (strong, nonatomic)NSString *strVC;
//从哪登录的
@property (strong, nonatomic)NSString *strlogin;

@property (strong, nonatomic) NSMutableDictionary *logingUser;
@property (nonatomic, strong)  CPVSTabBarViewController *osTabVC;



@end

