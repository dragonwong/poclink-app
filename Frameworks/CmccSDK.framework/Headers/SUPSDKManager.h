//
//  SUPSDKManager.h
//  SUPPTT
//
//  Created by broad on 2025/2/26.
//

#import <Foundation/Foundation.h>
@class SUPTerminalModel,SUPBindTerminalModel,SUPTerminalDetailModel,SUPGroupAudioModel,SUPMapLocationModel;
NS_ASSUME_NONNULL_BEGIN

#define SUPSDK_M [SUPSDKManager sharedManager]

@interface SUPSDKManager : NSObject

/**
 当前用户uid
 */
@property (nonatomic, copy) NSString *current_uid;

+(instancetype)sharedManager;

#pragma mark -------------初始化服务------------------
/**
 初始化 网路环境
 
 @param dns 核心库
 @param agent 代理
 @param html 隐私和用户协议
 @param version_type 版本控制
 */
-(void)init_dns:(NSString *)dns
           html:(NSString *)html
          agent:(NSString *)agent
   version_type:(APP_VERSION_TYPE)version_type;

/**
 读取本地配置文件
 
 @param section section
 @param key key
 @return value
 */
-(NSString *)read_ini_section:(NSString *)section
                          key:(NSString *)key;

/**
 写入本地配置文件
 
 @param section section
 @param key key
 @param value value
 @return 返回值 0成功 1失败
 */
-(int)write_ini_section:(NSString *)section
                    key:(NSString *)key
                  value:(NSString *)value;

/**
 同步网络状态

 @param has_network 是否有网
 */
-(void)post_event:(BOOL)has_network;

/**
 发送心跳方法
 */
-(void)send_ping;

/**
 重置dns解析

 @param reset 重置dns解析
 @return 返回值 0成功 1失败
 */
-(int)reset_dns:(BOOL)reset;
#pragma mark -------------代理------------------

/**
 判断账号是否存在
 @param account 账号
 */
- (void)PostIsExistAccount:(NSString *)account callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;

/**
 根据账号获取url
 @param account 账号
 */
- (void)GetServiceUrlWithAccount:(NSString *)account callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,NSArray <SUPRegionServerModel *> *modelsArr,NSString* errorStr))block;

/**
 获取url后 设置url
 @param extend 扩展接口
 @param sound 录音接口
 */
- (void)setExtendUrl:(NSString *)extend soundRecord:(NSString *)sound;

/**
 获取验证码
 @param account 必传
 @param type 类型 1.登录/注册   3.重置密码 4.换绑邮箱
 */
- (void)PostSendCodeWithAccount:(NSString *)account type:(NSInteger)type callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;

/**
 获取区域
 @param language  根据手机语言设置
 */
- (void)PostQueryRegionWithLanguage:(NSString *)language callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,NSArray <SUPTerminalModel *> *_Nullable arr,NSString* errorStr))block;
#pragma mark -------------登录------------------

/**
 app服务登录
 @param account 账号
 @param type 0:密码登录  1：验证码登录
 @param password type=0时 密码登录
 @param code type=1时 验证码登录

 */
- (void)PostLoginWithAccount:(NSString *)account type:(NSInteger)type password:(NSString *)password code:(NSString *)code callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPLoginModel *_Nullable model,NSString* errorStr))block;


#pragma mark -------------第三方账号登录------------------

/**
 获取code
 @param key  授权码
 @param name 第三方用户名或账号
 */
- (void)GetCodeWithKey:(NSString *)key username:(NSString *)name callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;
/**
 授权
 @param key  授权码
 @param name 第三方用户名或账号
 @param code 通过getCode获取的code
 @param ID  区域id（注册时必传）0 不传
 */
- (void)PostAuthWithKey:(NSString *)key username:(NSString *)name code:(NSString *)code regionId:(NSInteger)ID callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPLoginModel *_Nullable model,NSString* errorStr))block;

/**
 facebook 谷歌 苹果 第三方登录
 @param tokenStr  第三方sdk授权后返回的idtoken
 @param type app类型 2：Apple、3：Google、5：Facebook
 @param email 非必传
 @param name  非必传
 */
- (void)PostAuthWithIdToken:(NSString *)tokenStr type:(NSInteger)type email:(NSString *)email name:(NSString *)name callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPLoginModel *_Nullable model,NSString* errorStr))block;
#pragma mark -------------用户------------------
/**
 语音服务登陆
 
 注意：该接口需要登录的账号绑定了终端设置才返回成功 如果账号没有绑设备 需要先做设备绑定逻辑
 如果账号有绑定设置才返回登录成功通知
 
 @param account 账号
 @param password 密码
 @param type 类型
 @return 返回值 0成功 1失败
 */
-(int)login_account:(NSString *)account
           password:(NSString *)password
               type:(int)type;
/**
 注销账号
 @param account 用户账号
 */
- (void)PostDestroyUser:(NSString *)account callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;

/**
 app 修改绑定或绑定第三方谷歌 facebook 苹果 账号
 @param type app类型 2：apple、3：google  5：facebook
 @param tokenStr idtoken
 @param email 非必传
 @param name 非必传
 */
- (void)PostAccountBindWithType:(NSInteger)type idToken:(NSString *)tokenStr email:(NSString *)email name:(NSString *)name callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;

/**
 app 修改绑定或绑定邮箱
 @param email 邮箱
 @param code 邮箱验证码  通过PostSendCodeWithAccount 获取验证码
 */
- (void)PostAccountBindEmail:(NSString *)email code:(NSString *)code callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;
/**
 核心库退出登录
 */
-(int)logout;
/**
 打开/关闭log

 @param open 打开/关闭
 */
-(void)openLog:(BOOL)open;

/**
 获取指定用户信息
 
 @param uid 用户id
 @return 用户信息
 */
-(CmccUser *)get_user_uid:(NSString *)uid;

/**
 获取当前用户信息

 @return 用户信息
 */
-(CmccUser *)get_current_user;

/**
 判断用户是否正在讲话中
 
 @return 返回值 bool
 */
-(BOOL)is_speaking;

/**
 判断用户是否正在收听
 
 @return 返回值 bool
 */
-(BOOL)is_listening;

#pragma mark -------------终端------------------
/**
 获取成员状态
  kPOST_CMCC_NOTIFICATION_QUERY_USER_STATUS 通知回调结果
 @return 返回值 0成功 1失败
 */
-(int)query_user_status:(NSString *)uid;
/**
 查询用户群组列表
 
 @return 终端群组列表数组
 kPOST_CMCC_NOTIFICATION_QUERY_USER_GROUPS 通知回调
 */
-(int)query_user_grouplist_uid:(NSString *)uid;

/**
 获取绑定终端列表
 */
- (void)PostQueryBindTermianlCallBack:(void(^)(NSURLSessionDataTask* _Nonnull task,NSArray <SUPTerminalModel *>*model,NSString* errorStr))block;
/**
 查询终端信息
 @param account 账号 app是手机号 终端是imei
 */
- (void)PostQueryTermianlWithAccount:(NSString *)account callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPTerminalModel *model,NSString* errorStr))block;
/**
 查询终端绑定状态
 @param imei  终端imei
 */
- (void)PostQueryTermianlIsBindImei:(NSString *)imei callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBindTerminalModel *model,NSString* errorStr))block;
/**
 绑定终端
 @param imei  终端imei
 */
- (void)PostBindTermianlWithImei:(NSString *)imei callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;

/**
 获取终端详情信息
 @param uid  用户id
 @param groupID  群组id 可选参数  没有群组就传0
 */
- (void)PostQueryTermianlDetails:(NSInteger)uid groupId:(NSInteger)groupID callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPTerminalDetailModel *model,NSString* errorStr))block;
/**
 终端名称修改
 @param name  修改后的名称
 @param uid  终端uid
 */
- (void)PostModifyTermianlName:(NSString *)name uid:(NSInteger)uid callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;
/**
 终端创建群组
 @param uid  用户id
 @param imei  创建人imei
 @param groupName  群组名称 需要做限制表情输入限制
 @param list  群组成员账号
 @param expireTime   群组有效期 单位秒 0=永久
 */
- (void)PostTermianlCreateGroup:(NSInteger)uid imei:(NSString *)imei groupName:(NSString *)groupName accountList:(NSArray<NSString *>*)list expireTime:(NSInteger)expireTime callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;
/**
 解绑终端
 @param imei  终端imei
 */
- (void)PostTermianlUnBindImei:(NSString *)imei callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;
/**
 修改终端在群组中的共享位置开关状态
 @param uid  终端uid
 @param groupID  群组id
 @param gpsDisplay  开关状态 0关 1开
 */
- (void)PostTermianlUpdateGpsDisplay:(NSInteger)uid groupID:(NSInteger)groupID gpsDisplay:(NSInteger)gpsDisplay callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;

/**
 终端退出群组
 @param imei  终端imei
 @param groupID  群组id
 */
- (void)PostTermianlQuitGroups:(NSString *)imei groupID:(NSInteger)groupID callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;

/**
 终端解散群组
 @param groupID  群组id
 */
- (void)PostTermianlDestroyGroup:(NSInteger)groupID callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;

/**
 终端修改位置开关和上报位置间隔
 @paramuid
 @param status 位置开关 0关 1开
 @param period 上报时间间隔 单位秒 默认10分钟 600秒
 */
- (void)PostTermianlUpdateLocation:(NSInteger)uid status:(NSInteger)status period:(NSInteger)period callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;

/**
 终端切组
 @paramuid
 @param groupID 群组id
 */
- (void)PostTermianlJoinGroup:(NSInteger)uid groupID:(NSInteger)groupID callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;
/**
 终端加入多个群组
 @paramuid
 @param gidArr 群组id数组
 */
- (void)PostTermianlJoinMoreGroup:(NSInteger)uid gidArr:(NSArray <NSNumber *> *)gidArr callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;

/**
 获取监听群组列表
 @paramuid
 @param keyword 搜索关键字
 */
- (void)PostTermianlGetListenGroups:(NSInteger)uid keyword:(NSString *)keyword callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;
/**
 批量添加监听群组
 @paramimei
 @param gidsArr 群组id数组
 */
- (void)PostTermianlAddListenGroups:(NSString *)imei gidsArr:(NSArray<NSNumber *> *)gidsArr callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;

/**
 移除监听群组
 @paramimei
 @paramgroupID 群组id
 */
- (void)PostTermianlunListenGroup:(NSString *)imei groupID:(NSInteger)gid callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;

/**
 获取终端类型列表
 @param keywords 搜索关键字
 */
- (void)PostQueryTerminalType:(NSString *)keywords callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,NSArray <SUPTerminalModel *> *arr,NSString* errorStr))block;
#pragma mark -------------群组------------------
/**
 用户通过群组码加入群组
 @param groupCode 群组码
 @param mems 成员uid 数组
 */
- (void)PostJoinGroup:(NSString *)groupCode members:(NSArray <NSNumber *>*)mems callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;
/**
 用户通过群组id加入群组
 @param groupID 群组id
 @param mems 成员uid 数组
 */
- (void)PostJoinGroupWithGroupID:(NSInteger)groupID members:(NSArray <NSNumber *>*)mems callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;
/**
 移除群组成员
 @param groupID 群组id
 @param mems 成员account 数组
 */
- (void)PostGroupRemoveMember:(NSInteger)groupID members:(NSArray <NSString *>*)mems callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;
/**
 群主转让
 kPOST_CMCC_NOTIFICATION_TRANSFER_GROUP_RESULT  转让结果通知
 
 @param groupID 群组id
 @param acceptor 原群主id
 @param transferor 接受转让的群主id
 */
- (void)PostTransferGroup:(NSInteger)groupID acceptor:(NSInteger)acceptor transferor:(NSInteger)transferor callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;

/**
 获取监听群组的终端
 @param groupID 群组id
 @param keyword 搜索关键字
 */
- (void)PostListenTerminals:(NSInteger)groupID keyword:(NSString *)keyword callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;
/**
 设置领队
 @param groupID 群组id
 @param uid 需要设置领队的uid
 */
- (void)PostGroupChangeLeader:(NSInteger)groupID userID:(NSInteger)uid callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;
/**
 查询用户在该群组中的位置开关是否打开
 @param groupID 群组id
 @param uid 用户id
 */
- (void)PostGroupGpsDisplay:(NSInteger)groupID userID:(NSInteger)uid callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,BOOL isOpen,NSString* errorStr))block;

/**
 群组名称修改
 @param groupID 群组id
 @param name 修改后的名称
 */
- (void)PostGroupUpdateName:(NSInteger)groupID groupName:(NSString *)name callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPBaseModel *model,NSString* errorStr))block;


/**
 查询群组列表
 
 @return 群组列表数组
 */
-(NSArray *)query_grouplist;
/**
 查询临时群组列表
 
 @return 群组列表数组
 */
-(NSArray *)query_session_grouplist;

/**
 查询指定群组

 @param gid 群组id
 @return 返回值 0成功 1失败
 */
-(CmccGroup *)query_group_gid:(NSString *)gid;

/**
 查询当前群组

 @return 返回值 0成功 1失败
 */
-(CmccGroup *)get_current_group;


/**
 自动进组开关
 
 @param is_join_default  开/关
 @return 返回值 0成功 1失败
 */
-(int)set_join_group_default:(BOOL)is_join_default;

/**
 加入群组
 
 @param gid 群组id
 @param contact_id 单呼好友id 自己加组传空
 @param token 群组口令 传空
 @param is_limit 是否是过期群组 @"1":过期群组 @"0":正常群组
 @return 返回值 0成功 1失败
 */
-(int)join_group_gid:(NSString *)gid
          contact_id:(NSString *)contact_id
               token:(NSString *)token
            is_limit:(NSString *)is_limit;

/**
 创建群组
 
 @param name 群组名称 需要做限制表情输入限制
 @param type 群组类型 传1
 @param list 群组成员账号数组
 @param time 群组多少秒后到期 单位秒  永久有效=0
 @return 返回值 0成功 1失败
 */
-(int)create_group:(NSString *)name
              type:(NSString *)type
       accountList:(NSArray<NSString *>*)list
       expire_time:(NSInteger)time;

/**
 获取群组口令
 kPOST_CMCC_NOTIFICATION_UPDATE_GROUP_TOKEN 通知
 
 @param gid 群组id
 @return 返回值 0成功 1失败
 */
-(int)update_token:(NSString *)gid;

/**
 获取某一个群组的全部成员
 
 @param gid 群组id
 @return 成员数组
 */
-(NSArray *)query_memberlist:(NSString *)gid;


/**
 离开当前群组

 @return 返回值 0成功 1失败
 */
-(int)leave_group;


/**
 开启/关闭 群组免打扰
 
 @param dnd 开启/关闭
 @param gid 群组id
 @return 返回值 0成功 1失败
 */
-(int)set_group_dnd:(BOOL)dnd
                gid:(NSString *)gid;

/**
 自动进组开关状态
 
 @return 返回值 状态
 */
-(BOOL)join_default_group_state;

/**
 监听/取消监听群组
 
 @param open 打开/关闭
 @param gid 群组id
 @return 返回值 0成功 1失败
 */
-(int)listen_group:(BOOL)open
               gid:(NSString *)gid;

/**
 获取群组监听状态
 
 @param gid 群组id
 @return 返回值 状态
 */
-(BOOL)is_listen_group:(NSString *)gid;

#pragma mark -------------录音------------------
/**
 获取录音记录
 @param groupID 群组id
 @param type 类型（0：向未来时间查，返回时间为正序 1：向过去时间查，返回时间为倒序）
 @param speechID 录音记录id 会根据这条id查前面的录音 或者后面的录音记录 配合type使用  可选参数 没有传空
 @param size 查询返回条数
 */
- (void)PostQuerySoundRecord:(NSInteger)groupID type:(NSInteger)type speechID:(NSString *)speechID size:(NSInteger)size callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,NSArray <SUPGroupAudioModel *> *arr,NSString* errorStr))block;

/**
 根据录音id获取录音记录
 @param speechID 录音记录id
 */
- (void)PostQueryOneSoundRecord:(NSInteger)speechID callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,SUPGroupAudioModel *model,NSString* errorStr))block;

/**
 获取完整的录音播放连接
 @param path SUPGroupAudioModel中的path
 @return 完整的播放链接地址
 */
- (NSString *)GetSpeechAudioPlayFileWithPath:(NSString *)path;

/**
 播放音频文件
 
 @param path 路径
 @param sid sid
 @param paytype 对应payload
 @return 返回值 0成功 1失败
 kPOST_CMCC_NOTIFICATION_PLAY_AUDIO_FILE_STATUS_START  开始播放回调通知
 */
-(int)play_audio_file:(NSString *)path
                  sid:(NSString *)sid
              paytype:(NSString *)paytype;

/**
 停止播放音频文件

 @return 返回值 0成功 1失败
 kPOST_CMCC_NOTIFICATION_PLAY_AUDIO_FILE_STATUS_STOP 停止播放回调通知
 */
-(int)stop_play;

#pragma mark -------------定位 位置信息------------------
/**
 获取群组成员位置信息
 @param groupID 群组id
 @param uid 用户id 可选参数 没有传0
 */
- (void)PostQueryLastLocation:(NSInteger)groupID uid:(NSInteger)uid callBack:(void(^)(NSURLSessionDataTask* _Nonnull task,NSArray <SUPMapLocationModel *> *arr,NSString* errorStr))block;

/**

 app上传位置
 @param latitude 纬度
 @param longitude 经度
 @param speed 风速
 @param source 卫星定位(GPS)  = 1、基站定位 = 2、WIFI定位 = 3、AGPS = 4
 @param altitude 海拔
 @param direction 方向
 @param timestamp 时间戳
 @param address 上地址
 */
-(void)deliver_location_infoWithLatitude:(double)latitude
                               longitude:(double)longitude
                                   speed:(double)speed
                                  source:(int)source
                                altitude:(double)altitude
                               direction:(double)direction
                               timestamp:(double)timestamp
                                 address:(NSString *)address;
#pragma mark/************************ 临时单呼 ************************/
/**
临时单呼(session)

@param group_name 群组名称
@param account 被邀请人account
@return 返回值 0成功 1失败
*/
-(int)create_session_group:(NSString *)group_name
                   account:(NSString *)account
               expire_time:(NSInteger)time;
/**
多人临时单呼(session)

@param group_name 群组名称
@param account 被邀请人accounts
@return 返回值 0成功 1失败
*/
-(int)create_session_group:(NSString *)group_name
                   accounts:(NSArray <NSString *> *)account
                expire_time:(NSInteger)time;

/**
临时单呼(session) 回应

@param gid 群组id
@param accept 是否同意
@param reason 如拒绝 原因
@return 返回值 0成功 1失败
*/
-(int)response_session:(NSString *)gid
                accept:(BOOL)accept
                reason:(int)reason;

/**
临时单呼(session) 停止

@param gid 群组id
@param reason 原因
@return 返回值 0成功 1失败
*/
-(int)stop_session:(NSString *)gid
            reason:(int)reason;

/**
临时单呼(session) 删除session 群组

@param gid 群组id
@return 返回值 0成功 1失败
*/
-(int)delete_session:(NSString *)gid;

/**
关闭扬声器 YES 关闭  NO 打开
*/
-(void)audioSpeakerClose:(BOOL)close;
/**
禁麦 YES 关闭  NO 打开
*/
-(int)set_RecorderMute:(BOOL)ismute;
/**
 静音
 @return 返回值 bool
 */
-(BOOL)set_mute:(BOOL)ismute;

#pragma mark/************************ 对讲相关 ************************/

/**
 开始讲话
 
 @param is_ble 是否通过蓝牙端口
 @return 返回值 0成功 1失败
 */
-(int)start_speak:(BOOL)is_ble;

/**
 结束讲话
 
 @return 返回值 0成功 1失败
 */
-(int)stop_speak;

#pragma mark/************************ 其他 ************************/
/**
 透传消息给指定用户
 
 @param uid  用户id
 @param bodyDic 数据字典
 @return 返回值 0成功 1失败
 */
-(int)external_msg_to_user:(NSString *)uid
                   bodyDic:(NSDictionary *)bodyDic;
@end

NS_ASSUME_NONNULL_END
