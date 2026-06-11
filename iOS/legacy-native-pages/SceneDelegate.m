//
//  SceneDelegate.m
//  poclink-app
//
//  Created by wyy on 2026/5/17.
//

#import "SceneDelegate.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import "AppDelegate.h"

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Create window for React Native
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSURL *jsCodeLocation = [appDelegate bundleURL];
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"PocLink"
                                                 initialProperties:nil
                                                     launchOptions:connectionOptions.launchOptions];
    rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
    
    UIViewController *rootViewController = [UIViewController new];
    rootViewController.view = rootView;
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
}


- (void)sceneWillResignActive:(UIScene *)scene {
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
}

// 处理谷歌登录回调
- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts {
    for (UIOpenURLContext *context in URLContexts) {
        NSURL *url = context.URL;
        [GIDSignIn.sharedInstance handleURL:url];
    }
}


@end
