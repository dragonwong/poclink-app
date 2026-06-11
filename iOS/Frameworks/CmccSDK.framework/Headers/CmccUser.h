//
//  CmccUser.h
//  CmccSDK
//
//  Created by YANG DONG on 2021/4/14.
//

#import <Foundation/Foundation.h>
#import "CmccUserServiceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CmccUser : NSObject

/**
 用户id
 */
@property (copy, nonatomic) NSString *uid;

/**
 账号
 */
@property (copy, nonatomic) NSString *account;

/**
 用户名
 */
@property (copy, nonatomic) NSString *name;

/**
 角色状态
 */
@property (assign, nonatomic) BOOL has_role;

/**
 角色
 */
@property (copy, nonatomic) NSString *role;

/**
 在线状态
 ONLINE_STATUS_UNKNOWN    = 0,
 ONLINE_STATUS_OFFLINE    = 1,
 ONLINE_STATUS_LOGINING    = 2,
 ONLINE_STATUS_ONLINE    = 3
 */
@property (assign, nonatomic) NSInteger online;

/**
 群组状态
 */
@property (assign, nonatomic) BOOL has_gid;

/**
 所在组id
 */
@property (copy, nonatomic) NSString *gid;

/**
 头像
 */
@property (copy, nonatomic) NSString *avatar;

/**
 性别
 */
@property (assign, nonatomic) NSInteger sex;

/**
 是否为付费用户
 */
@property (assign, nonatomic) BOOL paid;

/**
 可否讲话
 */
@property (assign, nonatomic) BOOL audio_enabled;

/**
 优先级
 */
@property (assign, nonatomic) NSInteger priority;
/**
 终端类型0 app >=1 各自定义
 */
@property (assign, nonatomic) NSInteger terminal_type;
/**
 ;//单位秒
 */
@property (copy, nonatomic) NSString *location_period;
/**
 ;//开关0 关 1 开
 */ 
@property (copy, nonatomic) NSString *location;

/**
全双工时间限制
 */
@property (assign, nonatomic) NSInteger call_duration;

/**
服务开关
 */
@property (strong, nonatomic) NSArray<CmccUserServiceModel *> *services;

#pragma mark --------UI→附加参-----------
/**
 用户备注
 */
@property (copy, nonatomic) NSString *note;

/**
 姓名缩写→首字母(可能为null)
 */
@property (copy, nonatomic) NSString *initials;

/**
 邀请好友加入群组时 依赖此值 判断该好友是否已进入改组
 */
@property (assign, nonatomic) BOOL invite_joined;

/**
 选中状态(UITableViewCell中依赖此值缓存 选中状态)
 */
@property (assign, nonatomic) BOOL selected;

/**
 终端是否已经被用户绑定
 */
@property (assign, nonatomic) BOOL isAppBind;
@end

NS_ASSUME_NONNULL_END
