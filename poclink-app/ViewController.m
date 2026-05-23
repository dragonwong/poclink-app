//
//  ViewController.m
//  poclink-app
//
//  Created by wyy on 2026/5/17.
//

#import "ViewController.h"
#import <CmccSDK/CmccSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 监听通知
    [self setupNotifications];
    
    // 设置讲话按钮为长按模式
    [self setupSpeakButton];
}

// 设置通知监听
- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onLoginSuccess:)
                                                 name:kPOST_CMCC_NOTIFICATION_OTHER_LOGIN
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onSelfSpeakingStart:)
                                                 name:kPOST_CMCC_NOTIFICATION_SELF_SPEAKING_START
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onSelfSpeakingStop:)
                                                 name:kPOST_CMCC_NOTIFICATION_SELF_SPEAKING_STOP
                                               object:nil];
    
    // 监听当前群组变化
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onCurrentGroupChanged:)
                                                 name:kPOST_CMCC_NOTIFICATION_CURRENTGROUP_CHANGED
                                               object:nil];
    
    // 监听加入群组失败
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onGroupJoinNoDenied:)
                                                 name:kPOST_CMCC_NOTIFICATION_GROUP_JOIN_NODENIED
                                               object:nil];
}

// 设置讲话按钮
- (void)setupSpeakButton {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(onSpeakLongPress:)];
    [self.speakButton addGestureRecognizer:longPress];
}

// 登录按钮点击 - 触发第三方登录
- (IBAction)loginButtonTapped:(UIButton *)sender {
    NSLog(@"=== 点击谷歌登录 ===");
    
    self.statusLabel.text = @"正在登录...";
    self.loginButton.enabled = NO;
    
    NSString *idToken = @"eyJhbGciOiJSUzI1NiIsImtpZCI6IjQxYjJlMTFmZjljYTI2ZTc4YzAyNWE5ZDRhNDI5Y2IwNjAxMzk1NmUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxOTc4MjA3MDU5MzYta3Y3OGdkNGs0bXNoaHQ4YmV1NHBubjIyZmE1NHE2cTQuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIxOTc4MjA3MDU5MzYta3Y3OGdkNGs0bXNoaHQ4YmV1NHBubjIyZmE1NHE2cTQuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTM2MjE3NDU0Njk0OTY2NjM4MTkiLCJlbWFpbCI6IndoaWxla2luZ0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXRfaGFzaCI6Im5rOWtlSUFRRTJ3c3M2STc4eWZfVHciLCJub25jZSI6InJWTTczSU5Hb0dhSTlxeVA0YmlKQmxQXzlnTm5XdXlmc3JrQWVrYkRiaFkiLCJuYW1lIjoiREFHRU4gV0FORyIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQ2c4b2NMTHV1ZlpEbHhZN2g2TmoxdmxWby01MmNNcnhaLWgtdmZ0S2dfMDZmc3otbFA0aFBBPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IkRBR0VOIiwiZmFtaWx5X25hbWUiOiJXQU5HIiwiaWF0IjoxNzc5Mzc3ODU0LCJleHAiOjE3NzkzODE0NTR9.h-NQcgF9oxSS6DUUQrm1_mdSQMYJzbhC7f7ggMSvCL5CFSyLlG5oBepnqa_5jdjLe0ZdDFxdL6129EXpR0fTVzgG4TOa-vcWRG1g55gtuQ9rQ-NUXJ_DPH5htccqO5d1m2Jg6ifTtk9LIi-dnMvt-uD_AeTvt3lu6GkdE54NXSOesULV9Kwit-8ZF8x3sGMla56jxrcw2Vne7HmCnKUJwB087oYFRnZxwK8cM9BCvTl7qMrBy63-G1WiuZL7Yj4WyRApeSu4V-zcGZF5XbKpL__ZnB0Gd9CH4s2IG926XKOqH21gvjjncSNwzMS6SHYYuqeqZ7WLdIRzLrsI3GjQ9Q";

    [SUPSDK_M PostAuthWithIdToken:idToken
                             type:3
                            email:@"whileking@gmail.com"
                             name:@"DAGEN WANG"
                           callBack:^(NSURLSessionDataTask * _Nonnull task, SUPLoginModel * _Nullable model, NSString *errorStr) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (model && !errorStr) {
                NSLog(@"=== 第三方登录成功 === model: %@", model);
                self.statusLabel.text = @"登录成功";
                
                // 加入写死 gid 的群组
                int joinResult = [SUPSDK_M join_group_gid:@"1186312136837562748"
                                               contact_id:nil
                                                    token:nil
                                                 is_limit:@"0"];
                NSLog(@"加入群组 1186312136837562748 结果: %d", joinResult);
            } else {
                NSLog(@"=== 第三方登录失败 === errorStr: %@", errorStr);
                self.statusLabel.text = [NSString stringWithFormat:@"登录失败: %@", errorStr];
                self.loginButton.enabled = YES;
            }
        });
    }];
}

// 长按讲话
- (void)onSpeakLongPress:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        // 开始讲话
        int result = [SUPSDK_M start_speak:NO];
        self.statusLabel.text = result == 0 ? @"正在讲话..." : @"无法讲话";
        self.speakButton.backgroundColor = [UIColor redColor];
    } else if (gesture.state == UIGestureRecognizerStateEnded ||
               gesture.state == UIGestureRecognizerStateCancelled) {
        // 结束讲话
        [SUPSDK_M stop_speak];
        self.statusLabel.text = @"已结束讲话";
        self.speakButton.backgroundColor = [UIColor systemBlueColor];
    }
}

// 登录成功回调
- (void)onLoginSuccess:(NSNotification *)notification {
    CmccUser *user = notification.object;
    NSLog(@"用户已登录: %@", user.name);
    self.statusLabel.text = [NSString stringWithFormat:@"用户已登录: %@", user.name];
}

// 开始讲话回调
- (void)onSelfSpeakingStart:(NSNotification *)notification {
    NSString *gid = notification.object;
    NSLog(@"开始在群组 %@ 讲话", gid);
}

// 结束讲话回调
- (void)onSelfSpeakingStop:(NSNotification *)notification {
    NSDictionary *info = notification.object;
    NSLog(@"讲话结束: %@", info);
}

// 当前群组变化回调
- (void)onCurrentGroupChanged:(NSNotification *)notification {
    CmccGroup *group = notification.object;
    NSLog(@"=== 当前群组变化 === gid: %@, name: %@", group.gid, group.name);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.statusLabel.text = [NSString stringWithFormat:@"已加入: %@", group.name];
    });
}

// 加入群组被拒绝回调
- (void)onGroupJoinNoDenied:(NSNotification *)notification {
    NSLog(@"=== 加入群组被拒绝 === object: %@", notification.object);
}

@end
