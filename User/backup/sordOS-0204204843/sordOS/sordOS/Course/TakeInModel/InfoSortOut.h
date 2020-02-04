







#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define JTId @"52"
UIKIT_EXTERN NSNotificationName const LoginNotification;
UIKIT_EXTERN NSNotificationName const LogoutNotification;


@protocol InfoSortOutDelegate <NSObject>

@required
- (void)appleBuySuccess;
- (void)appleBuyFailure;

@end

@interface InfoSortOut : NSObject 

+ (instancetype) standardInfo;


- (void)loginInfoWithPlanId:(NSString *)planId etc:(NSString *)etc number:(NSString *)number planName:(NSString *)planName zoneId:(NSString *)zoneId delegate:(id<InfoSortOutDelegate>)InfoSortOutDelegate;

- (void)dataReportWithType:(NSString *)type serId:(NSString *)serId serName:(NSString *)serName roleName:(NSString *)roleName roleLevel:(NSString *)roleLevel roleId:(NSString *)roleId number:(NSString *)number uId:(NSString *)uId;

- (void)playWithId:(NSString *)Id key:(NSString *)key;

- (void)loginController;



- (void)gameEntrance;

- (void)inAppPurchase:(NSArray *)id_array;



@end


