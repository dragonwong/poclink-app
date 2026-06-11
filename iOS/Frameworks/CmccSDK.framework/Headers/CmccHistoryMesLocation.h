//
//  CmccHistoryMesLocation.h
//  CmccSDK
//
//  Created by YANG DONG on 2021/8/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccHistoryMesLocation : NSObject
/**
 用户id
 */
@property (nonatomic, copy) NSString *uid;

/**
 群组id
 */
@property (nonatomic, copy) NSString *gid;

/**
 纬度
 */
@property (nonatomic, assign) double latitude;

/**
 经度
 */
@property (nonatomic, assign) double longitude;

/**
 时间戳
 */
@property (nonatomic, copy) NSString *time;

/**
 地址
 */
@property (nonatomic, copy) NSString *address;

@end

NS_ASSUME_NONNULL_END
