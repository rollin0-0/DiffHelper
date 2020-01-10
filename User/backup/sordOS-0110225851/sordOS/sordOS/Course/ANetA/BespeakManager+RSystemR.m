







#import "BespeakManager+RSystemR.h"

@implementation BespeakManager (RSystemR)

- (void)installationRecordWithId:(NSString *)Id key:(NSString *)key{
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    [[CRequestModelC requsetModel] setId:Id];
    [[CRequestModelC requsetModel] setKey:key];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Record"]) {
        return;
    }
    
    NSMutableDictionary *body = [[CRequestModelC requsetModel] publicParameter];

    [[TJTInternetT shareInternet] requestPost:[AuditSystemToolBox shareBox].placeInstallString json:NO body:body hud:NO toast:NO success:^(NSDictionary *repsonse) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Record"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } failure:^(NSError *error) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((10) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self installationRecordWithId:Id key:key];
        });
    }];
}

- (void)changeDifferentPlace{
    NSMutableDictionary *body = [[CRequestModelC requsetModel] publicParameter];
    [body setValue:@"6" forKey:@"module"];
    [[TJTInternetT shareInternet] requestPost:[AuditSystemToolBox shareBox].placeString json:NO body:body hud:NO toast:NO success:^(NSDictionary *repsonse) {
        
        NSString *str1 = [repsonse objectForKey:@"apple"];
        NSString *str2 = [repsonse objectForKey:@"compared"];
        NSString *userProtocol = [repsonse objectForKey:@"userProtocol"];
        NSNumber *owner =[repsonse objectForKey:@"owner"];
        [CRequestModelC requsetModel].owner = owner;
        [CRequestModelC requsetModel].userProtocol = userProtocol;
        [CRequestModelC requsetModel].compared = str2;
        if (str1 && ([str2 integerValue]==1)) {
            [[NSUserDefaults standardUserDefaults] setValue:str1 forKey:@"placeString"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
    } failure:^(NSError *error) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self changeDifferentPlace];
        });
    }];
}

- (void)internetHelpSuccess:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    NSMutableDictionary *body = [[CRequestModelC requsetModel] publicParameter];

    [[TJTInternetT shareInternet] requestPost:[AuditSystemToolBox shareBox].placeString json:NO body:body hud:YES toast:NO success:successBlock failure:failureBlock];
}

- (void)LoginInfoZoneId:(NSString *)zongId success:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    NSMutableDictionary *body = [[CRequestModelC requsetModel] publicParameter];
    [body setValue:[LoginService loginService].user.instructions forKey:@"instructions"];
    [[TJTInternetT shareInternet] requestPost:[AuditSystemToolBox shareBox].placeString json:NO body:body hud:NO toast:NO success:successBlock failure:failureBlock];
}

- (void)newsRequsetWithExtensionBody:(OnceModel *)model successBlock:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{

    NSMutableDictionary *jsonDic = [NSMutableDictionary dictionary];


    
    NSMutableDictionary *body = [[CRequestModelC requsetModel] publicParameter];

    [[TJTInternetT shareInternet] requestPost:[AuditSystemToolBox shareBox].placeString json:NO body:body hud:NO toast:NO success:successBlock failure:failureBlock];
}

- (void)cardEveryDayWithUserDetail:(NSString *)userDetail successBlock:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{
    OnceModel *model = [OnceModel defaultModel];
    NSMutableDictionary *body = [[CRequestModelC requsetModel] publicParameter];

    [[TJTInternetT shareInternet] requestPost:[AuditSystemToolBox shareBox].placeString json:NO body:body hud:NO toast:NO success:successBlock failure:failureBlock];
}

- (void)recheckEveryDayCardWithInfoDic:(OnceModel *)model str:(NSString *)keyString successBlock:(JTSuccessBlock)successBlock failure:(JTFailureBlock)failureBlock{

        
        
    NSMutableDictionary *jd_bodyData = [NSMutableDictionary dictionary];

//
    
    [[TJTInternetT shareInternet] requestClearPost:[AuditSystemToolBox shareBox].placeString json:NO body:jd_bodyData hud:NO success:^(NSDictionary *repsonse) {
        
        if ([[repsonse objectForKey:@"status"]intValue] == 0) {
            [self removeDocumentWithBody:jd_bodyData];
            if (successBlock) {
                successBlock(repsonse);
            }
        }else{
            
            if (failureBlock) {
                failureBlock(nil);
            }
        }
        
    }  failure:failureBlock];
}

- (void)checkLeaksDocument{
    NSMutableArray *userLeaks = [self getUserLeaksDocument];
    if (userLeaks.count==0) {
        return;
    }
    NSInteger count = userLeaks.count;
    NSInteger i = 0;
    for (NSDictionary *body in userLeaks) {
        [self performSelector:@selector(cheakLeaskRequestWithDocument:) withObject:body afterDelay:(i*(TIMEOUT + 1))];
        if (i<=count-1) {
            i++;
        }
    }
}

- (void)cheakLeaskRequestWithDocument:(NSDictionary *)body{
    [[TJTInternetT shareInternet] requestClearPost:[AuditSystemToolBox shareBox].placeString json:NO body:body hud:NO success:^(NSDictionary *repsonse) {
              
        if ([[repsonse objectForKey:@"status"]intValue] == 0) {
            [self removeDocumentWithBody:body];
        }
            
    } failure:^(NSError *error) {
              
    }];
}

- (void)removeDocumentWithBody:(NSDictionary *)body{
    NSMutableArray *userLeaks = [self getUserLeaksDocument];
    [userLeaks enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([body isEqualToDictionary:obj]) {
            [userLeaks removeObject:body];
        }
    }];
    [[NSUserDefaults standardUserDefaults] setObject:userLeaks forKey:LoginService.loginService.user.instructions];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)saveDocumentWithBody:(NSDictionary *)body{
    NSMutableArray *userLeaks = [self getUserLeaksDocument];
    [userLeaks addObject:body];
    [[NSUserDefaults standardUserDefaults] setObject:userLeaks forKey:LoginService.loginService.user.instructions];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSMutableArray *)getUserLeaksDocument{
    NSMutableArray *userLeaks = [[NSUserDefaults standardUserDefaults] objectForKey:LoginService.loginService.user.instructions];
    NSMutableArray *array;
    if (userLeaks) {
        array =  userLeaks.mutableCopy;
    }else{
        array = [NSMutableArray array];
    }
    return array;
}

- (void)dataReportWithType:(NSString *)type serId:(NSString *)serId serName:(NSString *)serName roleName:(NSString *)roleName roleLevel:(NSString *)roleLevel roleId:(NSString *)roleId number:(NSString *)number uId:(NSString *)uId{

    NSMutableDictionary *body = [[CRequestModelC requsetModel] publicParameter];
//
    [[TJTInternetT shareInternet] requestPost:[AuditSystemToolBox shareBox].placeInstallString json:NO body:body hud:NO toast:NO success:^(NSDictionary *repsonse) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
