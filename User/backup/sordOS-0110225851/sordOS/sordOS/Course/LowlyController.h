







#import <UIKit/UIKit.h>

@interface LowlyController : UIViewController

UIKIT_EXTERN NSNotificationName const RegisterNotification;
UIKIT_EXTERN NSNotificationName const CardBindNotification;

- (instancetype)initClass;

- (void)enableIQKeyBoard;
- (void)disableIQKeyBoard;

- (void)dismissViewController:(NSString *)controllerName;


@end

