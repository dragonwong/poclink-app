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
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
