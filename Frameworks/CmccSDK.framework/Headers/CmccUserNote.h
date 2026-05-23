//
//  CmccUserNote.h
//  CmccSDK
//
//  Created by YANG DONG on 2021/4/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccUserNote : NSObject
/**
 用户id
 */
@property (copy, nonatomic) NSString *uid;

/**
 用户备注
 */
@property (copy, nonatomic) NSString *note;

@end

NS_ASSUME_NONNULL_END
