//
//  CmccHistoryMesBase.h
//  CmccSDK
//
//  Created by YANG DONG on 2021/8/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccHistoryMesBase : NSObject
/**
 消息id
 */
@property (copy, nonatomic) NSString *history_id;

/**
 mid
 */
@property (copy, nonatomic) NSString *mid;

/**
 消息类型 消息类型：1 TXT, 2 PIC,  3 AUDIO, 4 LOC,5 info邀请进组消息通知信息,6 token进组,7离组;8 转让群组
 */
@property (copy, nonatomic) NSString *msgType;

/**
 json
 */
@property (strong, nonatomic) NSDictionary *body;

/**
 消息时间
 */
@property (copy, nonatomic) NSString *msgTime;

/**
 发送者
 */
@property (copy, nonatomic) NSString *sender;

/**
 接收者
 */
@property (copy, nonatomic) NSString *receiver;

/**
 接受者类型 接收者类型：1 GROUP, 2 MEMBER
 */
@property (copy, nonatomic) NSString *receiverType;

#pragma mark --------UI→附加参-----------
/**
 历史消息显示文字(UI层计算显示)
 */
@property (copy, nonatomic) NSString *show_str;

/**
 发送者对应member
 */
@property (strong, nonatomic) CmccMember *member;

/**
 cell行高
 */
@property (assign, nonatomic) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
