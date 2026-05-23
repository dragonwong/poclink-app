//
//  CmccSessionStop.h
//  CmccSDK
//
//  Created by YANG DONG on 2021/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccSessionStop : NSObject
/**
 群组id
 */
@property (copy, nonatomic) NSString *gid;

/**
 用户id
 */
@property (copy, nonatomic) NSString *uid;

/**
 原因
 */
@property (assign, nonatomic) int reason;
/**

 */
@property (assign, nonatomic) CMCC_SESSION_STOP_REASON status;
@end

NS_ASSUME_NONNULL_END
