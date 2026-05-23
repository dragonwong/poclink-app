//
//  CmccHistoryMesVoice.h
//  CmccSDK
//
//  Created by YANG DONG on 2021/8/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccHistoryMesVoice : NSObject
/**
 会话id
 */
@property (copy, nonatomic) NSString *sid;

/**
 群组id
 */
@property (copy, nonatomic) NSString *gid;

/**
 用户id
 */
@property (copy, nonatomic) NSString *uid;

/**
 开始时间
 */
@property (copy, nonatomic) NSString *startTime;

/**
 结束时间
 */
@property (copy, nonatomic) NSString *stopTime;

/**
 播放所需
 */
@property (copy, nonatomic) NSString *payload;

/**
 语音时长
 */
@property (assign, nonatomic) int duration;

@end

NS_ASSUME_NONNULL_END
