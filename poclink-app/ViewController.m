//
//  ViewController.m
//  poclink-app
//
//  Created by wyy on 2026/5/17.
//

#import "ViewController.h"
#import <CmccSDK/CmccSDK.h>

@interface ViewController ()

@property (nonatomic, strong) UIButton *queryUserButton;
@property (nonatomic, strong) UIButton *queryGroupButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 监听通知
    [self setupNotifications];

    // 设置按钮
    [self setupButtons];
}

- (void)setupButtons {
    // 确保 speakButton 和 statusLabel 使用 AutoLayout
    self.speakButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 设置 statusLabel 居中显示
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.numberOfLines = 0;
    
    // 垂直居中布局，从屏幕中间偏上开始排列所有按钮
    UILayoutGuide *guide = self.view.safeAreaLayoutGuide;

    [self deactivateStoryboardConstraintsForViews:@[self.statusLabel, self.speakButton]];
    
    // 查询用户按钮（紫色）- 最顶部
    [self setupQueryUserButton];
    
    // 查询群聊按钮（橙色）
    [self setupQueryGroupButton];
    
    // 加入群聊按钮（绿色）
    [self setupJoinGroupButton];
    
    // 讲话按钮（蓝色，Storyboard中已有，调整位置和样式）
    self.speakButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.speakButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.speakButton.backgroundColor = [UIColor systemBlueColor];
    self.speakButton.layer.cornerRadius = 8;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(onSpeakLongPress:)];
    [self.speakButton addGestureRecognizer:longPress];
    
    // 设置所有按钮的约束
    [NSLayoutConstraint activateConstraints:@[
        // statusLabel 固定在屏幕垂直中心偏上位置
        [self.statusLabel.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:20],
        [self.statusLabel.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-20],
        [self.statusLabel.centerYAnchor constraintEqualToAnchor:guide.centerYAnchor constant:-140],
        
        // 查询用户按钮
        [self.queryUserButton.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:20],
        [self.queryUserButton.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-20],
        [self.queryUserButton.topAnchor constraintEqualToAnchor:self.statusLabel.bottomAnchor constant:20],
        
        // 查询群聊按钮
        [self.queryGroupButton.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:20],
        [self.queryGroupButton.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-20],
        [self.queryGroupButton.topAnchor constraintEqualToAnchor:self.queryUserButton.bottomAnchor constant:12],
        
        // 加入群聊按钮
        [self.joinGroupButton.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:20],
        [self.joinGroupButton.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-20],
        [self.joinGroupButton.topAnchor constraintEqualToAnchor:self.queryGroupButton.bottomAnchor constant:12],
        
        // 讲话按钮
        [self.speakButton.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:20],
        [self.speakButton.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-20],
        [self.speakButton.topAnchor constraintEqualToAnchor:self.joinGroupButton.bottomAnchor constant:12],
    ]];
    
    // 所有按钮统一高度
    [NSLayoutConstraint activateConstraints:@[
        [self.statusLabel.heightAnchor constraintEqualToConstant:30],
        [self.queryUserButton.heightAnchor constraintEqualToConstant:48],
        [self.queryGroupButton.heightAnchor constraintEqualToConstant:48],
        [self.joinGroupButton.heightAnchor constraintEqualToConstant:48],
        [self.speakButton.heightAnchor constraintEqualToConstant:48],
    ]];
}

#pragma mark - Button Setup

- (void)deactivateStoryboardConstraintsForViews:(NSArray<UIView *> *)views {
    NSMutableArray<NSLayoutConstraint *> *constraintsToDeactivate = [NSMutableArray array];

    for (NSLayoutConstraint *constraint in self.view.constraints) {
        if ([views containsObject:constraint.firstItem] || [views containsObject:constraint.secondItem]) {
            [constraintsToDeactivate addObject:constraint];
        }
    }

    [NSLayoutConstraint deactivateConstraints:constraintsToDeactivate];
}

- (void)setupQueryUserButton {
    self.queryUserButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.queryUserButton setTitle:@"查询用户" forState:UIControlStateNormal];
    self.queryUserButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.queryUserButton.backgroundColor = [UIColor systemPurpleColor];
    [self.queryUserButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.queryUserButton.layer.cornerRadius = 8;
    self.queryUserButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.queryUserButton addTarget:self action:@selector(queryUser:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.queryUserButton];
}

- (void)setupQueryGroupButton {
    self.queryGroupButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.queryGroupButton setTitle:@"查询群聊" forState:UIControlStateNormal];
    self.queryGroupButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.queryGroupButton.backgroundColor = [UIColor systemOrangeColor];
    [self.queryGroupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.queryGroupButton.layer.cornerRadius = 8;
    self.queryGroupButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.queryGroupButton addTarget:self action:@selector(queryGroup:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.queryGroupButton];
}

- (void)setupJoinGroupButton {
    self.joinGroupButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.joinGroupButton setTitle:@"加入群聊" forState:UIControlStateNormal];
    self.joinGroupButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.joinGroupButton.backgroundColor = [UIColor systemGreenColor];
    [self.joinGroupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.joinGroupButton.layer.cornerRadius = 8;
    self.joinGroupButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.joinGroupButton addTarget:self action:@selector(joinGroup:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.joinGroupButton];
}

#pragma mark - Actions

// 查询当前用户
- (void)queryUser:(UIButton *)sender {
    NSLog(@"=== 点击查询用户 ===");
    CmccUser *user = [SUPSDK_M get_current_user];
    if (user) {
        NSLog(@"当前用户: name=%@, uid=%@, account=%@", user.name, user.uid, user.account);
        self.statusLabel.text = [NSString stringWithFormat:@"用户: %@ (uid: %@)", user.name, user.uid];
    } else {
        NSLog(@"当前没有登录用户");
        self.statusLabel.text = @"当前没有登录用户";
    }
}

// 查询当前群聊
- (void)queryGroup:(UIButton *)sender {
    NSLog(@"=== 点击查询群聊 ===");
    CmccGroup *group = [SUPSDK_M get_current_group];
    if (group) {
        NSLog(@"当前群组: gid=%@, name=%@", group.gid, group.name);
        self.statusLabel.text = [NSString stringWithFormat:@"当前群组: %@ (gid: %@)", group.name, group.gid];
    } else {
        NSLog(@"当前没有加入任何群组");
        self.statusLabel.text = @"当前没有加入任何群组";
    }
}

// 加入群聊
- (void)joinGroup:(UIButton *)sender {
    NSLog(@"=== 点击加入群聊 ===");
    int joinResult = [SUPSDK_M join_group_gid:@"1186312136837562748"
                                   contact_id:nil
                                        token:nil
                                     is_limit:@"0"];
    NSLog(@"加入群组 1186312136837562748 结果: %d", joinResult);
    self.statusLabel.text = joinResult == 0 ? @"正在加入群聊..." : @"加入群聊失败";
}

// 长按讲话
- (void)onSpeakLongPress:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"=== 开始讲话 ===");
        int result = [SUPSDK_M start_speak:NO];
        self.statusLabel.text = result == 0 ? @"正在讲话..." : @"无法讲话";
        self.speakButton.backgroundColor = [UIColor redColor];
    } else if (gesture.state == UIGestureRecognizerStateEnded ||
               gesture.state == UIGestureRecognizerStateCancelled) {
        NSLog(@"=== 结束讲话 ===");
        [SUPSDK_M stop_speak];
        self.statusLabel.text = @"已结束讲话";
        self.speakButton.backgroundColor = [UIColor systemBlueColor];
    }
}

#pragma mark - Notifications

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onSelfSpeakingStart:)
                                                 name:kPOST_CMCC_NOTIFICATION_SELF_SPEAKING_START
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onSelfSpeakingStop:)
                                                 name:kPOST_CMCC_NOTIFICATION_SELF_SPEAKING_STOP
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onCurrentGroupChanged:)
                                                 name:kPOST_CMCC_NOTIFICATION_CURRENTGROUP_CHANGED
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onGroupJoinNoDenied:)
                                                 name:kPOST_CMCC_NOTIFICATION_GROUP_JOIN_NODENIED
                                               object:nil];
}

- (void)onSelfSpeakingStart:(NSNotification *)notification {
    NSString *gid = notification.object;
    NSLog(@"开始在群组 %@ 讲话", gid);
}

- (void)onSelfSpeakingStop:(NSNotification *)notification {
    NSDictionary *info = notification.object;
    NSLog(@"讲话结束: %@", info);
}

- (void)onCurrentGroupChanged:(NSNotification *)notification {
    CmccGroup *group = notification.object;
    NSLog(@"=== 当前群组变化 === gid: %@, name: %@", group.gid, group.name);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.statusLabel.text = [NSString stringWithFormat:@"已加入: %@", group.name];
    });
}

- (void)onGroupJoinNoDenied:(NSNotification *)notification {
    NSLog(@"=== 加入群组被拒绝 === object: %@", notification.object);
}

@end
