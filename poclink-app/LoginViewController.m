//
//  LoginViewController.m
//  poclink-app
//
//  Created by wyy on 2026/5/23.
//

#import "LoginViewController.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import <CmccSDK/CmccSDK.h>

// iOS 客户端 ID（用于完成 iOS 授权流程）
static NSString *const kIOSClientID = @"197820705936-kv78gd4k4mshht8beu4pnn22fa54q6q4.apps.googleusercontent.com";
// Web 客户端 ID（用于获取 ID Token，与安卓一致）
// static NSString *const kWebClientID = @"197820705936-kv78gd4k4msht8beu4pnn22fa54q6q4.apps.googleusercontent.com";
static NSString *const kWebClientID = @"197820705936-kv78gd4k4mshht8beu4pnn22fa54q6q4.apps.googleusercontent.com";


@interface LoginViewController ()

@property (nonatomic, strong) UIButton *googleLoginButton;
@property (nonatomic, strong) UIButton *voiceLoginButton;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, copy) NSString *savedAccount;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"登录";
    
    // 配置 Google Sign-In：使用 iOS Client ID 完成授权，获取 Web Client ID 的 ID Token
    GIDConfiguration *config = [[GIDConfiguration alloc] initWithClientID:kIOSClientID
                                                             serverClientID:kWebClientID];
    [GIDSignIn.sharedInstance setConfiguration:config];
    
    [self setupUI];
}

- (void)setupUI {
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"PocLink 登录";
    titleLabel.font = [UIFont boldSystemFontOfSize:28];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:titleLabel];
    
    // 谷歌登录按钮
    self.googleLoginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.googleLoginButton setTitle:@"使用 Google 账号登录" forState:UIControlStateNormal];
    self.googleLoginButton.backgroundColor = [UIColor whiteColor];
    [self.googleLoginButton setTitleColor:[UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0] forState:UIControlStateNormal];
    self.googleLoginButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.googleLoginButton.layer.cornerRadius = 8;
    self.googleLoginButton.layer.borderWidth = 1;
    self.googleLoginButton.layer.borderColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0].CGColor;
    self.googleLoginButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.googleLoginButton addTarget:self action:@selector(googleLoginTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.googleLoginButton];
    
    // 状态标签
    self.statusLabel = [[UILabel alloc] init];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.textColor = [UIColor secondaryLabelColor];
    self.statusLabel.font = [UIFont systemFontOfSize:14];
    self.statusLabel.numberOfLines = 0;
    self.statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.statusLabel];

    // 登录语音服务按钮
    self.voiceLoginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.voiceLoginButton setTitle:@"登录语音服务" forState:UIControlStateNormal];
    self.voiceLoginButton.backgroundColor = [UIColor systemGreenColor];
    [self.voiceLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.voiceLoginButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.voiceLoginButton.layer.cornerRadius = 8;
    self.voiceLoginButton.enabled = NO;
    self.voiceLoginButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.voiceLoginButton addTarget:self action:@selector(voiceLoginTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.voiceLoginButton];

    // 布局
    [NSLayoutConstraint activateConstraints:@[
        [titleLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [titleLabel.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-100],

        [self.googleLoginButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:40],
        [self.googleLoginButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-40],
        [self.googleLoginButton.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:60],
        [self.googleLoginButton.heightAnchor constraintEqualToConstant:50],

        [self.statusLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:40],
        [self.statusLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-40],
        [self.statusLabel.topAnchor constraintEqualToAnchor:self.googleLoginButton.bottomAnchor constant:30],

        [self.voiceLoginButton.leadingAnchor constraintEqualToAnchor:self.googleLoginButton.leadingAnchor],
        [self.voiceLoginButton.trailingAnchor constraintEqualToAnchor:self.googleLoginButton.trailingAnchor],
        [self.voiceLoginButton.topAnchor constraintEqualToAnchor:self.statusLabel.bottomAnchor constant:30],
        [self.voiceLoginButton.heightAnchor constraintEqualToConstant:50],
    ]];
}

- (void)googleLoginTapped {
    NSLog(@"=== 点击谷歌登录 ===");
    
    self.statusLabel.text = @"正在登录...";
    self.googleLoginButton.enabled = NO;
    
    GIDSignIn *signIn = [GIDSignIn sharedInstance];
    [signIn signInWithPresentingViewController:self
                                    completion:^(GIDSignInResult * _Nullable signInResult, NSError * _Nullable error) {
        if (error) {
            NSLog(@"=== Google 登录失败 === error: %@", error.localizedDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.statusLabel.text = [NSString stringWithFormat:@"登录失败: %@", error.localizedDescription];
                self.googleLoginButton.enabled = YES;
            });
            return;
        }
        
        if (signInResult == nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.statusLabel.text = @"登录已取消";
                self.googleLoginButton.enabled = YES;
            });
            return;
        }
        
        // 获取 ID Token（aud 为 Web Client ID，与安卓一致）
        NSString *idToken = signInResult.user.idToken.tokenString;
        NSString *email = signInResult.user.profile.email;
        NSString *name = signInResult.user.profile.name;
        
        NSLog(@"=== Google 登录成功 === email: %@, name: %@", email, name);
        
        // 调用 PocLink SDK 登录（与安卓相同的方式）
        dispatch_async(dispatch_get_main_queue(), ^{
            self.statusLabel.text = @"正在验证...";
        });
        
        [SUPSDK_M PostAuthWithIdToken:idToken
                                 type:3
                                email:email
                                 name:name
                               callBack:^(NSURLSessionDataTask * _Nonnull task, SUPLoginModel * _Nullable model, NSString * _Nullable errorStr) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (model && !errorStr) {
                    NSLog(@"=== PocLink 登录成功 === model: %@", model);
                    self.statusLabel.text = @"登录成功！请点击下方按钮登录语音服务";
                    self.savedAccount = model.account;
                    self.voiceLoginButton.enabled = YES;
                } else {
                    NSLog(@"=== PocLink 登录失败 === errorStr: %@", errorStr);
                    self.statusLabel.text = [NSString stringWithFormat:@"登录失败: %@", errorStr];
                    self.googleLoginButton.enabled = YES;
                }
            });
        }];
    }];
}

- (void)voiceLoginTapped {
    NSLog(@"=== 点击登录语音服务 === account: %@", self.savedAccount);
    int result = [SUPSDK_M login_account:self.savedAccount password:@"1" type:0];
    NSLog(@"=== 登录语音服务结果: %d ===", result);
    if (result == 0) {
        self.statusLabel.text = @"语音服务登录成功！";
        // 登录成功后返回首页
        // [self.navigationController popToRootViewControllerAnimated:YES]; 
    } else {
        self.statusLabel.text = @"语音服务登录失败";
    }
}

@end
