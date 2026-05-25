//
//  CmccUserServiceModel.h
//  CmccSDK
//
//  Created by broad on 2025/6/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccUserServiceModel : NSObject
//1:full_duplex,2:create_group 3join_group 4 temp_call 5 sos警报音开关
@property(nonatomic,assign) NSInteger serviceType;

@property(nonatomic,assign) BOOL isOpen;

@end

NS_ASSUME_NONNULL_END
