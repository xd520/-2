//
//  AppDelegate.m
//  夏金所
//
//  Created by mac on 15/5/30.
//  Copyright (c) 2015年 ApexSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MyInvestViewController.h"
#import "AccountViewController.h"
#import "MoreViewController.h"
#import "CPVSTabBarViewController.h"
#import "MainViewController.h"
#import "WeiboSDK.h"
#import "WeiboApi.h"
#import "WXApi.h"
#import "WXApiObject.h"

@interface AppDelegate ()
{
     UIScrollView *pageScroll;
     UIPageControl *pageControl;

}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.dic = [[NSMutableDictionary alloc] init];
    self.logingUser = [[NSMutableDictionary alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [ColorUtil colorWithHexString:@"eeeeee"];
    
    //是否要加入引导页
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    //CFShow((__bridge CFTypeRef)(infoDic));
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *str = [userDefault objectForKey:@"verson"];
    
    if (![currentVersion isEqualToString:str]) {
        
        [self initUIscrollerViewFirst];
        
        [userDefault setObject:currentVersion forKey:@"verson"];
        [userDefault synchronize];
    } else {
        
    [self showTabbarVC];
        
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    //厦金所
    [ShareSDK registerApp:@"8107d4141a1c"];     //参数为ShareSDK官网中添加应用后得到的AppKey
    //夏金所  appkey:81082a335efc
     //厦金所  appkey:8107d4141a1c
    
    //2. 初始化社交平台
    //2.1 代码初始化社交平台的方法
    [self initializePlat];
    
    
    return YES;
}

- (void)initializePlat{
    
   // [ShareSDK registerApp:@"31a728a463ee"];     //参数为ShareSDK官网中添加应用后得到的AppKey
    
    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:@"2211740027"
                               appSecret:@"cdeb63d2c0a454a929a70459d4db4a8e"
                             redirectUri:@"http://www.sina.com"];
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:@"568898243"
                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                              redirectUri:@"http://www.sharesdk.cn"
                              weiboSDKCls:[WeiboSDK class]];
    
    //添加腾讯微博应用 注册网址 http://dev.t.qq.com
    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                redirectUri:@"http://www.sharesdk.cn"
                                   wbApiCls:[WeiboApi class]];
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址  http://mobile.qq.com/api/
    [ShareSDK connectQQWithQZoneAppKey:@"QQ05FB8B52"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
                           wechatCls:[WXApi class]];
    
    
    //添加QQ应用  注册网址  http://mobile.qq.com/api/
    [ShareSDK connectQQWithQZoneAppKey:@"QQ05FB8B52"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //连接短信分享
    [ShareSDK connectSMS];
    
    //连接邮件
    [ShareSDK connectMail];
}




-(void)initUIscrollerViewFirst {
    CGRect bound=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    pageScroll = [[UIScrollView alloc] initWithFrame:bound];
    pageScroll.backgroundColor = [ColorUtil colorWithHexString:@"eeeeee"];
    pageScroll.pagingEnabled = YES;
    pageScroll.delegate = self;
    pageScroll.userInteractionEnabled = YES;
    //隐藏水平滑动条
    pageScroll.showsVerticalScrollIndicator = FALSE;
    pageScroll.showsHorizontalScrollIndicator = FALSE;
    [pageScroll flashScrollIndicators];
    [self.window addSubview:pageScroll];
    
    // 初始化 pagecontrol
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,ScreenHeight - 40,ScreenWidth,10)]; // 初始化mypagecontrol
    [pageControl setCurrentPageIndicatorTintColor:[ColorUtil colorWithHexString:@"087dcd"]];
    [pageControl setPageIndicatorTintColor:[ColorUtil colorWithHexString:@"087dcd" withApla:0.2]];
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    //[pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
    [self.window addSubview:pageControl];
    for (int i = 1; i < 4; i++) {
        if (i == 3) {
            UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*(i - 1), 0, ScreenWidth, ScreenHeight)];
            imageView1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
            imageView1.userInteractionEnabled = YES;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((ScreenWidth - 283/2)/2, ScreenHeight - 230/2, 283/2, 40);
            [btn setBackgroundImage:[UIImage imageNamed:@"view_guide_3_btn"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(hideUIscroller) forControlEvents:UIControlEventTouchUpInside];
            [imageView1 addSubview:btn];
            
            
            [pageScroll addSubview:imageView1];
        } else {
        
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*(i - 1), 0, ScreenWidth, ScreenHeight)];
        imageView1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [pageScroll addSubview:imageView1];

        }
    }
    
    [pageScroll setContentSize:CGSizeMake(ScreenWidth*3, ScreenHeight)];
    
}


-(void)hideUIscroller{
    [pageScroll setHidden:YES];
    [pageControl setHidden:YES];
    
    [self showTabbarVC];
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.window.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}



- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    //UIStatusBarStyleDefault
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
}


#pragma mark - Metholds
-(void)showTabbarVC{
    
    MainViewController *vc1 = [[MainViewController alloc] init];
    
    vc1.view.tag = 1;
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    [nav1.navigationBar setBackgroundImage:[UIImage imageNamed:@"title_bg"] forBarMetrics:UIBarMetricsDefault];
    //nav1.title =  @"主页";
    nav1.delegate = self;
    
    
    MyInvestViewController *vc2 = [[MyInvestViewController alloc] init];
    vc2.view.tag = 2;
    //vc2.title = @"我的投资";//两者都有
    // vc2.tabBarItem.title = @"产品列表"; //两者都没
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc2];
    [navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title_bg"] forBarMetrics:UIBarMetricsDefault];
    // navigationController.tabBarItem.title = @"产品列表";
    
    navigationController.delegate = self;
    
    
    
    AccountViewController *vc3 = [[AccountViewController alloc] init];
    // vc3.title = @"账户";
    vc3.view.tag = 3;
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    [nav3.navigationBar setBackgroundImage:[UIImage imageNamed:@"title_bg"] forBarMetrics:UIBarMetricsDefault];
    // nav3.tabBarItem.title = @"我的账户";
    nav3.delegate = self;
    
    
    
    MoreViewController *vc4 = [[MoreViewController alloc] init];
    vc4.view.tag = 4;
    //vc4.title = @"账户";
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    [nav4.navigationBar setBackgroundImage:[UIImage imageNamed:@"title_bg"] forBarMetrics:UIBarMetricsDefault];
    // nav4.tabBarItem.title = @"更多";
    nav4.delegate = self;
    self.osTabVC = [[CPVSTabBarViewController alloc] init];
   
    [self.osTabVC setViewControllers:[[NSArray alloc] initWithObjects:nav1,navigationController,nav3,nav4, nil]];
    
    NSMutableArray *tbNormalArray = [NSMutableArray arrayWithCapacity:10];
    for (int i = 1; i <= 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_not%d", i]];
        [tbNormalArray addObject:image];
    }
    if([[UIDevice currentDevice].systemVersion compare:@"7.0"]!=NSOrderedAscending) {//NSComparisonResult
        self.osTabVC.tabBar.translucent=NO;
    }
    
    self.osTabVC.tabBar.backgroundColor = [ColorUtil colorWithHexString:@"eeeeee"];
    
    //[tabbarController setTabBarBackgroundImage:[UIImage imageNamed:@"title_bg"]];
    [self.osTabVC setItemImages:tbNormalArray];
    
    NSMutableArray *tbHighlightArray = [NSMutableArray arrayWithCapacity:10];
    for (int i = 1; i <= 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar%d", i]];
        [tbHighlightArray addObject:image];
    }
    //NSMutableArray *txtArr=[NSMutableArray arrayWithObjects:@"主页",@"产品列表",@"我的账户",@"更多",nil];
    
    [self.osTabVC setItemHighlightedImages:tbHighlightArray];
    //[tabbarController setTabBarItemsImage:tbHighlightArray];
    //[self.osTabVC setTabBarItemsTitle:txtArr];
    //[tabbarController.tabBar setSelectedImageTintColor:[ColorUtil colorWithHexString:@"#1b89e6"]];
    NSArray *colorArr = [[NSArray alloc] initWithObjects:[ColorUtil colorWithHexString:@"fe8103"],[ColorUtil colorWithHexString:@"fe8103"],[ColorUtil colorWithHexString:@"fe8103"],[ColorUtil colorWithHexString:@"fe8103"], nil];
    int colorIndex = 0;
    for (UITabBarItem *tabbarItem in self.osTabVC.tabBar.items){
        [tabbarItem setTitleTextAttributes:@{UITextAttributeTextColor:colorArr[colorIndex]} forState:UIControlStateHighlighted];
        colorIndex++;
    }
    UILabel *line=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    [line setBackgroundColor:[ColorUtil colorWithHexString:@"cbcaca"]];
    [self.osTabVC.tabBar addSubview:line];
    self.osTabVC.delegate = (id <UITabBarControllerDelegate>)self;
    self.osTabVC.tabBar.clipsToBounds=YES;
    [self.osTabVC setSelectionIndicatorImage:nil];
    [self.osTabVC removeSelectionIndicator];
    [self.osTabVC showBadge];
    
    
    
    self.window.rootViewController = self.osTabVC;
    
    
}



#pragma mark - UINavigationController Delegate Methods
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (viewController.hidesBottomBarWhenPushed)
    {
        
        navigationController.navigationBarHidden = YES;
        viewController.hidesBottomBarWhenPushed = YES;
    } else {
        if (viewController.view.tag == 1||viewController.view.tag == 2||viewController.view.tag == 3||viewController.view.tag == 4||viewController.view.tag == 5) {
            navigationController.navigationBarHidden = YES;
            viewController.hidesBottomBarWhenPushed = NO;
        } else {
            
            
            navigationController.navigationBarHidden = NO;
            viewController.hidesBottomBarWhenPushed = NO;
            
        }
    }
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        // 10分钟后执行这里，应该进行一些清理工作，如断开和服务器的连接等
        // ...
        // stopped or ending the task outright.
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    if (bgTask == UIBackgroundTaskInvalid) {
        NSLog(@"failed to start background task!");
    }
    // Start the long-running task and return immediately.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Do the work associated with the task, preferably in chunks.
        NSTimeInterval timeRemain = 0;
        do{
            [NSThread sleepForTimeInterval:5];
            if (bgTask!= UIBackgroundTaskInvalid) {
                timeRemain = [application backgroundTimeRemaining];
                NSLog(@"Time remaining: %f",timeRemain);
            }
        }while(bgTask!= UIBackgroundTaskInvalid && timeRemain > 0); // 如果改为timeRemain > 5*60,表示后台运行5分钟
        // done!
        // 如果没到10分钟，也可以主动关闭后台任务，但这需要在主线程中执行，否则会出错
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                // 和上面10分钟后执行的代码一样
                // ...
                // if you don't call endBackgroundTask, the OS will exit your app.
                [application endBackgroundTask:bgTask];
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 如果没到10分钟又打开了app,结束后台任务
    if (bgTask!=UIBackgroundTaskInvalid) {
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//支持竖屏，不支持横屏

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
