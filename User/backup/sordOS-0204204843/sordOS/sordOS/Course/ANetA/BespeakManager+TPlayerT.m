







#import "BespeakManager+TPlayerT.h"
#import "LoginService.h"

@implementation BespeakManager (TPlayerT)

- (void)getAccountOnlineSuccess:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    NSMutableDictionary *body = [[CRequestModelC requsetModel] publicParameter];
    [body setValue:@"5" forKey:@"module"];
    [body setValue:@"hint" forKey:@"sink"];
    [[TJTInternetT shareInternet] requestPost:[AuditSystemToolBox shareBox].placeString json:NO body:body hud:NO toast:NO success:successBlock failure:failureBlock];
}

- (void)registerWithName:(NSString *)name password:(NSString *)password successBlock:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    NSMutableDictionary *body = [[CRequestModelC requsetModel] publicParameter];
     

    [[TJTInternetT shareInternet] requestPost:[AuditSystemToolBox shareBox].placeString json:NO body:body hud:YES toast:YES success:successBlock failure:failureBlock];
}

- (void)signInWithName:(NSString *)name paswword:(NSString *)password successBlock:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    NSMutableDictionary *body = [[CRequestModelC requsetModel] publicParameter];

    [[TJTInternetT shareInternet] requestPost:[AuditSystemToolBox shareBox].placeString json:NO body:body hud:YES toast:NO success:^(NSDictionary *repsonse) {
        
        [[NSUserDefaults standardUserDefaults] setValue:name forKey:@"lastName"];
        [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"lastPassword"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[LoginService loginService] loginSetUser:repsonse];
        if (successBlock) {
            successBlock(repsonse);
        }
        
    } failure:failureBlock];
}

- (void)signOutSuccess:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    NSMutableDictionary *body = [[CRequestModelC requsetModel] publicParameter];

    [[TJTInternetT shareInternet] requestPost:[AuditSystemToolBox shareBox].placeString json:NO body:body hud:YES toast:NO success:^(NSDictionary *repsonse) {
        
        [[LoginService loginService] clearLoginInfomation];
        if (successBlock) {
            successBlock(repsonse);
        }
        
    } failure:failureBlock];
}

- (void)numberRegisterGetCode:(NSString *)number success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    NSMutableDictionary *body = [[CRequestModelC requsetModel] publicParameter];

    [[TJTInternetT shareInternet] requestPost:[AuditSystemToolBox shareBox].placeString json:NO body:body hud:NO toast:YES success:successBlock failure:failureBlock];
}

- (void)numberRegisterWithId:(NSString *)Id code:(NSString *)code password:(NSString *)password success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *operaion1 = [NSBlockOperation blockOperationWithBlock:^{
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [self numberRegisterVerifyCode:code Id:Id success:^(NSDictionary *repsonse) {
            
            dispatch_semaphore_signal(sema);
            
        } failure:^(NSError *error) {
            
            [queue cancelAllOperations];
            dispatch_semaphore_signal(sema);
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [self numerRegisterConfirmWithPassword:password code:code Id:Id success:^(NSDictionary *repsonse) {
            
            dispatch_semaphore_signal(sema);
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (successBlock) {
                    successBlock(repsonse);
                }
            }];
        } failure:^(NSError *error) {
            
            [queue cancelAllOperations];
            dispatch_semaphore_signal(sema);
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }];
    
    [operation2 addDependency:operaion1];
    [queue addOperations:@[operaion1,operation2] waitUntilFinished:nil];
}

- (void)numberRegisterVerifyCode:(NSString *)code Id:(NSString *)Id success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    
    NSMutableDictionary *body = [[CRequestModelC requsetModel] publicParameter];

    [[TJTInternetT shareInternet] requestPost:[AuditSystemToolBox shareBox].placeString json:NO body:body hud:NO toast:NO success:successBlock failure:failureBlock];
}

- (void)numerRegisterConfirmWithPassword:(NSString *)password code:(NSString *)code Id:(NSString *)Id success:(JTSuccessBlock )successBlock failure:(JTFailureBlock)failureBlock{
    NSMutableDictionary *body = [[CRequestModelC requsetModel] publicParameter];

    [[TJTInternetT shareInternet] requestPost:[AuditSystemToolBox shareBox].placeString json:NO body:body hud:NO toast:NO success:successBlock failure:failureBlock];
}


@end
