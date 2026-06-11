//
//  CmccLogin.h
//  CmccSDK
//
//  Created by YANG DONG on 2021/8/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccLogin : NSObject
/**
 登录token
 */
@property (copy, nonatomic) NSString *token;

/**
 账号
 */
@property (copy, nonatomic) NSString *user_account;

/**
 密码
 */
@property (copy, nonatomic) NSString *user_psw;

/**
 登录类型
 */
@property (assign, nonatomic) int type;

/**
 是否自动登录
 */
@property (assign, nonatomic) BOOL auto_login;

@end

NS_ASSUME_NONNULL_END
