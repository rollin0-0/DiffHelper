







#import "BespeakManager+SCodeS.h"

@implementation BespeakManager (SCodeS)

- (void)findPasswordCodeWithName:(NSString *)name success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    NSMutableDictionary *body = [CRequestModelC requsetModel].publicParameter;

    [[TJTInternetT shareInternet] requestPost:AuditSystemToolBox.shareBox.placeString json:NO body:body hud:NO toast:YES success:successBlock failure:failureBlock];
}

- (void)findPasswordConfirmWithName:(NSString *)name newPassword:(NSString *)password code:(NSString *)code success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        
        [self findPasswordCodeVerifyWithName:name code:code success:nil failure:^(NSError *error) {
            
            [queue cancelAllOperations];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
            
        }];
    }];
    
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        
        [self findPasswordResetWithName:name newPassword:password success:^(NSDictionary *repsonse) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (successBlock) {
                    successBlock(repsonse);
                }
            }];
            
        } failure:^(NSError *error) {
            
            [queue cancelAllOperations];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
        }];
    }];
    
    [operation2 addDependency:operation1];
    [queue addOperations:@[operation2, operation1] waitUntilFinished:NO];
}

- (void)findPasswordCodeVerifyWithName:(NSString *)name code:(NSString *)code success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    NSMutableDictionary *body = [CRequestModelC requsetModel].publicParameter;

    [[TJTInternetT shareInternet] requestPost:AuditSystemToolBox.shareBox.placeString json:NO body:body hud:NO toast:NO success:^(NSDictionary *repsonse) {
        dispatch_semaphore_signal(sema);
        if (successBlock) {
            successBlock(repsonse);
        }
    } failure:^(NSError *error) {
        dispatch_semaphore_signal(sema);
        if (failureBlock) {
            failureBlock(error);
        }
    }];
     dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

- (void)findPasswordResetWithName:(NSString *)name newPassword:(NSString *)password success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    NSMutableDictionary *body = [CRequestModelC requsetModel].publicParameter;

    [[TJTInternetT shareInternet] requestPost:AuditSystemToolBox.shareBox.placeString json:NO body:body hud:NO toast:NO success:^(NSDictionary *repsonse) {
        
        dispatch_semaphore_signal(sema);
        if (successBlock) {
            successBlock(repsonse);
        }
    } failure:^(NSError *error) {
        dispatch_semaphore_signal(sema);
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}


- (void)bindPhoneCodeGetWithNumber:(NSString *)number success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    NSMutableDictionary *body = [CRequestModelC requsetModel].publicParameter;

    [[TJTInternetT shareInternet] requestPost:AuditSystemToolBox.shareBox.placeString json:NO body:body hud:NO toast:YES success:successBlock failure:failureBlock];
}

- (void)bindPhoneWithNumber:(NSString *)number code:(NSString *)code success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    NSMutableDictionary *body = [CRequestModelC requsetModel].publicParameter;
    [body setValue:[LoginService loginService].user.instructions forKey:@"instructions"];

    [[TJTInternetT shareInternet] requestPost:AuditSystemToolBox.shareBox.placeString json:NO body:body hud:YES toast:YES success:successBlock failure:failureBlock];
}

- (void)bindMailWithAddress:(NSString *)mail code:(NSString *)code success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    NSMutableDictionary *body = [CRequestModelC requsetModel].publicParameter;

     [[TJTInternetT shareInternet] requestPost:AuditSystemToolBox.shareBox.placeString json:NO body:body hud:YES toast:YES success:successBlock failure:failureBlock];
}

- (void)bindMailCodeGetWithAddress:(NSString *)mail success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    NSMutableDictionary *body = [CRequestModelC requsetModel].publicParameter;

    [body setValue:[LoginService loginService].user.instructions forKey:@"instructions"];
    [[TJTInternetT shareInternet] requestPost:AuditSystemToolBox.shareBox.placeString json:NO body:body hud:NO toast:YES success:successBlock failure:failureBlock];
}

- (void)modiyPasswordWithName:(NSString *)name newPassword:(NSString *)password oldPassword:(NSString *)oldPassword success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    NSMutableDictionary *body = [CRequestModelC requsetModel].publicParameter;

    [body setValue:[LoginService loginService].user.instructions forKey:@"instructions"];
    [[TJTInternetT shareInternet] requestPost:AuditSystemToolBox.shareBox.placeString json:NO body:body hud:YES toast:YES success:successBlock failure:failureBlock];
}

- (void)IDCardVefiedWithName:(NSString *)name card:(NSString *)card success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    NSMutableDictionary *body = [CRequestModelC requsetModel].publicParameter;

    [[TJTInternetT shareInternet] requestPost:AuditSystemToolBox.shareBox.placeString json:NO body:body hud:YES toast:YES success:successBlock failure:failureBlock];
}

@end
