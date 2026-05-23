//
//  LandingViewController.m
//  poclink-app
//
//  Created by wyy on 2026/5/23.
//

#import "LandingViewController.h"
#import "LoginViewController.h"
#import "ViewController.h"

@interface LandingViewController ()

@end

@implementation LandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"PocLink";
    
    [self setupUI];
}

- (void)setupUI {
    // 标题标签
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"PocLink";
    titleLabel.font = [UIFont boldSystemFontOfSize:32];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:titleLabel];
    
    // 登录按钮
    UIButton *loginButton = [self createButtonWithTitle:@"登录"
                                               backgroundColor:[UIColor systemBlueColor]
                                                        action:@selector(loginButtonTapped)];
    
    // 原首页按钮
    UIButton *homeButton = [self createButtonWithTitle:@"进入首页"
                                              backgroundColor:[UIColor systemGreenColor]
                                                       action:@selector(homeButtonTapped)];
    
    // 布局
    [NSLayoutConstraint activateConstraints:@[
        // 标题居中偏上
        [titleLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [titleLabel.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-150],
        
        // 登录按钮
        [loginButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:40],
        [loginButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-40],
        [loginButton.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:80],
        [loginButton.heightAnchor constraintEqualToConstant:50],
        
        // 原首页按钮
        [homeButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:40],
        [homeButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-40],
        [homeButton.topAnchor constraintEqualToAnchor:loginButton.bottomAnchor constant:20],
        [homeButton.heightAnchor constraintEqualToConstant:50],
    ]];
}

- (UIButton *)createButtonWithTitle:(NSString *)title
                    backgroundColor:(UIColor *)color
                             action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = color;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    button.layer.cornerRadius = 10;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return button;
}

- (void)loginButtonTapped {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)homeButtonTapped {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *homeVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self.navigationController pushViewController:homeVC animated:YES];
}

@end
