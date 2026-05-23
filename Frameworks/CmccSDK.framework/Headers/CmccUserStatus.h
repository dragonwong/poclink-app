//
//  CmccUserStatus.h
//  CmccSDK
//
//  Created by broad on 2025/1/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccUserStatus : NSObject

/**
 ONLINE_STATUS_UNKNOWN    = 0,
 ONLINE_STATUS_OFFLINE    = 1,
 ONLINE_STATUS_LOGINING    = 2,
 ONLINE_STATUS_ONLINE    = 3
 */
@property(nonatomic,assign) int result;
/**
 echat_gid_t
 */
@property(nonatomic,copy) NSString *current_gid;

@property(nonatomic,strong) CmccUser *current_user;

@end

NS_ASSUME_NONNULL_END
