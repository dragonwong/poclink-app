//
//  CmccDeliver.h
//  CmccSDK
//
//  Created by YANG DONG on 2021/7/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccDeliver : NSObject
/**
 发送者uid
 */
@property (copy, nonatomic) NSString *sender;

/**
 gid(仅在:type=FY_DELIVER_TYPE_GROUP有值,可能为nil)
 */
@property (copy, nonatomic) NSString *gid;

/**
 数据流
 */
@property (strong, nonatomic) NSData *data;

/**
 透传类型
 */
@property (assign, nonatomic) CMCC_DELIVER_TYPE type;

/**
 消息名(可能为nil)
 */
@property (copy, nonatomic) NSString *msg_name;

@end

NS_ASSUME_NONNULL_END
