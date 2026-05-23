//
//  CmccRelatedContact.h
//  CmccSDK
//
//  Created by broad on 2025/9/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CmccRelatedContact : NSObject

@property(nonatomic,assign) NSInteger value;
@property(nonatomic,copy) NSString *value_name;
//sos_contact quick_call
@property(nonatomic,copy) NSString *msg_name;

@end



NS_ASSUME_NONNULL_END
