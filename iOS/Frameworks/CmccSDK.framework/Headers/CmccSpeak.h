//
//  CmccSpeak.h
//  CmccSDK
//
//  Created by YANG DONG on 2021/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccSpeak : NSObject
/**
 群组id
 */
@property (copy, nonatomic) NSString *gid;

/**
 群组名 有可能为NULL
 */
@property (copy, nonatomic) NSString *group_name;

/**
 用户id
 */
@property (copy, nonatomic) NSString *uid;

/**
 用户名 有可能为NULL
 */
@property (copy, nonatomic) NSString *user_name;

/**
 是否可以被打断
 */
@property (assign, nonatomic) BOOL interruptable;

/**
 会话id
 */
@property (copy, nonatomic) NSString *sid;

/**
 会话时长(目前只有LostMic通知时 会有值)
 */
@property (assign, nonatomic) NSInteger talk_time_length;

/**
 类型-0:普通会话 1:群公告
 */
@property (nonatomic, assign) int type;


#pragma mark 附加参数
/**
 收到第一个语音包的时间
 */
@property (nonatomic, assign) long receive_lib_time;
/**
 是否是在当前群组中讲话
 */
@property (assign, nonatomic) BOOL isCurrentGroup;
/**
 是否是自己
 */
@property (assign, nonatomic) BOOL isMyself;
@end

NS_ASSUME_NONNULL_END
