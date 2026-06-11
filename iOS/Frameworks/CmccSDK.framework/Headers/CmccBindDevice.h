//
//  CmccBindDevice.h
//  CmccSDK
//
//  Created by broad on 2024/12/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccBindDevice : NSObject
/**
 0 bind
 1 delete
 */
@property(nonatomic,assign) int type;
/**
app账号
 */
@property(nonatomic,copy) NSString *app_account;
/**
 设备账号
 */
@property(nonatomic,copy) NSString *dev_account;

@end

NS_ASSUME_NONNULL_END
