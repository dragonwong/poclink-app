//
//  CmccAckResult.h
//  CmccSDK
//
//  Created by YANG DONG on 2021/7/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccAckResult : NSObject

/**
 返回结果类型
 */
@property (nonatomic, assign) ENUM_CMCC_ACK_TYPE type;

/**
 返回结果状态
 */
@property (nonatomic, assign) ENUM_CMCC_ACK_CODE state;

@end

NS_ASSUME_NONNULL_END
