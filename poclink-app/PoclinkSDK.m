#import "PoclinkSDK.h"
#import <CmccSDK/CmccSDK.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation PoclinkSDK

RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(getNativeApiVersion:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
  resolve(@"0.1.0");
}

RCT_EXPORT_METHOD(checkAccount:(NSString *)account
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [SUPSDK_M PostIsExistAccount:account callBack:^(NSURLSessionDataTask * _Nonnull task, SUPBaseModel * _Nullable model, NSString * _Nullable errorStr) {
    dispatch_async(dispatch_get_main_queue(), ^{
      if (errorStr) {
        reject(@"POCLINK_CHECK_ACCOUNT_FAILED", errorStr, nil);
        return;
      }

      resolve(@{
        @"success": @(YES),
        @"code": @(model.code),
        @"count": @(model.count),
        @"message": model.msg ?: @"",
      });
    });
  }];
}

RCT_EXPORT_METHOD(getServiceUrl:(NSString *)account
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [SUPSDK_M GetServiceUrlWithAccount:account callBack:^(NSURLSessionDataTask * _Nonnull task, NSArray<SUPRegionServerModel *> * _Nullable modelsArr, NSString * _Nullable errorStr) {
    dispatch_async(dispatch_get_main_queue(), ^{
      if (errorStr) {
        reject(@"POCLINK_SERVICE_URL_FAILED", errorStr, nil);
        return;
      }

      NSMutableArray *urls = [NSMutableArray array];
      for (SUPRegionServerModel *model in modelsArr) {
        [urls addObject:@{
          @"serverType": model.serverType ?: @"",
          @"regionName": model.regionName ?: @"",
          @"serverUrl": model.serverUrl ?: @"",
        }];
      }
      resolve(@{@"urls": urls});
    });
  }];
}

RCT_EXPORT_METHOD(setExtendAndSoundRecordUrls:(NSString *)extendUrl
                  soundRecordUrl:(NSString *)soundRecordUrl
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [SUPSDK_M setExtendUrl:extendUrl ?: @"" soundRecord:soundRecordUrl ?: @""];
  resolve(@{@"success": @(YES)});
}

RCT_EXPORT_METHOD(emailLogin:(NSString *)account
                  password:(NSString *)password
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [SUPSDK_M PostLoginWithAccount:account type:0 password:password code:nil callBack:^(NSURLSessionDataTask * _Nonnull task, SUPLoginModel * _Nullable model, NSString * _Nullable errorStr) {
    dispatch_async(dispatch_get_main_queue(), ^{
      if (!model || errorStr) {
        reject(@"POCLINK_EMAIL_LOGIN_FAILED", errorStr ?: @"邮箱登录失败", nil);
        return;
      }

      resolve(@{
        @"success": @(YES),
        @"account": model.account ?: @"",
        @"regionId": @(model.regionId),
        @"effectiveTime": @(model.effectiveTime),
        @"token": model.token ?: @"",
        @"message": @"登录成功",
      });
    });
  }];
}

RCT_EXPORT_METHOD(googleAuth:(NSString *)idToken
                  email:(NSString *)email
                  name:(NSString *)name
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [SUPSDK_M PostAuthWithIdToken:idToken type:3 email:email name:name callBack:^(NSURLSessionDataTask * _Nonnull task, SUPLoginModel * _Nullable model, NSString * _Nullable errorStr) {
    dispatch_async(dispatch_get_main_queue(), ^{
      if (!model || errorStr) {
        reject(@"POCLINK_GOOGLE_AUTH_FAILED", errorStr ?: @"Google 登录失败", nil);
        return;
      }

      resolve(@{
        @"success": @(YES),
        @"account": model.account ?: @"",
        @"regionId": @(model.regionId),
        @"effectiveTime": @(model.effectiveTime),
        @"token": model.token ?: @"",
        @"message": @"登录成功",
      });
    });
  }];
}

RCT_EXPORT_METHOD(voiceLogin:(NSString *)account
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  int result = [SUPSDK_M login_account:account password:@"1" type:0];
  if (result == 0) {
    resolve(@{@"success": @(YES), @"code": @(result), @"message": @"语音服务登录成功"});
  } else {
    reject(@"POCLINK_VOICE_LOGIN_FAILED", [NSString stringWithFormat:@"语音服务登录失败: %d", result], nil);
  }
}

RCT_EXPORT_METHOD(getCurrentUser:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  CmccUser *user = [SUPSDK_M get_current_user];
  if (!user) {
    resolve([NSNull null]);
    return;
  }

  resolve(@{
    @"uid": user.uid ?: @"",
    @"name": user.name ?: @"",
    @"account": user.account ?: @"",
  });
}

RCT_EXPORT_METHOD(getCurrentGroup:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  CmccGroup *group = [SUPSDK_M get_current_group];
  if (!group) {
    resolve([NSNull null]);
    return;
  }

  resolve(@{
    @"gid": group.gid ?: @"",
    @"name": group.name ?: @"",
  });
}

RCT_EXPORT_METHOD(joinGroup:(NSString *)gid
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  int result = [SUPSDK_M join_group_gid:gid contact_id:nil token:nil is_limit:@"0"];
  resolve(@{@"code": @(result), @"success": @(result == 0)});
}

RCT_EXPORT_METHOD(startSpeak:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  int result = [SUPSDK_M start_speak:NO];
  if (result == 0) {
    resolve(@{@"code": @(result), @"success": @(YES)});
  } else {
    reject(@"POCLINK_START_SPEAK_FAILED", [NSString stringWithFormat:@"无法讲话: %d", result], nil);
  }
}

RCT_EXPORT_METHOD(stopSpeak:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  [SUPSDK_M stop_speak];
  resolve(@{@"success": @(YES)});
}

@end
