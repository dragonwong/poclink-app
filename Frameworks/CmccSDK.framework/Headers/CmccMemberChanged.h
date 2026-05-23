//
//  CmccMemberChanged.h
//  CmccSDK
//
//  Created by YANG DONG on 2021/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccMemberChanged : NSObject
/**
 群组id
 */
@property (copy, nonatomic) NSString *gid;

/**
 新增/更新 成员uid数组
 */
@property (strong, nonatomic) NSArray *update_uids;

/**
 被移除成员uid数组(代表不再是本群成员)
 */
@property (strong, nonatomic) NSArray *remove_uids;

/**
 新进入群组成员
 */
@property (strong, nonatomic) NSArray *join_uids;

/**
 离开群组 成员uid数组
 */
@property (strong, nonatomic) NSArray *left_uids;

/**
 新加入群组 成员uid数组
 */
@property (strong, nonatomic) NSArray *news_uids;

@end

NS_ASSUME_NONNULL_END
