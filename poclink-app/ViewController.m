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

    // 设置加入群聊按钮
    [self setupJoinGroupButton];
}

// 设置通知监听
- (void)setupNotifications {
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

// 设置加入群聊按钮
- (void)setupJoinGroupButton {
    self.joinGroupButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.joinGroupButton setTitle:@"加入群聊" forState:UIControlStateNormal];
    self.joinGroupButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.joinGroupButton.backgroundColor = [UIColor systemGreenColor];
    [self.joinGroupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.joinGroupButton.layer.cornerRadius = 8;
    [self.joinGroupButton addTarget:self action:@selector(joinGroup:) forControlEvents:UIControlEventTouchUpInside];

    self.joinGroupButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.joinGroupButton];

    [NSLayoutConstraint activateConstraints:@[
        [self.joinGroupButton.leadingAnchor constraintEqualToAnchor:self.speakButton.leadingAnchor],
        [self.joinGroupButton.trailingAnchor constraintEqualToAnchor:self.speakButton.trailingAnchor],
        [self.joinGroupButton.topAnchor constraintEqualToAnchor:self.speakButton.bottomAnchor constant:20],
        [self.joinGroupButton.heightAnchor constraintEqualToAnchor:self.speakButton.heightAnchor]
    ]];
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
        // 开始讲话
        int result = [SUPSDK_M start_speak:NO];
        self.statusLabel.text = result == 0 ? @"正在讲话..." : @"无法讲话";
        self.speakButton.backgroundColor = [UIColor redColor];
    } else if (gesture.state == UIGestureRecognizerStateEnded ||
               gesture.state == UIGestureRecognizerStateCancelled) {
        NSLog(@"=== 结束讲话 ===");
        // 结束讲话
        [SUPSDK_M stop_speak];
        self.statusLabel.text = @"已结束讲话";
        self.speakButton.backgroundColor = [UIColor systemBlueColor];
    }
}

// 长按讲话开始讲话回调
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
