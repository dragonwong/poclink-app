//
//  CmccMember.h
//  CmccSDK
//
//  Created by YANG DONG on 2021/4/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccMember : NSObject

/**
 用户id
 */
@property (copy, nonatomic) NSString *uid;

/**
 在组状态
 */
@property (assign, nonatomic) BOOL ingroup;

/**
 成员在群组的昵称
 */
@property (copy, nonatomic) NSString *ingroup_name;

/**
 用户名
 */
@property (strong, nonatomic) CmccUser *user;

/**
 进组时间
 */
@property (assign, nonatomic) NSInteger ingroup_time;

/**
 允许上报位置开关
 */
@property (assign, nonatomic) BOOL report_local;

/**
 是否为管理员
 */
@property (assign, nonatomic) BOOL is_master;

/**
 名称显示规则
 */
@property (copy, nonatomic) NSString *user_show_name;

/**
 是否是当前用户
 */
@property (assign, nonatomic) BOOL isMe;

#pragma mark --------UI→附加参-----------
/**
 选中状态(UITableViewCell中依赖此值缓存 选中状态)
 */
@property (assign, nonatomic) BOOL selected;

@end

NS_ASSUME_NONNULL_END
