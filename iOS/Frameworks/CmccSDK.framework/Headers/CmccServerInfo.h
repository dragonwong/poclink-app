//
//  CmccServerInfo.h
//  CmccSDK
//
//  Created by broad on 2025/11/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccServerInfo : NSObject

@property(nonatomic,copy) NSString *server_name;
@property(nonatomic,copy) NSString *domain;
@property(nonatomic,assign) NSInteger ip;
@property(nonatomic,assign) NSInteger port;

@end

NS_ASSUME_NONNULL_END
