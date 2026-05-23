//
//  AppDelegate.m
//  poclink-app
//
//  Created by wyy on 2026/5/17.
//

#import "AppDelegate.h"
#import <CmccSDK/CmccSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    return YES;
    
    // 初始化 PTT SDK
    // [SUPSDK_M init_dns:@"49.73.61.229:9899,49.73.61.229:9889"
    //                html:@"https://dev.broadptt.com/devweb/superptt_ys/superptt_poclink/zh/html/"
    //               agent:@"https://apidev.xin-ptt.com/superProxyPoc"
    //        version_type:APP_VERSION_DEVELOPMENT];
    [SUPSDK_M init_dns:@"52.1.120.181:36003,52.1.120.181:35003"
                html:@"https://dev.broadptt.com/devweb/superptt_ys/superptt_poclink/zh/html/"
                agent:@"http://agent.poclink.com:36002"
        version_type:APP_VERSION_DEVELOPMENT];
    
    // 打开日志（开发阶段建议打开）
    [SUPSDK_M openLog:YES];
    
    // 监听登录成功通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onLoginSuccess:)
                                                 name:kPOST_CMCC_NOTIFICATION_OTHER_LOGIN
                                               object:nil];
    
    return YES;
}

// UINavigationControllerDelegate - 统一监听路由变化
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *fromVC = navigationController.topViewController;
    NSString *toVC = NSStringFromClass(viewController.class);
    
    if (fromVC) {
        NSLog(@"🔄 路由变化: %@ -> %@", NSStringFromClass(fromVC.class), toVC);
    }
}

// 登录成功回调
- (void)onLoginSuccess:(NSNotification *)notification {
    CmccUser *user = notification.object;
    NSLog(@"用户已登录: %@", user.name);
}

@end
