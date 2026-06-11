//
//  EmailLoginViewController.m
//  poclink-app
//
//  Created by wyy on 2026/5/23.
//

#import "EmailLoginViewController.h"
#import <CmccSDK/CmccSDK.h>
#import <CommonCrypto/CommonCrypto.h>


@interface EmailLoginViewController ()

@property (nonatomic, strong) UIButton *checkAccountButton;
@property (nonatomic, strong) UIButton *getServiceUrlButton;
@property (nonatomic, strong) UIButton *setUrlButton;
@property (nonatomic, strong) UIButton *emailLoginButton;
@property (nonatomic, strong) UIButton *voiceLoginButton;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, copy) NSString *savedAccount;
@property (nonatomic, copy) NSString *currentEmail;
@property (nonatomic, strong) NSMutableArray<SUPRegionServerModel *> *savedUrlModels;

@end

@implementation EmailLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"邮箱登录";
    // self.currentEmail = @"songzhiqing213@gmail.com"; // pswd Poclink918$&@
    self.currentEmail = @"814465104@qq.com";
    
    [self setupUI];
}

- (void)setupUI {
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
    
    // 邮箱密码登录按钮
    self.emailLoginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.emailLoginButton setTitle:@"使用邮箱密码登录" forState:UIControlStateNormal];
    self.emailLoginButton.backgroundColor = [UIColor systemBlueColor];
    [self.emailLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.emailLoginButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.emailLoginButton.layer.cornerRadius = 8;
    self.emailLoginButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.emailLoginButton addTarget:self action:@selector(emailLoginTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.emailLoginButton];
    
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
        [self.checkAccountButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.checkAccountButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-100],
        [self.checkAccountButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:40],
        [self.checkAccountButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-40],
        [self.checkAccountButton.heightAnchor constraintEqualToConstant:44],

        [self.getServiceUrlButton.leadingAnchor constraintEqualToAnchor:self.checkAccountButton.leadingAnchor],
        [self.getServiceUrlButton.trailingAnchor constraintEqualToAnchor:self.checkAccountButton.trailingAnchor],
        [self.getServiceUrlButton.topAnchor constraintEqualToAnchor:self.checkAccountButton.bottomAnchor constant:12],
        [self.getServiceUrlButton.heightAnchor constraintEqualToConstant:44],

        [self.setUrlButton.leadingAnchor constraintEqualToAnchor:self.checkAccountButton.leadingAnchor],
        [self.setUrlButton.trailingAnchor constraintEqualToAnchor:self.checkAccountButton.trailingAnchor],
        [self.setUrlButton.topAnchor constraintEqualToAnchor:self.getServiceUrlButton.bottomAnchor constant:12],
        [self.setUrlButton.heightAnchor constraintEqualToConstant:44],

        [self.emailLoginButton.leadingAnchor constraintEqualToAnchor:self.checkAccountButton.leadingAnchor],
        [self.emailLoginButton.trailingAnchor constraintEqualToAnchor:self.checkAccountButton.trailingAnchor],
        [self.emailLoginButton.topAnchor constraintEqualToAnchor:self.setUrlButton.bottomAnchor constant:12],
        [self.emailLoginButton.heightAnchor constraintEqualToConstant:50],

        [self.statusLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:40],
        [self.statusLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-40],
        [self.statusLabel.topAnchor constraintEqualToAnchor:self.emailLoginButton.bottomAnchor constant:30],

        [self.voiceLoginButton.leadingAnchor constraintEqualToAnchor:self.checkAccountButton.leadingAnchor],
        [self.voiceLoginButton.trailingAnchor constraintEqualToAnchor:self.checkAccountButton.trailingAnchor],
        [self.voiceLoginButton.topAnchor constraintEqualToAnchor:self.statusLabel.bottomAnchor constant:30],
        [self.voiceLoginButton.heightAnchor constraintEqualToConstant:50],
    ]];
}

- (void)checkAccountTapped {
    NSLog(@"=== 点击判断账号是否存在 ===");
    
    self.statusLabel.text = @"正在检查账号...";
    
    [SUPSDK_M PostIsExistAccount:self.currentEmail callBack:^(NSURLSessionDataTask * _Nonnull task, SUPBaseModel * _Nullable model, NSString * _Nullable errorStr) {
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

- (NSString *)md5String:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return [result uppercaseString];
}

- (void)emailLoginTapped {
    NSLog(@"=== 点击邮箱密码登录 ===");
    NSLog(@"=== test md5 === %@", [self md5String:@"123456$&"]);
    
    self.statusLabel.text = @"正在登录...";
    self.emailLoginButton.enabled = NO;
    
    [SUPSDK_M PostLoginWithAccount:self.currentEmail
                              type:0
                          password:[self md5String:@"123456$&"]
                              code:nil
                            callBack:^(NSURLSessionDataTask * _Nonnull task, SUPLoginModel * _Nullable model, NSString * _Nullable errorStr) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (model && !errorStr) {
                NSLog(@"=== 邮箱密码登录成功 === model: %@", model);
                self.statusLabel.text = @"登录成功！请点击下方按钮登录语音服务";
                self.savedAccount = model.account;
                self.voiceLoginButton.enabled = YES;
            } else {
                NSLog(@"=== 邮箱密码登录失败 === errorStr: %@", errorStr);
                self.statusLabel.text = [NSString stringWithFormat:@"登录失败: %@", errorStr];
                self.emailLoginButton.enabled = YES;
            }
        });
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
