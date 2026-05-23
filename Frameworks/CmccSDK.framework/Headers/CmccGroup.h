//
//  CmccGroup.h
//  CmccSDK
//
//  Created by YANG DONG on 2021/4/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccGroup : NSObject
/**
 群组id
 */
@property (copy, nonatomic) NSString *gid;

/**
 群组名称
 */
@property (copy, nonatomic) NSString *name;

/**
 群组类型
 */
@property (assign, nonatomic) CMCC_GROUP_TYPE type;

/**
 创建者id
 */
@property (copy, nonatomic) NSString *creator;
/**
 群组优先级
 */
@property (assign, nonatomic) NSInteger priority;

/**
 群组口令
 */
@property (copy, nonatomic) NSString *token;

/**
 口令失效时间
 */
@property (assign, nonatomic) NSInteger token_expired;

/**
 群组失效时间
 */
@property (assign, nonatomic) NSInteger expired;

/**
 群组最大人数
 */
@property (assign, nonatomic) NSInteger max_members;

/**
 群组状态
 */
@property (assign, nonatomic) CMCC_GROUP_STATUS status;

/**
 排序标识
 */
@property (copy, nonatomic) NSString *sort_key;

/**
 群组成员个数
 */
@property (assign, nonatomic) NSInteger member_count;

/**
 群组成员在组人数
 */
@property (assign, nonatomic) NSInteger member_ingroup;

/**
 群组是否禁言
 */
@property (assign, nonatomic) BOOL audio_enabled;

/**
 是否需要进群验证
 */
@property (assign, nonatomic) BOOL need_confirm;

/**
 免打扰状态
 */
@property (assign, nonatomic) BOOL dnd_enabled;

/**
 群组锁定状态
 */
@property (assign, nonatomic) BOOL locking;

/**
 群组创建类型(平台和终端)
 */
@property (assign, nonatomic) NSInteger creator_type;

/**
 创建时间
 */
@property (assign, nonatomic) NSInteger create_time;

/**
 领队uid
 */
@property (assign, nonatomic) NSInteger group_leader;
/**
 多领队uids
 */
@property (strong, nonatomic) NSArray <NSString *>*group_leaders;
/**
 缓存时的当前用户(用于LastGroup缓存时用)
 */
@property (copy, nonatomic) NSString *cache_uid;

/**
 单呼→发起者
 */
@property (copy, nonatomic) NSString *session_inviter;

/**
 单呼群组→状态
 */
@property (assign, nonatomic) CMCC_SESSION_GROUP_STATUS session_status;
/**
 临时群组→response
 */
@property (assign, nonatomic) CMCC_SESSION_RESPONSE_REASON session_response;
/**
 urgency_level 0 单工 1双工 10 sos
 */
@property (assign, nonatomic) NSInteger custom_attr;
/**
 //时间秒（无值或者0表示普通永久群组，>0时表示到期的时间）
 */
@property (assign, nonatomic) NSInteger group_expire;
#pragma mark --------UI→附加参-----------
/**
 是否是当前群组
 */
@property (assign, nonatomic) BOOL is_current_group;

/**
 创建者是否是当前用户
 */
@property (assign, nonatomic) BOOL is_creator;

/**
 是否是置顶群组
 */
@property (assign, nonatomic) BOOL is_stick_group;

/**
 群组置顶时间(必须为置顶群组才有 仅在UI侧 群组列表中赋值)
 */
@property (copy, nonatomic) NSString *stick_time;

/**
 加入此群组的时间(本地首次缓存时间)
 */
@property (copy, nonatomic) NSString *join_time;

/**
 最后活跃时间(判断是否有未读消息)
 */
@property (copy, nonatomic) NSString *last_active_time;

/**
 是否有未读消息
 */
@property (assign, nonatomic) BOOL has_unread;

/**
 群最后消息用户名称
 */
@property (copy, nonatomic) NSString *last_speak_name;

/**
 是否是新加入的群组(isNew角标)
 */
@property (assign, nonatomic) BOOL is_new;

/**
 群组搜索→关键字
 */
@property (copy, nonatomic) NSString *search_keyword;

/**
 选中状态(UITableViewCell中依赖此值缓存 选中状态)
 */
@property (assign, nonatomic) BOOL selected;

/**
 最后一条历史消息事件(群组管理页面→最近活跃时间)
 */
@property (copy, nonatomic) NSString *last_historymsg_time;

/**
 全双工 语音接听时间 双工开始
 */
@property (copy, nonatomic) NSString *sessionBeginTime;

/**
 终端类型0 app >=1 各自定义
 */
@property (assign, nonatomic) NSInteger terminal_type;

/**
 是否被监听中
 */
@property (assign, nonatomic) BOOL isMonitored;
/**
 是否分享位置至群组
 */
@property (assign, nonatomic) BOOL isShareLocation;

@end

NS_ASSUME_NONNULL_END
