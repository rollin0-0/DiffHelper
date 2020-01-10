







#import "InfoSortOut.h"
#import "ToastHUD.h"
#import "PrimaryPresentController.h"
#import "CRequestModelC.h"
//#import "TWarperViewControllerT.h"
#import "SubstanceAbuserListController.h"
#import "YAPBManagerY.h"

@interface InfoSortOut ()<EInAppPurchasingDelegate>

@property (nonatomic, strong) NSArray *id_array;
@property (nonatomic, strong) id<InfoSortOutDelegate> InfoSortOutDelegate;

@end

@implementation InfoSortOut

NSNotificationName const LoginNotification      = @"LoginNotification";
NSNotificationName const LogoutNotification     = @"LogoutNotification";

+ (instancetype)standardInfo{
        static InfoSortOut *tupe = nil;
       static dispatch_once_t onceToken;
       dispatch_once(&onceToken, ^{
           tupe = [[super allocWithZone:NULL] init];
       });
       return tupe;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [InfoSortOut standardInfo];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [InfoSortOut standardInfo];
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [InfoSortOut standardInfo];
}

- (void)playWithId:(NSString *)Id key:(NSString *)key{
    [[BespeakManager defaultManager] installationRecordWithId:Id key:key];
    [[BespeakManager defaultManager] changeDifferentPlace];
}

- (void)loginController{
    UIViewController *controller = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    PrimaryPresentController *mainController = [[PrimaryPresentController alloc] initClass];
    [controller presentViewController:mainController animated:NO completion:nil];
    
}

- (void)gameEntrance{
    
}

- (void)loginInfoWithPlanId:(NSString *)planId etc:(NSString *)etc number:(NSString *)number planName:(NSString *)planName zoneId:(NSString *)zoneId delegate:(id<InfoSortOutDelegate>)InfoSortOutDelegate{
    
    self.InfoSortOutDelegate = InfoSortOutDelegate;
    
    NSMutableDictionary *body = [NSMutableDictionary dictionary];

    
    OnceModel *model = [OnceModel defaultModel];
    NSError *error = nil;
    model = [model initWithDictionary:body error:&error];

    
    [[RJTSliderR slider] dismissSlider];
    [[BespeakManager defaultManager] LoginInfoZoneId:zoneId success:^(NSDictionary *repsonse) {
        
        if ([[repsonse objectForKey:@"compared"] intValue] ==1) {
            UIViewController *controller = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
            
            while (controller.presentedViewController){
              controller = controller.presentedViewController;
            }
            SubstanceAbuserListController *listController = [[SubstanceAbuserListController alloc] initClass];
            listController.listDic = repsonse;
            [controller presentViewController:listController animated:NO completion:nil];
        }else{
            
            [self inAppPurchase:@[planId]];
            
        }
        
    } failure:^(NSError *error) {
        [[RJTSliderR slider] showSlider];
        
    }];
}


- (void)dataReportWithType:(NSString *)type serId:(NSString *)serId serName:(NSString *)serName roleName:(NSString *)roleName roleLevel:(NSString *)roleLevel roleId:(NSString *)roleId number:(NSString *)number uId:(NSString *)uId{
    [[BespeakManager defaultManager] dataReportWithType:type serId:serId serName:serName roleName:roleName roleLevel:roleLevel roleId:roleId number:number uId:uId];
}

- (void)inAppPurchase:(NSArray *)id_array{
    [ToastHUD show:nil Interaction:NO];
    self.id_array = id_array;
    [[YAPBManagerY sharedInstance] identifyCanMakePayments:id_array];
    [YAPBManagerY sharedInstance].delegate = self;
}

- (BOOL)isProductIdentifierAvailable:(NSString*)productIdentifier{
    return YES;
}

- (void)updatedTransactions:(EPaymentTransactionState)state{
    
    if (state == EPaymentTransactionStatePurchased || state == EPaymentTransactionStatePurchasing) {
         
    }else{
        [ToastHUD dismiss];
        [[RJTSliderR slider] showSlider];
        if (self.InfoSortOutDelegate &&[self.InfoSortOutDelegate respondsToSelector:@selector(appleBuyFailure)]) {
            [self.InfoSortOutDelegate appleBuyFailure];
        }
    }
}

- (void)buySuccess:(SKPaymentTransaction *)transaction{
    [ToastHUD dismiss];
    [[RJTSliderR slider] showSlider];
    if (self.InfoSortOutDelegate &&[self.InfoSortOutDelegate respondsToSelector:@selector(appleBuySuccess)]) {
        [self.InfoSortOutDelegate appleBuySuccess];
    }
}


@end
