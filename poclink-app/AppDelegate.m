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
    // 初始化 PTT SDK
    // [SUPSDK_M init_dns:@"49.73.61.229:9899,49.73.61.229:9889"
    //                html:@"https://dev.broadptt.com/devweb/superptt_ys/superptt_poclink/zh/html/"
    //               agent:@"https://apidev.xin-ptt.com/superProxyPoc"
    //        version_type:APP_VERSION_DEVELOPMENT];
    [SUPSDK_M init_dns:@"52.1.120.181:36003,52.1.120.181:35003"
          version_type:APP_VERSION_DEVELOPMENT
        serviceAudio:@""
                 api:@""
              extend:@""
                html:@"https://dev.broadptt.com/devweb/superptt_ys/superptt_poclink/zh/html/"
              update:@""
               agent:@"http://agent.poclink.com:36002"
                 sos:@""
            shareMsg:@""
               fence:@""];

    // 打开日志（开发阶段建议打开）
    [SUPSDK_M openLog:YES];

    // 注册所有通知监听
    [self setupNotifications];

    return YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 注册所有通知监听
- (void)setupNotifications {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];

    // ========== 核心库相关通知 ==========
    // 服务器异步回调结果（CmccAckResult）
    [center addObserver:self selector:@selector(onENRRResult:) name:kPOST_CMCC_NOTIFICATION_EN_RR_RESULT object:nil];
    // 登录成功（CmccUser）
    [center addObserver:self selector:@selector(onSelfLoginSuccess:) name:kPOST_CMCC_NOTIFICATION_LOGIN object:nil];
    // 在其他位置登录
    [center addObserver:self selector:@selector(onOtherLogin:) name:kPOST_CMCC_NOTIFICATION_OTHER_LOGIN object:nil];

    // ========== 错误码相关通知 ==========
    // 群组不存在
    [center addObserver:self selector:@selector(onGroupNoExist:) name:kPOST_CMCC_NOTIFICATION_GROUP_NOEXIST object:nil];
    // 无法退出群组（该群主为用户绑定的终端）
    [center addObserver:self selector:@selector(onGroupCannotExit:) name:kPOST_CMCC_NOTIFICATION_GROUP_CANNOT_EXIT object:nil];
    // 超过支持的最大群组数
    [center addObserver:self selector:@selector(onGroupExceedMaxGroup:) name:kPOST_CMCC_NOTIFICATION_GROUP_EXCEED_MAXGROUP object:nil];
    // 群组内成员达到最大数
    [center addObserver:self selector:@selector(onGroupExceedMaxMember:) name:kPOST_CMCC_NOTIFICATION_GROUP_EXCEED_MAXMEMBER object:nil];
    // 无权限加入群组
    [center addObserver:self selector:@selector(onGroupJoinNoDenied:) name:kPOST_CMCC_NOTIFICATION_GROUP_JOIN_NODENIED object:nil];
    // Token失效
    [center addObserver:self selector:@selector(onTokenInvalidity:) name:kPOST_CMCC_NOTIFICATION_TOKEN_INVALIDITY object:nil];
    // 验证码错误
    [center addObserver:self selector:@selector(onPhoneCodeError:) name:kPOST_CMCC_NOTIFICATION_PHONECODE_ERROR object:nil];

    // ========== 群组相关通知 ==========
    // 群组成员发生变化（NSString - gid）
    [center addObserver:self selector:@selector(onMembersChanged:) name:kPOST_CMCC_NOTIFICATION_MEMBERS_CHANGED object:nil];
    // 群组口令更新
    [center addObserver:self selector:@selector(onUpdateGroupToken:) name:kPOST_CMCC_NOTIFICATION_UPDATE_GROUP_TOKEN object:nil];
    // 群组转让完成（NSString: 0=成功, 1=失败）
    [center addObserver:self selector:@selector(onTransferGroupResult:) name:kPOST_CMCC_NOTIFICATION_TRANSFER_GROUP_RESULT object:nil];
    // 群组列表变化
    [center addObserver:self selector:@selector(onGroupListChanged:) name:kPOST_CMCC_NOTIFICATION_GROUPLIST_CHANGED object:nil];
    // 群组列表移除（NSArray<NSString *> - gid数组）
    [center addObserver:self selector:@selector(onGroupListRemoved:) name:kPOST_CMCC_NOTIFICATION_GROUPLIST_REMOVED object:nil];
    // 群组变化（NSString - gid）
    [center addObserver:self selector:@selector(onGroupChanged:) name:kPOST_CMCC_NOTIFICATION_GROUP_CHANGED object:nil];
    // 当前群组变化（CmccGroup）
    [center addObserver:self selector:@selector(onCurrentGroupChanged:) name:kPOST_CMCC_NOTIFICATION_CURRENTGROUP_CHANGED object:nil];
    // 当前群组变化-由创建群组触发（CmccGroup）
    [center addObserver:self selector:@selector(onCurrentGroupChangedByCreate:) name:kPOST_CMCC_NOTIFICATION_CURRENTGROUP_CHANGED_BYCREAT object:nil];
    // 群组解散（NSDictionary: @{@"success":@[gid数组], @"error":@[gid数组]})
    [center addObserver:self selector:@selector(onGroupDissolve:) name:kPOST_CMCC_NOTIFICATION_GROUP_DISSOLVE object:nil];
    // 单呼群组-对方回应（NSInteger）
    [center addObserver:self selector:@selector(onOtherSessionResponse:) name:kPOST_CMCC_NOTIFICATION_OTHER_SESSION_RESPONSE object:nil];

    // ========== 终端相关通知 ==========
    // app绑定终端信息（CmccBindDevice）
    [center addObserver:self selector:@selector(onBindDeviceInfo:) name:kPOST_CMCC_NOTIFICATION_BIND_DEVICE_INFO object:nil];
    // 获取成员状态（CmccUserStatus）
    [center addObserver:self selector:@selector(onQueryUserStatus:) name:kPOST_CMCC_NOTIFICATION_QUERY_USER_STATUS object:nil];
    // 获取终端状态变化（@{@"onlines":@[], @"offlines":@[]})
    [center addObserver:self selector:@selector(onQueryUserStatusChanged:) name:kPOST_CMCC_NOTIFICATION_QUERY_USER_STATUS_CHANGED object:nil];
    // 获取用户群组（CmccUserGroups）
    [center addObserver:self selector:@selector(onQueryUserGroups:) name:kPOST_CMCC_NOTIFICATION_QUERY_USER_GROUPS object:nil];
    // 终端添加/退出群组（CmccDevGroupChanged）
    [center addObserver:self selector:@selector(onDeviceChangeInfo:) name:kPOST_CMCC_NOTIFICATION_DEVICE_CHANGE_INFO object:nil];
    // 获取终端群组成员（CmccDeviceMembers）
    [center addObserver:self selector:@selector(onDeviceGroupMembers:) name:kPOST_CMCC_NOTIFICATION_DEVICE_GROUP_MEMBERS object:nil];

    // ========== 用户相关通知 ==========
    // 用户信息变化（NSArray<NSString *> - uid数组）
    [center addObserver:self selector:@selector(onUserChanged:) name:kPOST_CMCC_NOTIFICATION_USER_CHANGED object:nil];

    // ========== 对讲相关通知 ==========
    // 用户获得话语权（CmccSpeak）
    [center addObserver:self selector:@selector(onGetMic:) name:kPOST_CMCC_NOTIFICATION_GET_MIC object:nil];
    // 用户失去话语权（CmccSpeak）
    [center addObserver:self selector:@selector(onLostMic:) name:kPOST_CMCC_NOTIFICATION_LOST_MIC object:nil];
    // 群组成员开始讲话（NSDictionary: @{@"name":讲话人名称, @"gid":群组id}）
    [center addObserver:self selector:@selector(onMemberSpeakingStart:) name:kPOST_CMCC_NOTIFICATION_MEMBER_SPEAKING_START object:nil];
    // 群组成员结束讲话（NSString - 讲话人name）
    [center addObserver:self selector:@selector(onMemberSpeakingStop:) name:kPOST_CMCC_NOTIFICATION_MEMBER_SPEAKING_STOP object:nil];
    // 自己开始讲话（NSString - gid）
    [center addObserver:self selector:@selector(onSelfSpeakingStart:) name:kPOST_CMCC_NOTIFICATION_SELF_SPEAKING_START object:nil];
    // 自己开始讲话-群公告（NSString - gid）
    [center addObserver:self selector:@selector(onSelfSpeakingStartGroupPost:) name:kPOST_CMCC_NOTIFICATION_SELF_SPEAKING_START_GROUPPOST object:nil];
    // 自己结束讲话（NSMutableDictionary: @{@"isSuccess":@"", @"talkLength":@"", @"talkData":@"", @"gid":@""}）
    [center addObserver:self selector:@selector(onSelfSpeakingStop:) name:kPOST_CMCC_NOTIFICATION_SELF_SPEAKING_STOP object:nil];
    // 监听群组中有人开始讲话（CmccSpeak）
    [center addObserver:self selector:@selector(onCallingMemberStartSpeaking:) name:kPOST_CMCC_NOTIFICATION_CALLING_MEMBER_START_SPEAKING object:nil];
    // 监听群组中结束讲话（CmccSpeak）
    [center addObserver:self selector:@selector(onCallingMemberStopSpeaking:) name:kPOST_CMCC_NOTIFICATION_CALLING_MEMBER_STOP_SPEAKING object:nil];
    // 语音文件播放状态-开始（NSString - sid）
    [center addObserver:self selector:@selector(onPlayAudioFileStatusStart:) name:kPOST_CMCC_NOTIFICATION_PLAY_AUDIO_FILE_STATUS_START object:nil];
    // 语音文件播放状态-结束（NSString - sid）
    [center addObserver:self selector:@selector(onPlayAudioFileStatusStop:) name:kPOST_CMCC_NOTIFICATION_PLAY_AUDIO_FILE_STATUS_STOP object:nil];

    // ========== 全双工通知 ==========
    // 全双工群组列表变化
    [center addObserver:self selector:@selector(onSessionGroupListChanged:) name:kPOST_CMCC_NOTIFICATION_SESSIONGROUP_LIST_CHANGED object:nil];
    // 全双工群组变化（CmccGroup）
    [center addObserver:self selector:@selector(onSessionGroupChanged:) name:kPOST_CMCC_NOTIFICATION_SESSIONGROUP_CHANGED object:nil];
    // 全双工群组开始状态（NSNumber - CMCC_START_SESSION_REASON）
    [center addObserver:self selector:@selector(onSessionStart:) name:kPOST_CMCC_NOTIFICATION_SESSION_START object:nil];
    // 全双工群组回应（CmccSessionResponse）
    [center addObserver:self selector:@selector(onSessionResponse:) name:kPOST_CMCC_NOTIFICATION_SESSION_RESPONSE object:nil];
    // 全双工群组停止（CmccSessionStop）
    [center addObserver:self selector:@selector(onSessionStop:) name:kPOST_CMCC_NOTIFICATION_SESSION_STOP object:nil];
    // 音频会话开始播放
    [center addObserver:self selector:@selector(onAudioSessionStartPlay:) name:kPOST_CMCC_NOTIFICATION_AUDIOSESSION_STARTPLAY object:nil];
    // 音频会话开始录音
    [center addObserver:self selector:@selector(onAudioSessionStartRecord:) name:kPOST_CMCC_NOTIFICATION_AUDIOSESSION_STARTRECORD object:nil];
}

#pragma mark - 核心库相关通知

- (void)onENRRResult:(NSNotification *)notification {
    NSLog(@"📡 服务器异步回调结果: %@", notification.object);
}

- (void)onSelfLoginSuccess:(NSNotification *)notification {
    CmccUser *user = notification.object;
    NSLog(@"✅ 登录成功: %@ (uid: %@, account: %@)", user.name, user.uid, user.account);
}

- (void)onOtherLogin:(NSNotification *)notification {
    NSLog(@"⚠️ 账号已在其他位置登录");
}

#pragma mark - 错误码相关通知

- (void)onGroupNoExist:(NSNotification *)notification {
    NSLog(@"❌ 群组不存在: %@", notification.object);
}

- (void)onGroupCannotExit:(NSNotification *)notification {
    NSLog(@"❌ 无法退出群组（该群主为用户绑定的终端）: %@", notification.object);
}

- (void)onGroupExceedMaxGroup:(NSNotification *)notification {
    NSLog(@"❌ 操作失败，超过支持的最大群组数: %@", notification.object);
}

- (void)onGroupExceedMaxMember:(NSNotification *)notification {
    NSLog(@"❌ 加入失败，群组内成员已达到支持最大成员数: %@", notification.object);
}

- (void)onGroupJoinNoDenied:(NSNotification *)notification {
    NSLog(@"❌ 无权限加入该群组: %@", notification.object);
}

- (void)onTokenInvalidity:(NSNotification *)notification {
    NSLog(@"⚠️ Token失效: %@", notification.object);
}

- (void)onPhoneCodeError:(NSNotification *)notification {
    NSLog(@"❌ 验证码错误: %@", notification.object);
}

#pragma mark - 群组相关通知

- (void)onMembersChanged:(NSNotification *)notification {
    NSLog(@"👥 群组成员变化: %@", notification.object);
}

- (void)onUpdateGroupToken:(NSNotification *)notification {
    NSLog(@"🔑 群组口令更新: %@", notification.object);
}

- (void)onTransferGroupResult:(NSNotification *)notification {
    NSLog(@"🔄 群组转让完成: %@ (0=成功, 1=失败)", notification.object);
}

- (void)onGroupListChanged:(NSNotification *)notification {
    NSLog(@"📋 群组列表变化");
}

- (void)onGroupListRemoved:(NSNotification *)notification {
    NSLog(@"➖ 群组列表移除: %@", notification.object);
}

- (void)onGroupChanged:(NSNotification *)notification {
    NSLog(@"� 群组变化: %@", notification.object);
}

- (void)onCurrentGroupChanged:(NSNotification *)notification {
    CmccGroup *group = notification.object;
    NSLog(@"🏠 当前群组变化: gid=%@, name=%@", group.gid, group.name);
}

- (void)onCurrentGroupChangedByCreate:(NSNotification *)notification {
    CmccGroup *group = notification.object;
    NSLog(@"🏠 当前群组变化(创建): gid=%@, name=%@", group.gid, group.name);
}

- (void)onGroupDissolve:(NSNotification *)notification {
    NSLog(@"💥 群组解散: %@", notification.object);
}

- (void)onOtherSessionResponse:(NSNotification *)notification {
    NSLog(@"📞 单呼群组-对方回应: %@", notification.object);
}

#pragma mark - 终端相关通知

- (void)onBindDeviceInfo:(NSNotification *)notification {
    NSLog(@"📱 app绑定终端信息: %@", notification.object);
}

- (void)onQueryUserStatus:(NSNotification *)notification {
    NSLog(@"👤 获取成员状态: %@", notification.object);
}

- (void)onQueryUserStatusChanged:(NSNotification *)notification {
    NSLog(@"👤 获取终端状态变化: %@", notification.object);
}

- (void)onQueryUserGroups:(NSNotification *)notification {
    NSLog(@"📋 获取用户群组: %@", notification.object);
}

- (void)onDeviceChangeInfo:(NSNotification *)notification {
    NSLog(@"📱 终端添加/退出群组: %@", notification.object);
}

- (void)onDeviceGroupMembers:(NSNotification *)notification {
    NSLog(@"👥 获取终端群组成员: %@", notification.object);
}

#pragma mark - 用户相关通知

- (void)onUserChanged:(NSNotification *)notification {
    NSLog(@"👤 用户信息变化: %@", notification.object);
}

#pragma mark - 对讲相关通知

- (void)onGetMic:(NSNotification *)notification {
    NSLog(@"🎤 用户获得话语权: %@", notification.object);
}

- (void)onLostMic:(NSNotification *)notification {
    NSLog(@"🔇 用户失去话语权: %@", notification.object);
}

- (void)onMemberSpeakingStart:(NSNotification *)notification {
    NSLog(@"🔊 群组成员开始讲话: %@", notification.object);
}

- (void)onMemberSpeakingStop:(NSNotification *)notification {
    NSLog(@"🔇 群组成员结束讲话: %@", notification.object);
}

- (void)onSelfSpeakingStart:(NSNotification *)notification {
    NSLog(@"🎤 自己开始讲话: gid=%@", notification.object);
}

- (void)onSelfSpeakingStartGroupPost:(NSNotification *)notification {
    NSLog(@"📢 自己开始讲话(群公告): gid=%@", notification.object);
}

- (void)onSelfSpeakingStop:(NSNotification *)notification {
    NSLog(@"🛑 自己结束讲话: %@", notification.object);
}

- (void)onCallingMemberStartSpeaking:(NSNotification *)notification {
    NSLog(@"🔊 监听-群组中有人开始讲话: %@", notification.object);
}

- (void)onCallingMemberStopSpeaking:(NSNotification *)notification {
    NSLog(@"🔇 监听-群组中结束讲话: %@", notification.object);
}

- (void)onPlayAudioFileStatusStart:(NSNotification *)notification {
    NSLog(@"🎵 语音文件播放开始: sid=%@", notification.object);
}

- (void)onPlayAudioFileStatusStop:(NSNotification *)notification {
    NSLog(@"⏹ 语音文件播放结束: sid=%@", notification.object);
}

#pragma mark - 全双工通知

- (void)onSessionGroupListChanged:(NSNotification *)notification {
    NSLog(@"📞 全双工群组列表变化");
}

- (void)onSessionGroupChanged:(NSNotification *)notification {
    NSLog(@"📞 全双工群组变化: %@", notification.object);
}

- (void)onSessionStart:(NSNotification *)notification {
    NSLog(@"📞 全双工群组开始: reason=%@", notification.object);
}

- (void)onSessionResponse:(NSNotification *)notification {
    NSLog(@"📞 全双工群组回应: %@", notification.object);
}

- (void)onSessionStop:(NSNotification *)notification {
    NSLog(@"📞 全双工群组停止: %@", notification.object);
}

- (void)onAudioSessionStartPlay:(NSNotification *)notification {
    NSLog(@"🔊 音频会话开始播放");
}

- (void)onAudioSessionStartRecord:(NSNotification *)notification {
    NSLog(@"🎙 音频会话开始录音");
}

@end
