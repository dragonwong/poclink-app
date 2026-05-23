//
//  NotificationFile.h
//  PocStarCLib
//
//  Created by shanli on 2019/9/18.
//  Copyright © 2019 ShanLi_tech. All rights reserved.
//

#ifndef SUPNotification_h
#define SUPNotification_h

///**
// 请求返回结果code错误码
// */
//typedef NS_ENUM(NSInteger, ENUM_CMCC_ACK_CODE) {
//    ENUM_SUPPTT_CODE_SUCCESS         = 0,             // 无错误
//    ENUM_SUPPTT_CODE_DNS_SUCCESS     = 200,             // 无错误
//    ENUM_SUPPTT_CODE_LOGIN_TIMEOUT   = 1000,            // 登录超时
//    ENUM_SUPPTT_CODE_LOGIN_FAIL      = 1001,           // 用户或密码错误
//    ENUM_SUPPTT_CODE_PARAM_EMPTY     = 1002,            // 必选参数为空
//    ENUM_SUPPTT_CODE_PARAM_ERROR     = 1003,            // 参数错误
//    ENUM_SUPPTT_CODE_PHONECODE_ERROR = 1004,            // 验证码错误
//    ENUM_SUPPTT_CODE_NAME_EXIST      = 1006,            // 名称已存在
//    ENUM_SUPPTT_CODE_ACCOUNT_EXIST   = 1007,            // 账号已存在
//    ENUM_SUPPTT_CODE_PERMISSION_DENIED   = 1008,        // 权限不足
//    ENUM_SUPPTT_CODE_PASSWORD_ERROR  = 1009,            // 密码错误
//    ENUM_CMCC_ACK_CODE_DISABLED        = -8,            // 被禁用
//};

//设置昵称文字限制
#define kName_Max_Length 20
//设置群组名称文字限制
#define kGroupName_Max_Length 20
//网络请求超时时间（s）
#define NET_REQUEST_TIME_OUT 20

/******************/
//错误信息标识
/******************/
typedef NS_ENUM(NSInteger, ENUM_CMCC_ENERROR_CODE) {
    ENUM_CMCC_ENERROR_ACCOUNT_ERROR                 = 1,         //帐号密码错误
    ENUM_CMCC_ENERROR_ACCOUNT_OUTSERVICE            = 2,         //帐号已欠费或已超出服务期
    ENUM_CMCC_ENERROR_ACCOUNT_NOEXIST               = 3,         //帐号不存在
    ENUM_CMCC_ENERROR_INVALID_LOGIN_PRIVILEGE       = 4,         //无效的帐号登录权限
    ENUM_CMCC_ENERROR_ACCOUNT_BIND_ERROR            = 5,         //您的账号已被非法修改，请联系代理商
    ENUM_CMCC_ENERROR_INVALID_CONFIG                = 6,         //配置信息错误

//    ENUM_CMCC_ENERROR_KICKOUT                       = 10,        //帐号已在其他位置登录
    ENUM_CMCC_ENERROR_LOGIN_TIMEOUT                 = 11,        //帐号登录超时

    ENUM_CMCC_ENERROR_NETWORK_DISCONNECT            = 20,        //网络连接失败
    ENUM_CMCC_ENERROR_NETWORK_RECONECTING           = 21,        //网络正在重连
    ENUM_CMCC_ENERROR_CANNOT_CONNECT                = 22,        //无法连接服务器
    ENUM_CMCC_ENERROR_NETWORK_NO_SIGNAL             = 24,        //无网络信号

    ENUM_CMCC_ENERROR_JOIN_GROUP_TIMEOUT            = 30,        //加入群组请求超时
    ENUM_CMCC_ENERROR_JOIN_GROUP_FAILED             = 31,        //加入群组失败[未知错误]
    ENUM_CMCC_ENERROR_JOIN_GROUP_AUTH               = 32,        //加入群组失败[鉴权错误]
    ENUM_CMCC_ENERROR_JOIN_GROUP_NORIGHT            = 33,        //加入群组失败[权限错误]
    ENUM_CMCC_ENERROR_JOIN_GROUP_UNEXISTS           = 34,        //加入群组失败[不存在]
    ENUM_CMCC_ENERROR_JOIN_GROUP_EXPIRED            = 35,        //加入群组失败[过期]
    ENUM_CMCC_ENERROR_JOIN_GROUP_LIMIT              = 36,        //加入群组失败[配额限制]
    ENUM_CMCC_ENERROR_JOIN_GROUP_EMPTY              = 37,        //加入群组失败[有效的对象为空]
    ENUM_CMCC_ENERROR_JOIN_GROUP_DIABLED            = 38,        //加入群组失败[群组锁定/禁用]

    ENUM_CMCC_ENERROR_REQMIC_REFUSED                = 40,        //抢麦被拒绝
    ENUM_CMCC_ENERROR_REQMIC_REPEATEDLY             = 41,        //短暂时间内多次抢麦,不允许
    ENUM_CMCC_ENERROR_REQMIC_IN_AUDIOENABLE         = 42,        //遥闭状态抢麦,不允许
    ENUM_CMCC_ENERROR_REQMIC_IN_ERR_SSTATE          = 43,        //内部会话状态错误
    ENUM_CMCC_ENERROR_REQMIC_NO_AUDIOFOCUS          = 44,        //抢麦时申请音频焦点失败
    ENUM_CMCC_ENERROR_REQMIC_IN_LOW_ROLE            = 45,        //以较低的角色值抢麦
    ENUM_CMCC_ENERROR_REQMIC_TIMEOUT                = 46,        //接收抢麦回应超时

    ENUM_CMCC_ENERROR_RECORD_DEVICE                 = 50,        //打开录音设备失败

    ENUM_CMCC_ENERROR_ACCOUNT_LOCK_UP               = 60,        //账号被锁定
    ENUM_CMCC_ENERROR_TERMINAL_LOCK_UP              = 61,        //终端被锁定
    ENUM_CMCC_ENERROR_TERMINAL_CARD_LOCK_UP         = 62,        //机卡被锁定
    ENUM_CMCC_ENERROR_ACCOUNT_NOCONFIG              = 63,        //没有配置帐号信息
    
    ENUM_CMCC_ENERROR_LOGIN_HTTP_FAILED             = 1001,      //http请求失败
};

/**
 * @brief ACK回应类型
 */
typedef NS_ENUM(NSInteger, ENUM_CMCC_ACK_TYPE) {
    ENUM_CMCC_ACK_LOGIN                   = 0,
    ENUM_CMCC_ACK_LOGOUT                  = 1,
    ENUM_CMCC_ACK_QUERYGROUP              = 2,
    ENUM_CMCC_ACK_QUERYMEMBER             = 3,
    ENUM_CMCC_ACK_QUERYCONTACTS           = 4,
    ENUM_CMCC_ACK_JOINGROUP               = 5,
    ENUM_CMCC_ACK_LEAVEGROUP              = 6,
    ENUM_CMCC_ACK_QUITGROUP               = 7,
    ENUM_CMCC_ACK_WATCHGROUP              = 8,
    ENUM_CMCC_ACK_UNWATCHGROUP            = 9,
    ENUM_CMCC_ACK_CREATEGROUP             = 10,
    ENUM_CMCC_ACK_INVITEGROUP             = 11,
    ENUM_CMCC_ACK_RESPONSEGROUP           = 12,
    ENUM_CMCC_ACK_SETCONFIRMJOINGROUP     = 13,
    ENUM_CMCC_ACK_SETGROUPDND             = 14,
    ENUM_CMCC_ACK_SETLOCKINGGROUP         = 15,
    ENUM_CMCC_ACK_REMOVEMEMBER            = 16,
    ENUM_CMCC_ACK_UPDATETOKEN             = 17,
    ENUM_CMCC_ACK_DESTORYGROUP            = 18,
    ENUM_CMCC_ACK_CHANGENAME              = 19,
    ENUM_CMCC_ACK_SETAVATAR               = 20,
    ENUM_CMCC_ACK_SETSEX                  = 21,
    ENUM_CMCC_ACK_CHANGEPASSWORD          = 22,
    ENUM_CMCC_ACK_INVITECONTACTS          = 23,
    ENUM_CMCC_ACK_RESPONSECONTACT         = 24,
    ENUM_CMCC_ACK_REMOVECONTACTS          = 25,
    ENUM_CMCC_ACK_SETUSERNOTE             = 26,
    ENUM_CMCC_ACK_QUERYUSERNOTES          = 27,
    ENUM_CMCC_ACK_CHANGEGROUPNAME         = 28,
    ENUM_CMCC_ACK_TRANSFERGROUP           = 29,
    ENUM_CMCC_ACK_DELIVER                 = 30,
    ENUM_CMCC_ACK_SEARCHACCOUNT           = 31,
    ENUM_CMCC_ACK_QUERYGROUPINVITION      = 32,
    ENUM_CMCC_ACK_QUERYCONTACTINVITION    = 33,
    ENUM_CMCC_ACK_DELGROUPINVITION        = 34,
    ENUM_CMCC_ACK_DELCONTACTINVITION      = 35,
    ENUM_CMCC_ACK_SETSELFNAMEINGROUP      = 36,
    ENUM_CMCC_ACK_LISTENGROUP             = 37,
    ENUM_CMCC_ACK_UNLISTENGROUP           = 38,
    ENUM_CMCC_ACK_QUERYLISTENGROUP        = 39,
    ENUM_CMCC_ACK_SETGROUPMAXSPEECHTIME   = 40,
    ENUM_CMCC_ACK_SETGROUPPRIORITY        = 41,
    ENUM_CMCC_ACK_SETMEMBERPRIORITY       = 42,
    ENUM_CMCC_ACK_DELSESSION              = 43,
    ENUM_CMCC_ACK_STARTSESSION            = 44,
    ENUM_CMCC_ACK_STOPSESSION             = 45,
    ENUM_CMCC_ACK_RESPONSESESSION         = 46,
    ENUM_CMCC_ACK_RESPONJOINSESESSION     = 47,
    ENUM_CMCC_ACK_DISABLEUSER             = 48,
    ENUM_CMCC_ACK_ENABLEUSER              = 49,
    ENUM_CMCC_ACK_UNREADGROUP             = 50,
    ENUM_CMCC_ACK_UNREADCONTACT           = 51,
    ENUM_CMCC_ACK_RESPONSEGROUPTRANSFER   = 52,
    ENUM_CMCC_ACK_UNREADGROUPTRANSFER     = 53,
    ENUM_CMCC_ACK_DELGROUPTRANSFER        = 54,
    ENUM_CMCC_ACK_SETMEMBERREPORTLOCAL    = 55,
    ENUM_CMCC_ACK_SETMEMBERISMASTER       = 56,
    ENUM_CMCC_ACK_UPDATEINGROUPNAME       = 57,
    ENUM_CMCC_ACK_QUERYSAMEGROUP          = 58,
};

/**
 ACK状态值
 */
typedef NS_ENUM(NSInteger, ENUM_CMCC_ACK_CODE) {
    ENUM_CMCC_ACK_CODE_SUCCESS         = 0,             // 无错误
    ENUM_CMCC_ACK_CODE_ERROR           = -1,            // 一般性错误／未知原因错误
    ENUM_CMCC_ACK_CODE_AUTH            = -2,            // 鉴权错误
    ENUM_CMCC_ACK_CODE_NORIGHT         = -3,            // 权限错误
    ENUM_CMCC_ACK_CODE_UNEXIST         = -4,            // 不存在
    ENUM_CMCC_ACK_CODE_EXPIRED         = -5,            // 过期
    ENUM_CMCC_ACK_CODE_LIMIT           = -6,            // 配额限制
    ENUM_CMCC_ACK_CODE_EMPTY           = -7,            // 有效的对象为空
    ENUM_CMCC_ACK_CODE_DISABLED        = -8,            // 被禁用
};

/**
 版本标识
 */
typedef NS_ENUM(NSInteger, APP_VERSION_TYPE) {
    APP_VERSION_DEVELOPMENT = 0,//开发版
    APP_VERSION_TEST,//测试版
    APP_VERSION_CHINAMOBLE_RELEASE//正式版(发布)
};

/**
 群组类型
 */
typedef NS_ENUM(NSInteger, CMCC_GROUP_TYPE) {
    CMCC_GROUP_TYPE_STATIC = 1,//普通群组
    CMCC_GROUP_TYPE_TEMP = 2,
    CMCC_GROUP_TYPE_CONTACT = 3,
    CMCC_GROUP_TYPE_CHECKIN = 4,
    CMCC_GROUP_TYPE_SESSION  = 5,//单呼群组
    CMCC_GROUP_TYPE_SINGLE  = 6//多人全双工
};

/**
 群组状态
 */
typedef NS_ENUM(NSInteger, CMCC_GROUP_STATUS) {
    CMCC_GROUP_STATUS_IS_NORMAL = 0,//默认状态
    CMCC_GROUP_STATUS_OUT_OF_LIMIT = 1//过期或被限制
};

/**
 群组邀请信息分类
 */
typedef NS_ENUM(NSInteger, CMCC_GROUP_INVITE_SOURCE) {
    CMCC_GROUP_INVITE_TRANSFER_ISMINE = 0,//自己转让给他人
    CMCC_GROUP_INVITE_TRANSFER_ISOTHER = 1,//他人转让给自己
    CMCC_GROUP_INVITE_TOKEN_ISMINE = 2,//token进组自己
    CMCC_GROUP_INVITE_TOKEN_ISOTHER = 3,//token进组其他人
    CMCC_GROUP_INVITE_INVITER_ISMINE = 4,//自己是邀请者
    CMCC_GROUP_INVITE_INVITEE_ISMINE = 5,//自己是被邀请者
    CMCC_GROUP_INVITE_ISOTHER = 6//进群验证开启(自己不为邀请者,也不为被邀请者)
};

/**
 进组方式
 */
typedef NS_ENUM(NSInteger, CMCC_GROUP_JOIN_TYPE) {
    CMCC_GROUP_JOIN_NORMAL = 0,//默认状态→非主动进组
    CMCC_GROUP_JOIN_GID = 1,//gid进组
    CMCC_GROUP_JOIN_TOKEN = 2,//token进组
    CMCC_GROUP_JOIN_CREAT = 3,//由创建群组发生的进组行为
};

/**
 透传类型
 */
typedef NS_ENUM(NSInteger, CMCC_DELIVER_TYPE) {
    CMCC_DELIVER_TYPE_GROUP = 0,//群组透传
    CMCC_DELIVER_TYPE_USER,//用户透传
    CMCC_DELIVER_TYPE_SERVER,//服务透传
};

/**
 临时群组状态
 */
typedef NS_ENUM(NSInteger, CMCC_SESSION_GROUP_STATUS) {
    CMCC_SESSION_GROUP_STATUS_IDLE = 0,//空闲(未接听)
    CMCC_SESSION_GROUP_STATUS_CALLING,//呼叫中
    CMCC_SESSION_GROUP_STATUS_CONNECTED,//呼叫成功
};

/**
 stop_session_type(stop 拒绝session 类型)
 */
typedef NS_ENUM(NSInteger, CMCC_SESSION_STOP_REASON) {
    CMCC_SESSION_STOP_CANCEL = 0,//主动取消
    CMCC_SESSION_STOP_TIMEOUT,//超时
    CMCC_SESSION_STOP_TIMEOUT_CONNECTED,//正在通话中 超时
    CMCC_SESSION_STOP_CANCEL_CONNECTED,//正在通话中 主动取消
    CMCC_SESSION_STOP_OTHER,//意外错误中断(掉线,杀进程,服务器推送)
    CMCC_SESSION_STOP_PHONECALLING,//SIM卡打电话
    CMCC_SESSION_STOP_NETWORK_ERROR = 10,//本地网络中断
};

/**
 response_session_type(response 拒绝session 类型)
 */
typedef NS_ENUM(NSInteger, CMCC_SESSION_RESPONSE_REASON) {
    CMCC_SESSION_RESPONSE_CANCEL = 0,//主动取消
    CMCC_SESSION_RESPONSE_PTT,//按麦讲话中
    CMCC_SESSION_RESPONSE_CALLING,//正在通话中
    CMCC_SESSION_RESPONSE_PHONECALLING,//SIM卡打电话
};

/**
 start_session_type(start session 类型)
 */
typedef NS_ENUM(NSInteger, CMCC_START_SESSION_REASON) {
    CMCC_START_SESSION_SUCCESS = 0,//成功
    CMCC_START_SESSION_NOSUPPORT = 1,//对方版本不支持
    CMCC_START_SESSION_OUTLINE = 2,//对方不在线
    CMCC_START_SESSION_HASSESSION = 3,//对方已有临时群组(会话中)
    CMCC_START_SESSION_ISDND = 4,//对方已开启免打扰
};


#pragma mark 错误码相关通知
//群组不存在
static NSString *const kPOST_CMCC_NOTIFICATION_GROUP_NOEXIST = @"kPOST_CMCC_NOTIFICATION_GROUP_NOEXIST";
//该群主为用户绑定的终端，用户不能退出群组
static NSString *const kPOST_CMCC_NOTIFICATION_GROUP_CANNOT_EXIT = @"kPOST_CMCC_NOTIFICATION_GROUP_CANNOT_EXIT";
//操作失败，超过支持的最大群组
static NSString *const kPOST_CMCC_NOTIFICATION_GROUP_EXCEED_MAXGROUP = @"kPOST_CMCC_NOTIFICATION_GROUP_EXCEED_MAXGROUP";
//加入失败，群组内成员已达到支持最大成员数
static NSString *const kPOST_CMCC_NOTIFICATION_GROUP_EXCEED_MAXMEMBER = @"kPOST_CMCC_NOTIFICATION_GROUP_EXCEED_MAXMEMBER";
//无权限加入该群组
static NSString *const kPOST_CMCC_NOTIFICATION_GROUP_JOIN_NODENIED = @"kPOST_CMCC_NOTIFICATION_GROUP_JOIN_NODENIED";
//Token失效
static NSString *const kPOST_CMCC_NOTIFICATION_TOKEN_INVALIDITY = @"kPOST_CMCC_NOTIFICATION_TOKEN_INVALIDITY";
//验证码错误
static NSString *const kPOST_CMCC_NOTIFICATION_PHONECODE_ERROR = @"kPOST_CMCC_NOTIFICATION_PHONECODE_ERROR";


#pragma mark 核心库相关通知
//EN_RR_RESULT 服务器异步回调通知 附带(CmccAckResult对象)
static NSString *const kPOST_CMCC_NOTIFICATION_EN_RR_RESULT = @"kPOST_CMCC_NOTIFICATION_EN_RR_RESULT";
//登录成功 附带(CmccUser对象)
static NSString *const kPOST_CMCC_NOTIFICATION_LOGIN = @"kPOST_CMCC_NOTIFICATION_LOGIN";
//在其他位置登录
static NSString *const kPOST_CMCC_NOTIFICATION_OTHER_LOGIN = @"kPOST_CMCC_NOTIFICATION_OTHER_LOGIN";

#pragma mark 群组相关通知

//群组成员发生变化 通知 附带NSString类型 gid
static NSString *const kPOST_CMCC_NOTIFICATION_MEMBERS_CHANGED = @"kPOST_CMCC_NOTIFICATION_MEMBERS_CHANGED";
//群组口令更新
static NSString *const kPOST_CMCC_NOTIFICATION_UPDATE_GROUP_TOKEN = @"kPOST_CMCC_NOTIFICATION_UPDATE_GROUP_TOKEN";
//群组转让完成通知 (附带NSString类型 0=修改成功，1=修改失败)
static NSString *const kPOST_CMCC_NOTIFICATION_TRANSFER_GROUP_RESULT = @"kPOST_CMCC_NOTIFICATION_TRANSFER_GROUP_RESULT";
//群组列表发生变化
static NSString *const kPOST_CMCC_NOTIFICATION_GROUPLIST_CHANGED = @"kPOST_CMCC_NOTIFICATION_GROUPLIST_CHANGED";
//群组列表减量变化 (附带NSArray *<NSString *> 群组gid)
static NSString *const kPOST_CMCC_NOTIFICATION_GROUPLIST_REMOVED = @"kPOST_CMCC_NOTIFICATION_GROUPLIST_REMOVED";

//群组发生变化 (附带群组id)
static NSString *const kPOST_CMCC_NOTIFICATION_GROUP_CHANGED = @"kPOST_CMCC_NOTIFICATION_GROUP_CHANGED";

//当前群组发生变化 (附带CmccGroup)
static NSString *const kPOST_CMCC_NOTIFICATION_CURRENTGROUP_CHANGED = @"kPOST_CMCC_NOTIFICATION_CURRENTGROUP_CHANGED";

//当前群组发生变化(附带CmccGroup→由用户主动创建群组发生的)
static NSString *const kPOST_CMCC_NOTIFICATION_CURRENTGROUP_CHANGED_BYCREAT = @"kPOST_CMCC_NOTIFICATION_CURRENTGROUP_CHANGED_BYCREAT";
//群组解散附带(NSDictionary{@"success":@[成功解散gid数组],@"error":@[失败解散gid数组]})
static NSString *const kPOST_CMCC_NOTIFICATION_GROUP_DISSOLVE = @"kPOST_CMCC_NOTIFICATION_GROUP_DISSOLVE";

//单呼群组 别人回应 附带(NSInteget)
static NSString *const kPOST_CMCC_NOTIFICATION_OTHER_SESSION_RESPONSE = @"kPOST_CMCC_NOTIFICATION_OTHER_SESSION_RESPONSE";

#pragma mark 终端相关通知
//app绑定终端通知 (附带CmccBindDevice)
static NSString *const kPOST_CMCC_NOTIFICATION_BIND_DEVICE_INFO = @"kPOST_CMCC_NOTIFICATION_BIND_DEVICE_INFO";
//获取成员状态通知(附带 CmccUserStatus)
static NSString *const kPOST_CMCC_NOTIFICATION_QUERY_USER_STATUS = @"kPOST_CMCC_NOTIFICATION_QUERY_USER_STATUS";
//获取终端状态通知(附带 @{@"onlines":@[],@"offlines":@[]})
static NSString *const kPOST_CMCC_NOTIFICATION_QUERY_USER_STATUS_CHANGED = @"kPOST_CMCC_NOTIFICATION_QUERY_USER_STATUS_CHANGED";
//获取用户群组(附带 CmccUserGroups)
static NSString *const kPOST_CMCC_NOTIFICATION_QUERY_USER_GROUPS = @"kPOST_CMCC_NOTIFICATION_QUERY_USER_GROUPS";
//终端添加 退出群组通知 (附带CmccDevGroupChanged)
static NSString *const kPOST_CMCC_NOTIFICATION_DEVICE_CHANGE_INFO = @"kPOST_CMCC_NOTIFICATION_DEVICE_CHANGE_INFO";
//获取终端群组成员通知 (附带CmccDeviceMembers)
static NSString *const kPOST_CMCC_NOTIFICATION_DEVICE_GROUP_MEMBERS = @"kPOST_CMCC_NOTIFICATION_DEVICE_GROUP_MEMBERS";

#pragma mark 用户相关通知

//用户信息发生变化 通知 附带NSArray *<NSString *> uid数组
static NSString *const kPOST_CMCC_NOTIFICATION_USER_CHANGED = @"kPOST_CMCC_NOTIFICATION_USER_CHANGED";


#pragma mark 对讲相关
//用户获得话语权 CmccSpeak
static NSString *const kPOST_CMCC_NOTIFICATION_GET_MIC = @"kPOST_CMCC_NOTIFICATION_GET_MIC";
//用户失去话语权 CmccSpeak
static NSString *const kPOST_CMCC_NOTIFICATION_LOST_MIC = @"kPOST_CMCC_NOTIFICATION_LOST_MIC";

//群组成员话语权展示 通知 附带NSDictionary类型 @{@"name":讲话人名称,@"gid":群组id}  --- 开始播放即时对讲语音 已过滤自身uid
static NSString *const kPOST_CMCC_NOTIFICATION_MEMBER_SPEAKING_START = @"kPOST_CMCC_NOTIFICATION_MEMBER_SPEAKING_START";

//群组成员话语权隐藏 通知 附带NSString类型 讲话人name --- 停止播放即时对讲 已过滤自身uid
static NSString *const kPOST_CMCC_NOTIFICATION_MEMBER_SPEAKING_STOP = @"kPOST_CMCC_NOTIFICATION_MEMBER_SPEAKING_STOP";

//自己开始讲话 通知 附带NSString类型 gid
static NSString *const kPOST_CMCC_NOTIFICATION_SELF_SPEAKING_START = @"kPOST_CMCC_NOTIFICATION_SELF_SPEAKING_START";

//自己开始讲话 通知 附带NSString类型 gid(群公告)
static NSString *const kPOST_CMCC_NOTIFICATION_SELF_SPEAKING_START_GROUPPOST = @"kPOST_CMCC_NOTIFICATION_SELF_SPEAKING_START_GROUPPOST";

//自己结束讲话 通知 附带 NSMutableDictionary@{@"isSuccess":@"",@"talkLength":@"",@"talkData":@"",@"":@"gid"}
static NSString *const kPOST_CMCC_NOTIFICATION_SELF_SPEAKING_STOP = @"kPOST_CMCC_NOTIFICATION_SELF_SPEAKING_STOP";

//监听群组中有人开始讲话
static NSString *const kPOST_CMCC_NOTIFICATION_CALLING_MEMBER_START_SPEAKING = @"kPOST_CMCC_NOTIFICATION_CALLING_MEMBER_START_SPEAKING";
//监听群组中结束讲话 CmccSpeak
static NSString *const kPOST_CMCC_NOTIFICATION_CALLING_MEMBER_STOP_SPEAKING = @"kPOST_CMCC_NOTIFICATION_CALLING_MEMBER_STOP_SPEAKING";

//语音文件播放状态-开始(附带NSString 类型sid)
static NSString *const kPOST_CMCC_NOTIFICATION_PLAY_AUDIO_FILE_STATUS_START = @"kPOST_CMCC_NOTIFICATION_PLAY_AUDIO_FILE_STATUS_START";
//语音文件播放状态-结束(附带NSString 类型sid)
static NSString *const kPOST_CMCC_NOTIFICATION_PLAY_AUDIO_FILE_STATUS_STOP = @"kPOST_CMCC_NOTIFICATION_PLAY_AUDIO_FILE_STATUS_STOP";
#pragma mark 全双工通知
//全双工群组列表发生变化通知
static NSString *const kPOST_CMCC_NOTIFICATION_SESSIONGROUP_LIST_CHANGED = @"kPOST_CMCC_NOTIFICATION_SESSIONGROUP_CHANGED";
//全双工群组发生变化通知 (附带 CmccGroup对象)
static NSString *const kPOST_CMCC_NOTIFICATION_SESSIONGROUP_CHANGED = @"kPOST_CMCC_NOTIFICATION_SESSIONGROUP_CHANGED";
//全双工群组 开始状态 附带(NSNumber类型 对应CMCC_START_SESSION_REASON 请转换)
static NSString *const kPOST_CMCC_NOTIFICATION_SESSION_START = @"kPOST_CMCC_NOTIFICATION_SESSION_START";
//全双工群组 回应 附带(CmccSessionResponse对象)
static NSString *const kPOST_CMCC_NOTIFICATION_SESSION_RESPONSE = @"kPOST_CMCC_NOTIFICATION_SESSION_RESPONSE";
//全双工群组 停止 附带(CmccSessionStop对象)
static NSString *const kPOST_CMCC_NOTIFICATION_SESSION_STOP = @"kPOST_CMCC_NOTIFICATION_SESSION_STOP";

static NSString *const kPOST_CMCC_NOTIFICATION_AUDIOSESSION_STARTPLAY = @"kPOST_CMCC_NOTIFICATION_AUDIOSESSION_STARTPLAY";

static NSString *const kPOST_CMCC_NOTIFICATION_AUDIOSESSION_STARTRECORD = @"kPOST_CMCC_NOTIFICATION_AUDIOSESSION_STARTRECORD";
#endif /* SUPNotification_h */
