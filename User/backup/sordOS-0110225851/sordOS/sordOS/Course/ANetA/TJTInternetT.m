







#import "TJTInternetT.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "ToastHUD.h"

@implementation TJTInternetT

+ (instancetype)shareInternet{
    static TJTInternetT *internet = nil;
          static dispatch_once_t onceToken;
          dispatch_once(&onceToken, ^{
              internet = [[super allocWithZone:NULL] init];
          });
          return internet;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [TJTInternetT shareInternet];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [TJTInternetT shareInternet];
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [TJTInternetT shareInternet];
}

- (void)requestPost:(NSString *)str json:(BOOL)json body:(NSDictionary *)body hud:(BOOL)hud toast:(BOOL)toast success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    
    
    AFHTTPSessionManager *session = [self AFNetHttpSessionSettingWithJson:json];
    
    id encrytptBody = [self encryptWithBody:body];
    
    if (hud) {
        [ToastHUD show:nil Interaction:NO];
    }
    
    [session POST:str parameters:encrytptBody headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (hud) {
            [ToastHUD dismiss];
        }
        
        [self checkRepsonse:responseObject taost:toast success:successBlock failure:failureBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (hud) {
            [ToastHUD dismiss];
        }
        
        if (failureBlock) {
            failureBlock(error);
        }
        
    }];
    
}

- (void)requestClearPost:(NSString *)str json:(BOOL)json body:(NSDictionary *)body hud:(BOOL)hud success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    
    AFHTTPSessionManager *session = [self AFNetHttpSessionSettingWithJson:json];
    
    id encrytptBody =body; ;
    
    if (hud) {
        [ToastHUD show:nil Interaction:NO];
    }
    
    [session POST:str parameters:encrytptBody headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *reponseDic = [self convertDicFromEncryptData:responseObject];
        if (hud) {
            [ToastHUD dismiss];
        }
        
        if (successBlock) {
            successBlock(reponseDic);
        }
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (hud) {
            [ToastHUD dismiss];
        }
        
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
    
    
}

- (NSDictionary *)convertDicFromEncryptData:(id)response{

    NSDictionary *reponseDic  = @"".JSONObject;
    return reponseDic;
}

- (void)checkRepsonse:(id)response taost:(BOOL)toast success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    
    NSDictionary *reponseDic = [self convertDicFromEncryptData:response];
    
    BOOL stauts = [self requestSuccess:reponseDic];
    
    
    
    NSString *toast_msg = [reponseDic objectForKey:@"extend"];
    
    if (!stauts){ 
        
        if (toast) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ToastHUD showError:toast_msg];
            });
        }
        if (failureBlock) {
            NSError *error = [NSError errorWithReponse:reponseDic];
            failureBlock(error);
        }
    } else {
        if (toast) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ToastHUD showSuccess:toast_msg];
            });
        }
        
        if (successBlock) {
            successBlock(reponseDic);
        }
    }
}

- (id)encryptWithBody:(NSDictionary *)body{
    NSString *jsonStr = [body jsonStringEncoded];
    NSString *base64EncryptStr = @"";;
    return base64EncryptStr;
}

- (void)taskHud:(BOOL)hud task:(NSURLSessionTask *)task{
    if (hud) {
        UIActivityIndicatorView *hudView = [[UIActivityIndicatorView  alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        hudView.center = CGPointMake(kScreen_Width/2, kScreen_Height/2);
        [[UIApplication sharedApplication].delegate.window addSubview:hudView];
        [hudView setAnimatingWithStateOfTask:task];
    }
}

- (AFHTTPSessionManager *)AFNetHttpSessionSettingWithJson:(BOOL)json{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    if (json) {
        manager.requestSerializer                 = [AFJSONRequestSerializer serializer];
    }
    manager.responseSerializer                = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = TIMEOUT;

    return manager;
}

- (BOOL)requestSuccess:(NSDictionary*)response
{
    int status = [(NSNumber *)[response objectForKey:@"source"] intValue];
    return status == 1 ? YES : NO;
}

@end
