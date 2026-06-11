//
//  CmccContactInviteMsg.h
//  CmccSDK
//
//  Created by YANG DONG on 2021/7/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccContactInviteMsg : NSObject
/**
 消息id
 */
@property (copy, nonatomic) NSString *invite_id;

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
 邀请人信息
 */
@property (strong, nonatomic) CmccUser *inviter;

/**
 被邀请人信息
 */
@property (strong, nonatomic) CmccUser *invitee;

/**
 附加消息 account
 */
@property (copy, nonatomic) NSString *msg;

/**
 消息状态  0 未处理  1同意 2 拒绝
 */
@property (assign, nonatomic) NSInteger msg_type;

/**
 是否未读
 */
@property (assign, nonatomic) BOOL unread;

/**
 是否为发送者
 */
@property (assign, nonatomic) BOOL is_send;

#pragma mark --------UI→附加参-----------
/**
 高度(UITableViewCell 自适应高度)
 */
@property (assign, nonatomic) double rowHeight;

@end

NS_ASSUME_NONNULL_END
