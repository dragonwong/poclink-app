//
//  SUPTerminalModel.h
//  SUPER-PTT
//
//  Created by broad on 2024/11/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface SUPTerminalModel : NSObject

@property(nonatomic,copy) NSString *device_name;
@property(nonatomic,copy) NSString *img;
@property(nonatomic,copy) NSString *User_Name;
@property(nonatomic,assign) NSInteger User_ID;
@property(nonatomic,copy) NSString *User_Account;
@property(nonatomic,assign) NSInteger terminal_type;
@property(nonatomic,assign) NSInteger deviceID;

@property(nonatomic,strong) CmccUser *user;
@end


@interface SUPBindTerminalModel : NSObject
//bind==1时存在 用这个调发送短信接口
@property(nonatomic,copy) NSString *taskId;
//bind==1时存在 用这个调发送短信接口
@property(nonatomic,copy) NSString *phone;
// 0.未绑定，1.已绑定，2.未注册，3.终端类型app,4.已绑定自己 5.无法绑定该终端
@property(nonatomic,assign) NSInteger bind;

@end

NS_ASSUME_NONNULL_END
