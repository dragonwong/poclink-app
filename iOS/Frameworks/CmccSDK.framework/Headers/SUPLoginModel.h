//
//  SUPLoginModel.h
//  CmccSDK
//
//  Created by broad on 2025/10/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SUPLoginModel : NSObject

@property(nonatomic,copy) NSString *token;

@property(nonatomic,copy) NSString *account;
//token有效期
@property(nonatomic,assign) NSInteger effectiveTime;
//区域id
@property(nonatomic,assign) NSInteger regionId;
@end

NS_ASSUME_NONNULL_END
