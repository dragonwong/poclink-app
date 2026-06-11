//
//  SUPGroupAudioModel.h
//  SUPER-PTT
//
//  Created by broad on 2024/11/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SUPGroupAudioModel : NSObject

@property(nonatomic,assign) NSInteger speechId;
@property(nonatomic,copy) NSString *agId;
@property(nonatomic,assign) NSInteger gid;
@property(nonatomic,assign) NSInteger uid;
@property(nonatomic,assign) NSInteger speechType;
@property(nonatomic,assign) NSInteger createAt;
@property(nonatomic,assign) NSInteger payload;
@property(nonatomic,assign) NSInteger milliSecond;
@property(nonatomic,copy) NSString *path;
@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *groupName;
@property(nonatomic,assign) NSInteger tId;
@property(nonatomic,copy) NSString *userName;

@property(nonatomic,assign) BOOL isAppBind;

//录音播放状态
@property(nonatomic,assign) BOOL isPlaying;

@end

NS_ASSUME_NONNULL_END
