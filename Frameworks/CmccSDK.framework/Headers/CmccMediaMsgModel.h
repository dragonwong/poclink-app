//
//  CmccMediaMsgModel.h
//  CmccSDK
//
//  Created by YANG DONG on 2022/11/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CmccMediaMsgData,CmccMediaMsgParas;
@interface CmccMediaMsgModel : NSObject

/**
 消息体
 */
@property (strong, nonatomic) CmccMediaMsgData *data;

/**
 消息id
 */
@property (copy, nonatomic) NSString *msg_Id;

/**
 服务类型
 */
@property (copy, nonatomic) NSString *serviceType;

/**
 类型
 */
@property (copy, nonatomic) NSString *type;

/**
 消息类型
 */
@property (copy, nonatomic) NSString *msgType;

@end

@interface CmccMediaMsgData : NSObject

/**
 账号
 */
@property (copy, nonatomic) NSString *userAcct;

/**
 未读条数
 */
@property (assign, nonatomic) NSInteger unreadCount;

/**
 服务
 */
@property (copy, nonatomic) NSString *server;

/**
 消息类型
 */
@property (copy, nonatomic) NSString *msgType;

/**
 标题
 */
@property (copy, nonatomic) NSString *title;

/**
 发送时间
 */
@property (copy, nonatomic) NSString *sendTime;

/**
 是否已读
 */
@property (assign, nonatomic) BOOL readed;

/**
 事件id
 */
@property (copy, nonatomic) NSString *targetId;

/**
 时长
 */
@property (assign, nonatomic) NSInteger duration;

/**
 消息接受id
 */
@property (copy, nonatomic) NSString *tbMessageRecordId;

/**
 路径
 */
@property (copy, nonatomic) NSString *path;

/**
 子路径
 */
@property (copy, nonatomic) NSString *sPath;

/**
 结束时间
 */
@property (copy, nonatomic) NSString *endTime;

/**
 isCollect
 */
@property (assign, nonatomic) BOOL isCollect;

/**
 消息资源列表
 */
@property (copy, nonatomic) NSString *msgResourceList;

/**
 mMsgId
 */
@property (copy, nonatomic) NSString *mMsgId;

/**
 readCount
 */
@property (assign, nonatomic) NSInteger readCount;

/**
 tId
 */
@property (copy, nonatomic) NSString *tId;

/**
 uuid
 */
@property (copy, nonatomic) NSString *msgUUID;

/**
 发送者名称
 */
@property (copy, nonatomic) NSString *userName;

/**
 targetType
 */
@property (copy, nonatomic) NSString *targetType;

/**
 remark
 */
@property (copy, nonatomic) NSString *remark;

/**
 msgParas
 */
@property (strong, nonatomic) CmccMediaMsgParas *msgParas;

/**
 消息
 */
@property (copy, nonatomic) NSString *msg;

/**
 发送者uid
 */
@property (copy, nonatomic) NSString *userId;

/**
 敏感审核结果(文字0 失败，1成功)
 */
@property (assign, nonatomic) NSInteger checkResult;

#pragma mark --------UI→附加参-----------
/**
 发送失败
 */
@property (assign, nonatomic) BOOL sendFailure;

/**
 文件大小
 */
@property (strong, nonatomic) NSNumber *filesize;

/**
 视频第一帧图片url
 */
@property (strong, nonatomic) NSString *videoImgUrl;

@end

@interface CmccMediaMsgParas : NSObject

/**
 文件大小
 */
@property (nonatomic, assign) NSInteger file_size;

@end



NS_ASSUME_NONNULL_END
