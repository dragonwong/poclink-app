//
//  CmccGroupInviteMsg.h
//  CmccSDK
//
//  Created by YANG DONG on 2021/7/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccGroupInviteMsg : NSObject

/**
 消息id
 */
@property (copy, nonatomic) NSString *invite_id;

/**
 群组id
 */
@property (copy, nonatomic) NSString *gid;

/**
 群组信息
 */
@property (strong, nonatomic) CmccGroup *chat_group;

/**
 邀请时间戳
 */
@property (copy, nonatomic) NSString *invite_time;

/**
 邀请人 account
 */
@property (copy, nonatomic) NSString *inviter_acc;

/**
 被邀请人 account
 */
@property (copy, nonatomic) NSString *invitee_acc;

/**
 请求者 account
 */
@property (copy, nonatomic) NSString *asker_acc;

/**
 确认者 account
 */
@property (copy, nonatomic) NSString *confirmer_acc;

/**
 邀请人信息
 */
@property (strong, nonatomic) CmccUser *inviter;

/**
 被邀请人信息
 */
@property (strong, nonatomic) CmccUser *invitee;

/**
 请求者
 */
@property (strong, nonatomic) CmccUser *asker;

/**
 确认者
 */
@property (strong, nonatomic) CmccUser *confirmer;

/**
 附加消息
 */
@property (copy, nonatomic) NSString *msg;

/**
 token(token进组申请时有)
 */
@property (copy, nonatomic) NSString *token;

/**
 消息状态
 */
@property (assign, nonatomic) NSInteger msg_type;

/**
 消息类型
 */
@property (assign, nonatomic) NSInteger invite_type;

/**
 是否未读
 */
@property (assign, nonatomic) BOOL unread;

/**
 消息来源(分类)
 */
@property (assign, nonatomic) CMCC_GROUP_INVITE_SOURCE source;

/**
 此消息主要用户id(用作过滤重复消息标识符)
 */
@property (copy, nonatomic) NSString *main_uid;

/**
 是否为发送者
 */
@property (assign, nonatomic) BOOL is_send;

#pragma mark --------UI→附加参-----------
/**
 高度(UITableViewCell 自适应高度)
 */
@property (assign, nonatomic) double rowHeight;

/**
 此消息主要用户
 */
@property (copy, nonatomic) NSString *head_img;

/**
 用作搜索页面 标黄颜色的关键字
 */
@property (copy, nonatomic) NSString *yellow_text;

/**
 邀请消息文字
 */
@property (copy, nonatomic) NSString *show_message;

/**
 邀请消息状态文字
 */
@property (copy, nonatomic) NSString *state_str;

@end

NS_ASSUME_NONNULL_END
