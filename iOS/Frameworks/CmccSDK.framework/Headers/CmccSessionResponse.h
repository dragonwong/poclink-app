//
//  CmccSessionResponse.h
//  CmccSDK
//
//  Created by YANG DONG on 2021/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccSessionResponse : NSObject
/**
 群组id
 */
@property (copy, nonatomic) NSString *gid;

/**
 用户id
 */
@property (copy, nonatomic) NSString *uid;

/**
 是否同意
 */
@property (assign, nonatomic) BOOL accept;

/**
 原因
 */
@property (assign, nonatomic) int reason;

@end

NS_ASSUME_NONNULL_END
