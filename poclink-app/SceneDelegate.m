//
//  SceneDelegate.m
//  poclink-app
//
//  Created by wyy on 2026/5/17.
//

#import "SceneDelegate.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import "AppDelegate.h"

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Create window and set root view controller from storyboard
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navController = [storyboard instantiateInitialViewController];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    // Set navigation controller delegate to AppDelegate for unified route logging
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    navController.delegate = appDelegate;
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
