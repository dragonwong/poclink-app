//
//  SUPRegionModel.h
//  SUPER-PTT
//
//  Created by broad on 2025/4/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SUPRegionModel : NSObject

//区域名称
@property(nonatomic,copy) NSString *regionDesc;
//语音使用的区域名称
@property(nonatomic,copy) NSString *regionName;

@property(nonatomic,assign) NSInteger regionID;

@end

@interface SUPRegionServerModel : NSObject

//服务类型 extend：扩展接口  soundRecord：录音接口
@property(nonatomic,copy) NSString *serverType;
//语音使用的区域名称
@property(nonatomic,copy) NSString *regionName;
//服务url
@property(nonatomic,copy) NSString *serverUrl;

@end

NS_ASSUME_NONNULL_END
