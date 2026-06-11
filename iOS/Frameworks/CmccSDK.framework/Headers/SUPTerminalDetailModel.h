//
//  SUPTerminalDetailModel.h
//  SUPER-PTT
//
//  Created by broad on 2024/12/2.
//

#import <Foundation/Foundation.h>
@class SUPLocationModel;
NS_ASSUME_NONNULL_BEGIN

@interface SUPTerminalDetailModel : NSObject
//终端名称
@property(nonatomic,copy) NSString *user_Name;
//终端图片
@property(nonatomic,copy) NSString *img;
//终端位置开关
@property(nonatomic,assign) NSInteger user_GPSswitch;
//最后位置
@property(nonatomic,copy) NSString *address;

@property(nonatomic,assign) NSInteger rTimestamp;

@property(nonatomic,assign) NSInteger sTimestamp;
//位置上报时间间隔
@property(nonatomic,assign) NSInteger user_GPSfrequency;
//电池剩余容量, 百分比，0-100
@property(nonatomic,assign)NSInteger battery;
//运营商
@property(nonatomic,copy) NSString *service;
//运营商名称
@property(nonatomic,copy,readonly) NSString *serviceName;
//终端类型名称
@property(nonatomic,copy) NSString *device_name;

@property(nonatomic,copy) NSString *iccid;
//终端位置共享 0不显示 1显示（传入Cg_ID时）
@property(nonatomic,assign) NSInteger gps_display;
@property(nonatomic,copy) NSString *imei;
//终端id
@property(nonatomic,assign)NSInteger user_ID;
//信号值，0-4, 表示几格信号
@property(nonatomic,assign)NSInteger signal;

@property(nonatomic,strong) SUPLocationModel *baidu;
@property(nonatomic,strong) SUPLocationModel *gcj;
@property(nonatomic,strong) SUPLocationModel *wgs84;

//终端当前群组id
@property(nonatomic,copy) NSString *currentGroupId;

//终端当前群组
@property(nonatomic,strong,nullable)CmccGroup *currentGroup;

//终端user
@property(nonatomic,strong)CmccUser *user;

@end

NS_ASSUME_NONNULL_END
