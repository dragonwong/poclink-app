//
//  CmccDevGroupChanged.h
//  CmccSDK
//
//  Created by broad on 2025/4/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccDevGroupChanged : NSObject

//变化设备的uid
@property(nonatomic,assign) NSInteger uid;

@property (strong, nonatomic) NSArray <NSString *> *rm_gids;

@property (strong, nonatomic) NSArray <NSString *> *add_gids;

@end

NS_ASSUME_NONNULL_END
