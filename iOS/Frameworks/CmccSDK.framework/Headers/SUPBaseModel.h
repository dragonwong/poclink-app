//
//  SUPBaseModel.h
//  SUPER-PTT
//
//  Created by broad on 2024/11/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SUPBaseModel : NSObject

@property(nonatomic,assign) NSInteger code;

@property(nonatomic,assign) NSInteger count;

@property(nonatomic,copy) NSString *msg;

@property(nonatomic,strong) id data;

@end

NS_ASSUME_NONNULL_END
