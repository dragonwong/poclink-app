//
//  GoogleLoginViewController.m
//  poclink-app
//
//  Created by wyy on 2026/5/23.
//

#import "GoogleLoginViewController.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import <CmccSDK/CmccSDK.h>

// iOS 客户端 ID（用于完成 iOS 授权流程）
static NSString *const kIOSClientID = @"197820705936-kv78gd4k4mshht8beu4pnn22fa54q6q4.apps.googleusercontent.com";
// Web 客户端 ID（用于获取 ID Token，与安卓一致）
static NSString *const kWebClientID = @"197820705936-kv78gd4k4mshht8beu4pnn22fa54q6q4.apps.googleusercontent.com";

@interface GoogleLoginViewController ()

@property (nonatomic, strong) UIButton *googleLoginButton;
@property (nonatomic, strong) UIButton *checkAccountButton;
@property (nonatomic, strong) UIButton *getServiceUrlButton;
@property (nonatomic, strong) UIButton *setUrlButton;
@property (nonatomic, strong) UIButton *voiceLoginButton;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, copy) NSString *savedAccount;
@property (nonatomic, copy) NSString *currentEmail;
@property (nonatomic, copy) NSString *currentIdToken;
@property (nonatomic, strong) NSMutableArray<SUPRegionServerModel *> *savedUrlModels;

@end

@implementation GoogleLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"谷歌登录";
    
    // 配置 Google Sign-In：使用 iOS Client ID 完成授权，获取 Web Client ID 的 ID Token
    GIDConfiguration *config = [[GIDConfiguration alloc] initWithClientID:kIOSClientID
                                                             serverClientID:kWebClientID];
    [GIDSignIn.sharedInstance setConfiguration:config];
    
    [self setupUI];
}

- (void)setupUI {
    // 谷歌登录按钮
    self.googleLoginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.googleLoginButton setTitle:@"使用 Google 账号登录" forState:UIControlStateNormal];
    self.googleLoginButton.backgroundColor = [UIColor whiteColor];
    [self.googleLoginButton setTitleColor:[UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0] forState:UIControlStateNormal];
    self.googleLoginButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.googleLoginButton.layer.cornerRadius = 8;
    self.googleLoginButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.googleLoginButton addTarget:self action:@selector(googleLoginTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.googleLoginButton];
    
    // 判断账号是否存在按钮
    self.checkAccountButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.checkAccountButton setTitle:@"判断账号是否存在" forState:UIControlStateNormal];
    self.checkAccountButton.backgroundColor = [UIColor systemPurpleColor];
    [self.checkAccountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.checkAccountButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.checkAccountButton.layer.cornerRadius = 8;
    self.checkAccountButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.checkAccountButton addTarget:self action:@selector(checkAccountTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.checkAccountButton];
    
    // 根据账号获取 URL 按钮
    self.getServiceUrlButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.getServiceUrlButton setTitle:@"根据账号获取 URL" forState:UIControlStateNormal];
    self.getServiceUrlButton.backgroundColor = [UIColor systemOrangeColor];
    [self.getServiceUrlButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.getServiceUrlButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.getServiceUrlButton.layer.cornerRadius = 8;
    self.getServiceUrlButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.getServiceUrlButton addTarget:self action:@selector(getServiceUrlTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.getServiceUrlButton];
    
    // 设置 URL 按钮
    self.setUrlButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.setUrlButton setTitle:@"设置 URL" forState:UIControlStateNormal];
    self.setUrlButton.backgroundColor = [UIColor systemTealColor];
    [self.setUrlButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.setUrlButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.setUrlButton.layer.cornerRadius = 8;
    self.setUrlButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.setUrlButton addTarget:self action:@selector(setUrlTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.setUrlButton];
    
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
        [self.googleLoginButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.googleLoginButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-100],
        [self.googleLoginButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:40],
        [self.googleLoginButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-40],
        [self.googleLoginButton.heightAnchor constraintEqualToConstant:44],

        [self.checkAccountButton.leadingAnchor constraintEqualToAnchor:self.googleLoginButton.leadingAnchor],
        [self.checkAccountButton.trailingAnchor constraintEqualToAnchor:self.googleLoginButton.trailingAnchor],
        [self.checkAccountButton.topAnchor constraintEqualToAnchor:self.googleLoginButton.bottomAnchor constant:12],
        [self.checkAccountButton.heightAnchor constraintEqualToConstant:44],

        [self.getServiceUrlButton.leadingAnchor constraintEqualToAnchor:self.googleLoginButton.leadingAnchor],
        [self.getServiceUrlButton.trailingAnchor constraintEqualToAnchor:self.googleLoginButton.trailingAnchor],
        [self.getServiceUrlButton.topAnchor constraintEqualToAnchor:self.checkAccountButton.bottomAnchor constant:12],
        [self.getServiceUrlButton.heightAnchor constraintEqualToConstant:44],

        [self.setUrlButton.leadingAnchor constraintEqualToAnchor:self.googleLoginButton.leadingAnchor],
        [self.setUrlButton.trailingAnchor constraintEqualToAnchor:self.googleLoginButton.trailingAnchor],
        [self.setUrlButton.topAnchor constraintEqualToAnchor:self.getServiceUrlButton.bottomAnchor constant:12],
        [self.setUrlButton.heightAnchor constraintEqualToConstant:44],

        [self.statusLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:40],
        [self.statusLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-40],
        [self.statusLabel.topAnchor constraintEqualToAnchor:self.setUrlButton.bottomAnchor constant:30],

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
                    NSLog(@"=== PocLink 三方登录成功 === model: %@", model);
                    self.statusLabel.text = @"登录成功！请点击下方按钮登录语音服务";
                    self.currentEmail = email;
                    self.currentIdToken = idToken;
                    self.savedAccount = model.account;
                    self.voiceLoginButton.enabled = YES;
                } else {
                    NSLog(@"=== PocLink 三方登录失败 === errorStr: %@", errorStr);
                    self.statusLabel.text = [NSString stringWithFormat:@"登录失败: %@", errorStr];
                    self.googleLoginButton.enabled = YES;
                }
            });
        }];
    }];
}

- (void)checkAccountTapped {
    NSLog(@"=== 点击判断账号是否存在 ===");
    
    self.statusLabel.text = @"正在检查账号...";
    
    [SUPSDK_M PostIsExistIdToken:self.currentIdToken type:3 callBack:^(NSURLSessionDataTask * _Nonnull task, SUPBaseModel * _Nullable model, NSString * _Nullable errorStr) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!errorStr) {
                NSLog(@"=== 判断账号存在结果 === code: %ld, count: %ld, msg: %@, data: %@", (long)model.code, (long)model.count, model.msg, model.data);
                self.statusLabel.text = @"账号检查完成，请查看日志";
            } else {
                NSLog(@"=== 判断账号存在失败 === errorStr: %@", errorStr);
                self.statusLabel.text = [NSString stringWithFormat:@"检查失败: %@", errorStr];
            }
        });
    }];
}

- (void)getServiceUrlTapped {
    NSLog(@"=== 点击根据账号获取 URL ===");
    
    self.statusLabel.text = @"正在获取 URL...";
    
    NSString *account = self.savedAccount.length > 0 ? self.savedAccount : self.currentEmail;
    [SUPSDK_M GetServiceUrlWithAccount:account callBack:^(NSURLSessionDataTask * _Nonnull task, NSArray<SUPRegionServerModel *> * _Nullable modelsArr, NSString * _Nullable errorStr) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!errorStr) {
                NSLog(@"=== 获取 URL 结果 === count: %lu", (unsigned long)modelsArr.count);
                for (SUPRegionServerModel *m in modelsArr) {
                    NSLog(@"  serverType: %@, regionName: %@, serverUrl: %@", m.serverType, m.regionName, m.serverUrl);
                }
                self.savedUrlModels = [modelsArr mutableCopy];
                self.statusLabel.text = [NSString stringWithFormat:@"获取到 %lu 个 URL", (unsigned long)modelsArr.count];
            } else {
                NSLog(@"=== 获取 URL 失败 === errorStr: %@", errorStr);
                self.statusLabel.text = [NSString stringWithFormat:@"获取失败: %@", errorStr];
            }
        });
    }];
}

- (void)setUrlTapped {
    NSLog(@"=== 点击设置 URL ===");
    
    if (!self.savedUrlModels || self.savedUrlModels.count == 0) {
        self.statusLabel.text = @"请先获取 URL";
        return;
    }
    
    // 查找 extend 和 soundRecord 的 URL
    NSString *extendUrl = nil;
    NSString *soundUrl = nil;
    for (SUPRegionServerModel *m in self.savedUrlModels) {
        if ([m.serverType isEqualToString:@"extend"]) {
            extendUrl = m.serverUrl;
        } else if ([m.serverType isEqualToString:@"soundRecord"]) {
            soundUrl = m.serverUrl;
        }
    }
    
    [SUPSDK_M setExtendUrl:extendUrl ?: @"" soundRecord:soundUrl ?: @""];
    NSLog(@"=== 设置 URL 完成 === extend: %@, sound: %@", extendUrl, soundUrl);
    self.statusLabel.text = @"URL 设置完成";
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
