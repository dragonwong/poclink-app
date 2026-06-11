//
//  CmccDataManager.h
//  CmccSDK
//
//  Created by YANG DONG on 2021/4/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define CMCC_D [CmccDataManager sharedManager]
NS_ASSUME_NONNULL_BEGIN

/** 数据库查询成功回调 */
typedef void(^dataQueryComplete)(id queryObject);

@interface CmccDataManager : NSObject

/**
 是否打开log输出
 */
@property (nonatomic, assign) BOOL open_log;

/**
 当前用户uid
 */
@property (nonatomic, copy) NSString *current_uid;

/**
 是否有当前群组
 */
@property (nonatomic, assign) BOOL has_current_group;

/**
 是否正在讲话
 */
@property (nonatomic, assign, readonly) BOOL is_speaking;

/**
 是否正在收听
 */
@property (nonatomic, assign, readonly) BOOL is_listening;

/**
 当前讲话人
 */
@property (nonatomic, strong) CmccSpeak *current_speaker;

/**
 是否正在位置功效
 */
@property (nonatomic, assign) BOOL is_sharing_location;

/**
 网络状态
 */
@property (nonatomic, assign) BOOL network_enable;

/**
 用户在线状态
 */
@property (nonatomic, copy) NSString *online_status;

/**
 最后进入的群组
 */
@property (nonatomic, strong) CmccGroup *last_group;

/**
 位置共享 数组
 */
@property (nonatomic, strong) NSMutableArray *share_location_arr;

/**
 用户备注数组
 */
@property (nonatomic, strong) NSMutableArray *user_note_arr;

/**
 好友列表数组
 */
@property (nonatomic, strong) NSMutableArray *contact_arr;

/**
 好友邀请信息数组(已过滤重复)
 */
@property (nonatomic, strong) NSMutableArray *contact_invite_arr;

/**
 群组邀请信息数组(已过滤重复)
 */
@property (nonatomic, strong) NSMutableArray *group_invite_arr;

/**
 好友邀请信息数组(未过滤)
 */
@property (nonatomic, strong) NSMutableArray *contact_invite_arr_all;

/**
 群组邀请信息数组(未过滤)
 */
@property (nonatomic, strong) NSMutableArray *group_invite_arr_all;

/**
 本次打开app是否登录成功过
 */
@property (nonatomic, assign) BOOL once_login_success;

/**
 当前临时单呼群组缓存
 */
@property (nonatomic, strong) CmccGroup *session_model;

/**
 当前群组为过期群组时 缓存'假'当前群组
 */
@property (nonatomic, strong) CmccGroup *limit_current_group;

/**
 弹出"群组已解散"相关的alert 次数,用来控制多次弹框
 */
@property (nonatomic, assign) NSInteger group_alert_showNum;

/**
 群组最后一条消息(最后一个讲话人)
 */
@property (nonatomic, strong) NSMutableArray *last_message_arr;

/**
 当前音频录制端口是否为蓝牙音箱
 */
@property (nonatomic, assign) BOOL is_ble_port;

/**
 当前群组缓存
 */
@property (nonatomic, strong) CmccGroup *cache_current_group;

/**
 当前主动进组方式
 */
@property (nonatomic, assign) CMCC_GROUP_JOIN_TYPE current_join_type;

/**
 主动进组缓存群组名 用于join_ack错误时 alert提示文字
 */
@property (nonatomic, copy) NSString *join_group_name;

/**
 Join_ack_noright时 是否展示alert
 */
@property (nonatomic, assign) BOOL need_show_alert_noright;

/**
 当前输出端口 1:听筒 2:外放
 */
@property (nonatomic, assign) int currentOutputPort;

/**
 是否为主动离组
 */
@property (nonatomic, assign) BOOL is_my_leave_group;

/**
 自动进组开启状态
 */
@property (nonatomic, assign, readonly) BOOL is_join_default_group;

/**
 主动进组缓存群组id 用于join_ack错误时 埋点所需数据(仅在群组列表主动进组 与新建群组后缓存)
 */
@property (nonatomic, copy) NSString *join_group_gid;

/**
 添加好友时 对方用户信息 -埋点所需数据
 */
@property (nonatomic, strong) CmccUser *make_contact_msg;

/**
 eos信息缓存
 */
@property (nonatomic, strong) NSDictionary *eosMsgDic;

/**
 调用join_group时间缓存
 */
@property (nonatomic, copy) NSString *join_group_time;

/**
 sos紧急联系人
 */
@property (nonatomic, strong,readonly) NSArray<CmccRelatedContact *> *sosContacts;

#pragma mark init
+(CmccDataManager *)sharedManager;

#pragma mark/************************ 用户 ************************/
/**
 查询用户备注

 @return 备注
 */
-(NSString *)query_user_note:(NSString *)uid;

#pragma mark/************************ 成员 ************************/
/**
 查询成员

 @param gid 群组id
 @param uid 用户id
 @return 成员信息
 */
-(CmccMember *)query_member_gid:(NSString *)gid
                            uid:(NSString *)uid;

/**
 判断指定群组的成员中是否包含该用户

 @param gid 群组id
 @param account 用户account
 @return 是否包含该用户
 */
-(BOOL)member_contain_account_gid:(NSString *)gid
                          account:(NSString *)account;
/**
 sos紧急联系人保存
 */
-(void)sos_contact_save:(NSArray<CmccRelatedContact *> *)arr;
/**
 获取sos紧急联系人
 */
-(NSArray<CmccRelatedContact *>*)get_sos_contact_users;
#pragma mark/************************ 群组列表 ************************/
/**
 保存所有群组信息
 
 @param groups 群组对象数组
 */
-(void)group_list_save_groups:(NSArray *)groups;
/**
 保存所有临时群组信息
 
 @param groups 群组对象数组
 */
-(void)group_session_list_save_groups:(NSArray *)groups;
/**
 查询指定群组
 
 @param gid 群组id
 @return 群组
 */
-(CmccGroup *)group_list_query_group:(NSString *)gid;
/**
 查询指定临时群组
 
 @param gid 群组id
 @return 群组
 */
-(CmccGroup *)group_session_list_query_group:(NSString *)gid;
/**
 更新指定群组信息

 @param group 更新
 */
-(void)group_list_update_group:(CmccGroup *)group;
/**
 更新指定临时群组信息

 @param group 更新
 */
-(void)group_session_list_update_group:(CmccGroup *)group;
/**
 新增群组
 
 @param group 群组
 */
-(void)group_list_add:(CmccGroup *)group;
/**
 新增临时群组
 
 @param group 群组
 */
-(void)group_session_list_add:(CmccGroup *)group;
/**
 根据群组id 删除指定数据

 @param gid 群组id
 */
-(void)group_list_remove_group:(NSString *)gid;
/**
 根据临时群组id 删除指定数据

 @param gid 群组id
 */
-(void)group_session_list_remove_group:(NSString *)gid;
/**
 查询所有群组信息
 
 @return 所有群组
 */
-(NSArray *)group_list_query;
/**
 查询所有临时群组信息
 
 @return 所有群组
 */
-(NSArray *)group_session_list_query;
/**
 删除所有组信息
 */
-(void)group_list_clean;
/**
 删除所有临时群组信息
 */
-(void)group_session_list_clean;
#pragma mark/************************ 好友 ************************/

/**
 根据uid查询好友信息

 @param uid 用户id
 @return 好友信息
 */
-(CmccUser *)query_contact_uid:(NSString *)uid;

#pragma mark/************************ Public Function ************************/
/**
 删除所有cache 缓存
 */
-(void)cache_clean;

/**
 写入日志文件
 
 @param log 字符串
 @return 写入成功?
 */
-(BOOL)output_log:(NSString *)log;

/**
 MD5 32位 大写 
 
 @param str 字符串
 @return MD5结果
 */
-(NSString *)MD5ForUpper32Bate:(NSString *)str;

/**
 字符串是否为空
 
 @param string 字符串
 @return 是/否为空
 */
-(BOOL)emptyValidate:(NSString *)string;

/**
 是否是当前群组
 
 @param gid 群组id
 @return 是/否
 */
-(BOOL)is_current_group:(NSString *)gid;

/**
 是否是当前用户
 
 @param uid 用户id
 @return 是/否
 */
-(BOOL)is_current_user:(NSString *)uid;

/**
 是否是好友
 
 @param uid 用户id
 @return 是/否
 */
-(BOOL)is_my_contact:(NSString *)uid;

/**
 手机号格式隐私转换
 
 @param phone 手机号
 @return 转换后字符串
 */
-(NSString *)phone_encryption:(NSString *)phone;

/**
 成员名称显示→格式化
 
 @param member 成员
 @return 显示名称.规则:note>ingroup_name>user_name>user_account
 */
-(NSString *)format_member_showname:(CmccMember *)member;

/**
 用户名称显示→格式化
 
 @param uid 用户id
 @param gid 群组id
 @return 显示名称.规则:note>ingroup_name>user_name>user_account
 */
-(NSString *)format_user_showname_uid:(NSString *)uid
                                  gid:(NSString *)gid;

/**
 获取网络时间
 
 @return 网络时间
 */
-(NSDate *)get_internet_date;

/**
 member 数据排序(ingroup_time先后顺序)
 
 @param ingroup_vip_arr 在组 vip
 @param ingroup_normal_arr 在组 普通用户
 @param notingroup_vip_arr 不在组 vip
 @param notingroup_normal_arr 不在组 普通用户\
 @return 排序完成成员数组
 */
-(NSMutableArray *)sort_ingroup_vip_arr:(NSMutableArray *)ingroup_vip_arr
                     ingroup_normal_arr:(NSMutableArray *)ingroup_normal_arr
                     notingroup_vip_arr:(NSMutableArray *)notingroup_vip_arr
                  notingroup_normal_arr:(NSMutableArray *)notingroup_normal_arr;

/**
 获取当前屏幕显示的viewcontroller
 
 @return 当前vc
 */
-(UIViewController *)getCurrentVC;

/**
 判断http接口请求状态值
 
 @return 是否成功
 */
-(BOOL)api_successful_response:(id)response;

@end

NS_ASSUME_NONNULL_END
