







#import "LowlyController.h"
#import "IQKeyboardManager.h"

@interface LowlyController ()

@end

@implementation LowlyController

NSNotificationName const RegisterNotification  = @"RegisterNotification";
NSNotificationName const CardBindNotification  = @"CardBindNotification";

- (instancetype)initClass{
    if (self = [super init]) {
        self = [[self.class alloc] initWithNibName:NSStringFromClass(self.class) bundle:[NSBundle currentBundle]];
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)enableIQKeyBoard{
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

- (void)disableIQKeyBoard{
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)dismissViewController:(NSString *)controllerName{
    
    if (!controllerName) {
        [self dismissViewControllerAnimated:NO completion:nil];
        return;
    }
    
    UIViewController *contoller = self;
    while (contoller.presentingViewController) {
        contoller = contoller.presentingViewController;
        if ([contoller isMemberOfClass:NSClassFromString(controllerName)]) {
            break;
        }
    }
    [contoller dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    [self placeHolderColor];
}

- (void)placeHolderColor{
    [self TraverseAllSubviewsForPlaceHolderColor:self.view];
}


-(void)TraverseAllSubviewsForPlaceHolderColor:(UIView *)view {
    
    for (UIView *subView in view.subviews) {
        
        if ([subView isKindOfClass:[UITextField class]]) {
            UIColor *whiteColor = UIColor.whiteColor;
            UITextField *textField = (UITextField *)subView;
            if (textField.placeholder) {
                textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textField.placeholder attributes:@{NSForegroundColorAttributeName: whiteColor}];
            }
        }
    
        if (subView.subviews.count) {
           [self TraverseAllSubviewsForPlaceHolderColor:subView];
        }
    }
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}


@end
