//
//  CmccDeviceMembers.h
//  CmccSDK
//
//  Created by broad on 2025/6/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccDeviceMembers : NSObject

@property(nonatomic,copy) NSString *uid;
@property(nonatomic,copy) NSString *gid;
@property(nonatomic,strong) NSArray <CmccMember *> *members;

@end

NS_ASSUME_NONNULL_END
