//
//  CmccUserGroups.h
//  CmccSDK
//
//  Created by broad on 2025/1/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccUserGroups : NSObject

@property (copy, nonatomic) NSString *uid;

@property (strong, nonatomic) NSArray <NSString *> *gids;

@property (strong, nonatomic) NSArray <CmccGroup *>*groups;

@end

NS_ASSUME_NONNULL_END
