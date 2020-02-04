






















#import "IQKeyboardManager.h"
#import "IQUIView+Hierarchy.h"
#import "IQUIView+IQKeyboardToolbar.h"
#import "IQNSArray+Sort.h"
#import "IQKeyboardManagerConstantsInternal.h"
#import "IQUIScrollView+Additions.h"
#import "IQUITextFieldView+Additions.h"
#import "IQUIViewController+Additions.h"
#import "IQPreviousNextView.h"

#import <QuartzCore/CABase.h>

#import <objc/runtime.h>

#import <UIKit/UIAlertController.h>
#import <UIKit/UISearchBar.h>
#import <UIKit/UIScreen.h>
#import <UIKit/UINavigationBar.h>
#import <UIKit/UITapGestureRecognizer.h>
#import <UIKit/UITextField.h>
#import <UIKit/UITextView.h>
#import <UIKit/UITableViewController.h>
#import <UIKit/UICollectionViewController.h>
#import <UIKit/UICollectionViewCell.h>
#import <UIKit/UICollectionViewLayout.h>
#import <UIKit/UINavigationController.h>
#import <UIKit/UITouch.h>
#import <UIKit/UIWindow.h>
#import <UIKit/NSLayoutConstraint.h>
#import <UIKit/UIStackView.h>
#import <UIKit/UIAccessibility.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
#import <UIKit/UIWindowScene.h>
#import <UIKit/UIStatusBarManager.h>
#endif

NSInteger const kIQDoneButtonToolbarTag             =   -1002;
NSInteger const kIQPreviousNextButtonToolbarTag     =   -1005;

#define kIQCGPointInvalid CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX)

@interface IQKeyboardManager()<UIGestureRecognizerDelegate>




@property(nonatomic, assign) UIEdgeInsets     startingTextViewContentInsets;


@property(nonatomic, assign) UIEdgeInsets   startingTextViewScrollIndicatorInsets;


@property(nonatomic, assign) BOOL    isTextViewContentInsetChanged;




@property(nullable, nonatomic, weak) UIView       *textFieldView;


@property(nonatomic, assign) CGPoint    topViewBeginOrigin;


@property(nullable, nonatomic, weak) UIViewController *rootViewController;


@property(nullable, nonatomic, weak) UIViewController *rootViewControllerWhilePopGestureRecognizerActive;
@property(nonatomic, assign) CGPoint    topViewBeginOriginWhilePopGestureRecognizerActive;


@property(nonatomic, assign) BOOL   hasPendingAdjustRequest;




@property(nullable, nonatomic, weak) UIScrollView     *lastScrollView;


@property(nonatomic, assign) UIEdgeInsets   startingContentInsets;


@property(nonatomic, assign) UIEdgeInsets   startingScrollIndicatorInsets;


@property(nonatomic, assign) CGPoint        startingContentOffset;




@property(nonatomic, assign) CGFloat    animationDuration;


@property(nonatomic, assign) NSInteger  animationCurve;




@property(nonnull, nonatomic, strong, readwrite) UITapGestureRecognizer  *resignFirstResponderGesture;


@property(nonatomic, assign, readwrite) CGFloat movedDistance;



@property(nonatomic, strong, nonnull, readwrite) NSMutableSet<Class> *disabledDistanceHandlingClasses;
@property(nonatomic, strong, nonnull, readwrite) NSMutableSet<Class> *enabledDistanceHandlingClasses;

@property(nonatomic, strong, nonnull, readwrite) NSMutableSet<Class> *disabledToolbarClasses;
@property(nonatomic, strong, nonnull, readwrite) NSMutableSet<Class> *enabledToolbarClasses;

@property(nonatomic, strong, nonnull, readwrite) NSMutableSet<Class> *toolbarPreviousNextAllowedClasses;

@property(nonatomic, strong, nonnull, readwrite) NSMutableSet<Class> *disabledTouchResignedClasses;
@property(nonatomic, strong, nonnull, readwrite) NSMutableSet<Class> *enabledTouchResignedClasses;
@property(nonatomic, strong, nonnull, readwrite) NSMutableSet<Class> *touchResignedGestureIgnoreClasses;



@end

@implementation IQKeyboardManager
{
	@package

    
    
    
    NSNotification          *_kbShowNotification;
    
    
    CGRect                   _kbFrame;
    
    
}


@synthesize enable                              =   _enable;
@synthesize keyboardDistanceFromTextField       =   _keyboardDistanceFromTextField;


@synthesize overrideKeyboardAppearance          =   _overrideKeyboardAppearance;
@synthesize keyboardAppearance                  =   _keyboardAppearance;


@synthesize enableAutoToolbar                   =   _enableAutoToolbar;
@synthesize toolbarManageBehaviour              =   _toolbarManageBehaviour;

@synthesize shouldToolbarUsesTextFieldTintColor =   _shouldToolbarUsesTextFieldTintColor;
@synthesize toolbarTintColor                    =   _toolbarTintColor;
@synthesize toolbarBarTintColor                 =   _toolbarBarTintColor;
@synthesize shouldShowToolbarPlaceholder        =   _shouldShowToolbarPlaceholder;
@synthesize placeholderFont                     =   _placeholderFont;
@synthesize placeholderColor                    =   _placeholderColor;
@synthesize placeholderButtonColor              =   _placeholderButtonColor;


@synthesize shouldResignOnTouchOutside          =   _shouldResignOnTouchOutside;
@synthesize resignFirstResponderGesture         =   _resignFirstResponderGesture;


@synthesize shouldPlayInputClicks               =   _shouldPlayInputClicks;


@synthesize layoutIfNeededOnUpdate              =   _layoutIfNeededOnUpdate;



#if !IQ_KEYBOARD_MANAGER_LOAD_METHOD_DISABLE
+(void)load
{
    
    [self performSelectorOnMainThread:@selector(sharedManager) withObject:nil waitUntilDone:NO];
}
#endif


-(instancetype)init
{
	if (self = [super init])
    {
        __weak __typeof__(self) weakSelf = self;
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            __strong __typeof__(self) strongSelf = weakSelf;
            
            [strongSelf registerAllNotifications];

            
            strongSelf.resignFirstResponderGesture = [[UITapGestureRecognizer alloc] initWithTarget:strongSelf action:@selector(tapRecognized:)];
            strongSelf.resignFirstResponderGesture.cancelsTouchesInView = NO;
            [strongSelf.resignFirstResponderGesture setDelegate:strongSelf];
            strongSelf.resignFirstResponderGesture.enabled = strongSelf.shouldResignOnTouchOutside;
            strongSelf.topViewBeginOrigin = kIQCGPointInvalid;
            strongSelf.topViewBeginOriginWhilePopGestureRecognizerActive = kIQCGPointInvalid;
            
            
            strongSelf.animationDuration = 0.25;
            strongSelf.animationCurve = UIViewAnimationCurveEaseInOut;
            [strongSelf setEnable:YES];
			[strongSelf setKeyboardDistanceFromTextField:10.0];
            [strongSelf setShouldPlayInputClicks:YES];
            [strongSelf setShouldResignOnTouchOutside:NO];
            [strongSelf setOverrideKeyboardAppearance:NO];
            [strongSelf setKeyboardAppearance:UIKeyboardAppearanceDefault];
            [strongSelf setEnableAutoToolbar:YES];
            [strongSelf setShouldShowToolbarPlaceholder:YES];
            [strongSelf setToolbarManageBehaviour:IQAutoToolbarBySubviews];
            [strongSelf setLayoutIfNeededOnUpdate:NO];
            [strongSelf setShouldToolbarUsesTextFieldTintColor:NO];

            
            {
                
                UITextField *view = [[UITextField alloc] init];
                [view addDoneOnKeyboardWithTarget:nil action:nil];
                [view addPreviousNextDoneOnKeyboardWithTarget:nil previousAction:nil nextAction:nil doneAction:nil];
            }
            
            
            strongSelf.disabledDistanceHandlingClasses = [[NSMutableSet alloc] initWithObjects:[UITableViewController class],[UIAlertController class], nil];
            strongSelf.enabledDistanceHandlingClasses = [[NSMutableSet alloc] init];
            
            strongSelf.disabledToolbarClasses = [[NSMutableSet alloc] initWithObjects:[UIAlertController class], nil];
            strongSelf.enabledToolbarClasses = [[NSMutableSet alloc] init];
            
            strongSelf.toolbarPreviousNextAllowedClasses = [[NSMutableSet alloc] initWithObjects:[UITableView class],[UICollectionView class],[IQPreviousNextView class], nil];
            
            strongSelf.disabledTouchResignedClasses = [[NSMutableSet alloc] initWithObjects:[UIAlertController class], nil];
            strongSelf.enabledTouchResignedClasses = [[NSMutableSet alloc] init];
            strongSelf.touchResignedGestureIgnoreClasses = [[NSMutableSet alloc] initWithObjects:[UIControl class],[UINavigationBar class], nil];
        });
    }
    return self;
}


+ (IQKeyboardManager*)sharedManager
{
	
	static IQKeyboardManager *kbManager;
	
	static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        kbManager = [[self alloc] init];
    });
	
	return kbManager;
}

-(void)dealloc
{
    
	[self setEnable:NO];
    
    
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setEnable:(BOOL)enable
{
	
    if (enable == YES &&
        _enable == NO)
    {
		
		_enable = enable;
        
		
		if (_kbShowNotification)	[self keyboardWillShow:_kbShowNotification];

        [self showLog:@"Enabled"];
    }
	
    else if (enable == NO &&
             _enable == YES)
    {
		
		[self keyboardWillHide:nil];
        
		
		_enable = enable;
		
        [self showLog:@"Disabled"];
    }
	
	else if (enable == NO &&
             _enable == NO)
	{
        [self showLog:@"Already Disabled"];
	}
	
	else if (enable == YES &&
             _enable == YES)
	{
        [self showLog:@"Already Enabled"];
	}
}

-(BOOL)privateIsEnabled
{
    BOOL enable = _enable;
    
    IQEnableMode enableMode = _textFieldView.enableMode;

    if (enableMode == IQEnableModeEnabled)
    {
        enable = YES;
    }
    else if (enableMode == IQEnableModeDisabled)
    {
        enable = NO;
    }
    else
    {
        __strong __typeof__(UIView) *strongTextFieldView = _textFieldView;

        UIViewController *textFieldViewController = [strongTextFieldView viewContainingController];
        
        if (textFieldViewController)
        {
            
            if ([strongTextFieldView textFieldSearchBar] != nil && [textFieldViewController isKindOfClass:[UINavigationController class]]) {
                
                UINavigationController *navController = (UINavigationController*)textFieldViewController;
                if (navController.topViewController) {
                    textFieldViewController = navController.topViewController;
                }
            }

            if (enable == NO)
            {
                
                for (Class enabledClass in _enabledDistanceHandlingClasses)
                {
                    if ([textFieldViewController isKindOfClass:enabledClass])
                    {
                        enable = YES;
                        break;
                    }
                }
            }
            
            if (enable)
            {
                
                for (Class disabledClass in _disabledDistanceHandlingClasses)
                {
                    if ([textFieldViewController isKindOfClass:disabledClass])
                    {
                        enable = NO;
                        break;
                    }
                }
                
                
                if (enable == YES)
                {
                    NSString *classNameString = NSStringFromClass([textFieldViewController class]);
                    
                    
                    if ([classNameString containsString:@"UIAlertController"] && [classNameString hasSuffix:@"TextFieldViewController"])
                    {
                        enable = NO;
                    }
                }
            }
        }
    }
    
    return enable;
}


-(void)setKeyboardDistanceFromTextField:(CGFloat)keyboardDistanceFromTextField
{
    
	_keyboardDistanceFromTextField = MAX(keyboardDistanceFromTextField, 0);

    [self showLog:[NSString stringWithFormat:@"keyboardDistanceFromTextField: %.2f",_keyboardDistanceFromTextField]];
}


-(void)setShouldResignOnTouchOutside:(BOOL)shouldResignOnTouchOutside
{
    [self showLog:[NSString stringWithFormat:@"shouldResignOnTouchOutside: %@",shouldResignOnTouchOutside?@"Yes":@"No"]];
    
    _shouldResignOnTouchOutside = shouldResignOnTouchOutside;
    
    
    [_resignFirstResponderGesture setEnabled:[self privateShouldResignOnTouchOutside]];
}

-(BOOL)privateShouldResignOnTouchOutside
{
    BOOL shouldResignOnTouchOutside = _shouldResignOnTouchOutside;
    
    __strong __typeof__(UIView) *strongTextFieldView = _textFieldView;

    IQEnableMode enableMode = strongTextFieldView.shouldResignOnTouchOutsideMode;
    
    if (enableMode == IQEnableModeEnabled)
    {
        shouldResignOnTouchOutside = YES;
    }
    else if (enableMode == IQEnableModeDisabled)
    {
        shouldResignOnTouchOutside = NO;
    }
    else
    {
        UIViewController *textFieldViewController = [strongTextFieldView viewContainingController];
        
        if (textFieldViewController)
        {
            
            if ([strongTextFieldView textFieldSearchBar] != nil && [textFieldViewController isKindOfClass:[UINavigationController class]]) {
                
                UINavigationController *navController = (UINavigationController*)textFieldViewController;
                if (navController.topViewController) {
                    textFieldViewController = navController.topViewController;
                }
            }

            if (shouldResignOnTouchOutside == NO)
            {
                
                for (Class enabledClass in _enabledTouchResignedClasses)
                {
                    if ([textFieldViewController isKindOfClass:enabledClass])
                    {
                        shouldResignOnTouchOutside = YES;
                        break;
                    }
                }
            }
            
            if (shouldResignOnTouchOutside)
            {
                
                for (Class disabledClass in _disabledTouchResignedClasses)
                {
                    if ([textFieldViewController isKindOfClass:disabledClass])
                    {
                        shouldResignOnTouchOutside = NO;
                        break;
                    }
                }
                
                
                if (shouldResignOnTouchOutside == YES)
                {
                    NSString *classNameString = NSStringFromClass([textFieldViewController class]);
                    
                    
                    if ([classNameString containsString:@"UIAlertController"] && [classNameString hasSuffix:@"TextFieldViewController"])
                    {
                        shouldResignOnTouchOutside = NO;
                    }
                }
            }
        }
    }
    
    return shouldResignOnTouchOutside;
}


-(void)setMovedDistance:(CGFloat)movedDistance
{
    _movedDistance = movedDistance;
    if (self.movedDistanceChanged != nil) {
        self.movedDistanceChanged(movedDistance);
    }
}


-(void)setEnableAutoToolbar:(BOOL)enableAutoToolbar
{
    _enableAutoToolbar = enableAutoToolbar;
    
    [self showLog:[NSString stringWithFormat:@"enableAutoToolbar: %@",enableAutoToolbar?@"Yes":@"No"]];

    
    if ([self privateIsEnableAutoToolbar] == YES)
    {
        [self addToolbarIfRequired];
    }
    
    else
    {
        [self removeToolbarIfRequired];
    }
}

-(BOOL)privateIsEnableAutoToolbar
{
    BOOL enableAutoToolbar = _enableAutoToolbar;
    
    __strong __typeof__(UIView) *strongTextFieldView = _textFieldView;

    UIViewController *textFieldViewController = [strongTextFieldView viewContainingController];
    
    if (textFieldViewController)
    {
        
        if ([strongTextFieldView textFieldSearchBar] != nil && [textFieldViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController *navController = (UINavigationController*)textFieldViewController;
            if (navController.topViewController) {
                textFieldViewController = navController.topViewController;
            }
        }

        if (enableAutoToolbar == NO)
        {
            
            for (Class enabledToolbarClass in _enabledToolbarClasses)
            {
                if ([textFieldViewController isKindOfClass:enabledToolbarClass])
                {
                    enableAutoToolbar = YES;
                    break;
                }
            }
        }
        
        if (enableAutoToolbar)
        {
            
            for (Class disabledToolbarClass in _disabledToolbarClasses)
            {
                if ([textFieldViewController isKindOfClass:disabledToolbarClass])
                {
                    enableAutoToolbar = NO;
                    break;
                }
            }
            
            
            
            if (enableAutoToolbar == YES)
            {
                NSString *classNameString = NSStringFromClass([textFieldViewController class]);
                
                
                if ([classNameString containsString:@"UIAlertController"] && [classNameString hasSuffix:@"TextFieldViewController"])
                {
                    enableAutoToolbar = NO;
                }
            }
        }
    }
    
    return enableAutoToolbar;
}



-(UIWindow *)keyWindow
{
    UIView *textFieldView = _textFieldView;

    if (textFieldView.window)
    {
        return textFieldView.window;
    }
    else
    {
        static __weak UIWindow *_keyWindow = nil;
        
        
        UIWindow *originalKeyWindow = [[UIApplication sharedApplication] keyWindow];
        
        UIWindow *strongKeyWindow = _keyWindow;
        
        
        if (originalKeyWindow && strongKeyWindow != originalKeyWindow)
        {
            strongKeyWindow = _keyWindow = originalKeyWindow;
        }
        
        return strongKeyWindow;
    }
}

-(void)optimizedAdjustPosition
{
    if (_hasPendingAdjustRequest == NO)
    {
        _hasPendingAdjustRequest = YES;
        
        __weak __typeof__(self) weakSelf = self;

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            __strong __typeof__(self) strongSelf = weakSelf;

            [strongSelf adjustPosition];
            strongSelf.hasPendingAdjustRequest = NO;
        }];
    }
}


-(void)adjustPosition
{
    UIView *textFieldView = _textFieldView;

    
    UIViewController *rootController = _rootViewController;
    
    
    UIWindow *keyWindow = [self keyWindow];
    
    
    if (_hasPendingAdjustRequest == NO ||
        textFieldView == nil ||
        rootController == nil ||
        keyWindow == nil)
        return;
    
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)] indentation:1];

    
    CGRect textFieldViewRectInWindow = [[textFieldView superview] convertRect:textFieldView.frame toView:keyWindow];
    CGRect textFieldViewRectInRootSuperview = [[textFieldView superview] convertRect:textFieldView.frame toView:rootController.view.superview];
    
    CGPoint rootViewOrigin = rootController.view.frame.origin;

    
    CGFloat specialKeyboardDistanceFromTextField = textFieldView.keyboardDistanceFromTextField;

    {
        UISearchBar *searchBar = textFieldView.textFieldSearchBar;
        
        if (searchBar)
        {
            specialKeyboardDistanceFromTextField = searchBar.keyboardDistanceFromTextField;
        }
    }
    
    CGFloat keyboardDistanceFromTextField = (specialKeyboardDistanceFromTextField == kIQUseDefaultKeyboardDistance)?_keyboardDistanceFromTextField:specialKeyboardDistanceFromTextField;

    CGSize kbSize;
    
    {
        CGRect kbFrame = _kbFrame;
        
        kbFrame.origin.y -= keyboardDistanceFromTextField;
        kbFrame.size.height += keyboardDistanceFromTextField;
        
        
        CGRect intersectRect = CGRectIntersection(kbFrame, keyWindow.frame);
        
        if (CGRectIsNull(intersectRect))
        {
            kbSize = CGSizeMake(kbFrame.size.width, 0);
        }
        else
        {
            kbSize = intersectRect.size;
        }
    }

    CGFloat statusBarHeight = 0;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
    if (@available(iOS 13.0, *)) {
        statusBarHeight = [self keyWindow].windowScene.statusBarManager.statusBarFrame.size.height;

    } else
#endif
    {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 130000
        statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
#endif
    }

    CGFloat navigationBarAreaHeight = statusBarHeight + rootController.navigationController.navigationBar.frame.size.height;
    CGFloat layoutAreaHeight = rootController.view.layoutMargins.top;
    
    CGFloat topLayoutGuide = MAX(navigationBarAreaHeight, layoutAreaHeight) + 5;
    CGFloat bottomLayoutGuide = ([textFieldView respondsToSelector:@selector(isEditable)] && [textFieldView isKindOfClass:[UIScrollView class]]) ? 0 : rootController.view.layoutMargins.bottom; 

    
    
    
    CGFloat move = MIN(CGRectGetMinY(textFieldViewRectInRootSuperview)-topLayoutGuide, CGRectGetMaxY(textFieldViewRectInWindow)-(CGRectGetHeight(keyWindow.frame)-kbSize.height)+bottomLayoutGuide);

    [self showLog:[NSString stringWithFormat:@"Need to move: %.2f",move]];

    UIScrollView *superScrollView = nil;
    UIScrollView *superView = (UIScrollView*)[textFieldView superviewOfClassType:[UIScrollView class]];

    
    while (superView)
    {
        if (superView.isScrollEnabled && superView.shouldIgnoreScrollingAdjustment == NO)
        {
            superScrollView = superView;
            break;
        }
        else
        {
            
            superView = (UIScrollView*)[superView superviewOfClassType:[UIScrollView class]];
        }
    }
    
    __strong __typeof__(UIScrollView) *strongLastScrollView = _lastScrollView;

    
    if (strongLastScrollView)
    {
        
        if (superScrollView == nil)
        {
            if (UIEdgeInsetsEqualToEdgeInsets(strongLastScrollView.contentInset, _startingContentInsets) == NO)
            {
                [self showLog:[NSString stringWithFormat:@"Restoring ScrollView contentInset to : %@",NSStringFromUIEdgeInsets(_startingContentInsets)]];
                
                __weak __typeof__(self) weakSelf = self;

                [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                    
                    __strong __typeof__(self) strongSelf = weakSelf;
                    
                    [strongLastScrollView setContentInset:strongSelf.startingContentInsets];
                    strongLastScrollView.scrollIndicatorInsets = strongSelf.startingScrollIndicatorInsets;
                } completion:NULL];
            }
            
            if (strongLastScrollView.shouldRestoreScrollViewContentOffset && CGPointEqualToPoint(strongLastScrollView.contentOffset, _startingContentOffset) == NO)
            {
                [self showLog:[NSString stringWithFormat:@"Restoring ScrollView contentOffset to : %@",NSStringFromCGPoint(_startingContentOffset)]];
                
                BOOL animatedContentOffset = NO;    

                if (@available(iOS 9.0, *))
                {
                    animatedContentOffset = ([textFieldView superviewOfClassType:[UIStackView class] belowView:strongLastScrollView] != nil);
                }

                if (animatedContentOffset) {
                    [strongLastScrollView setContentOffset:_startingContentOffset animated:UIView.areAnimationsEnabled];
                } else {
                    strongLastScrollView.contentOffset = _startingContentOffset;
                }
            }

            _startingContentInsets = UIEdgeInsetsZero;
            _startingScrollIndicatorInsets = UIEdgeInsetsZero;
            _startingContentOffset = CGPointZero;
            _lastScrollView = nil;
            strongLastScrollView = _lastScrollView;
        }
        
        else if (superScrollView != strongLastScrollView)
        {
            if (UIEdgeInsetsEqualToEdgeInsets(strongLastScrollView.contentInset, _startingContentInsets) == NO)
            {
                [self showLog:[NSString stringWithFormat:@"Restoring ScrollView contentInset to : %@",NSStringFromUIEdgeInsets(_startingContentInsets)]];

                __weak __typeof__(self) weakSelf = self;
                
                [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                    
                    __strong __typeof__(self) strongSelf = weakSelf;
                    
                    [strongLastScrollView setContentInset:strongSelf.startingContentInsets];
                    strongLastScrollView.scrollIndicatorInsets = strongSelf.startingScrollIndicatorInsets;
                } completion:NULL];
            }

            if (strongLastScrollView.shouldRestoreScrollViewContentOffset && CGPointEqualToPoint(strongLastScrollView.contentOffset, _startingContentOffset) == NO)
            {
                [self showLog:[NSString stringWithFormat:@"Restoring ScrollView contentOffset to : %@",NSStringFromCGPoint(_startingContentOffset)]];

                BOOL animatedContentOffset = NO;    

                if (@available(iOS 9.0, *))
                {
                    animatedContentOffset = ([textFieldView superviewOfClassType:[UIStackView class] belowView:strongLastScrollView] != nil);
                }

                if (animatedContentOffset) {
                    [strongLastScrollView setContentOffset:_startingContentOffset animated:UIView.areAnimationsEnabled];
                } else {
                    strongLastScrollView.contentOffset = _startingContentOffset;
                }
            }
            
            _lastScrollView = superScrollView;
            strongLastScrollView = _lastScrollView;
            _startingContentInsets = superScrollView.contentInset;
            _startingContentOffset = superScrollView.contentOffset;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
            if (@available(iOS 11.1, *)) {
                _startingScrollIndicatorInsets = superScrollView.verticalScrollIndicatorInsets;
            } else
#endif
            {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 130000
                _startingScrollIndicatorInsets = superScrollView.scrollIndicatorInsets;
#endif
            }

            [self showLog:[NSString stringWithFormat:@"Saving New contentInset: %@ and contentOffset : %@",NSStringFromUIEdgeInsets(_startingContentInsets),NSStringFromCGPoint(_startingContentOffset)]];
        }
        
    }
    
    else if(superScrollView)
    {
        _lastScrollView = superScrollView;
        strongLastScrollView = _lastScrollView;
        _startingContentInsets = superScrollView.contentInset;
        _startingContentOffset = superScrollView.contentOffset;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
        if (@available(iOS 11.1, *)) {
            _startingScrollIndicatorInsets = superScrollView.verticalScrollIndicatorInsets;
        } else
#endif
        {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 130000
            _startingScrollIndicatorInsets = superScrollView.scrollIndicatorInsets;
#endif
        }

        [self showLog:[NSString stringWithFormat:@"Saving contentInset: %@ and contentOffset : %@",NSStringFromUIEdgeInsets(_startingContentInsets),NSStringFromCGPoint(_startingContentOffset)]];
    }
    
    
    {
        
        if (strongLastScrollView)
        {
            
            UIView *lastView = textFieldView;
            superScrollView = strongLastScrollView;

            
            while (superScrollView)
            {
                BOOL shouldContinue = NO;
                
                if (move > 0)
                {
                    shouldContinue = move > (-superScrollView.contentOffset.y-superScrollView.contentInset.top);
                }
                else
                {
                    
                    if ([superScrollView isKindOfClass:[UITableView class]])
                    {
                        shouldContinue = superScrollView.contentOffset.y>0;

                        UITableView *tableView = (UITableView*)superScrollView;
                        UITableViewCell *tableCell = nil;
                        NSIndexPath *indexPath = nil;
                        NSIndexPath *previousIndexPath = nil;

                        if (shouldContinue &&
                            (tableCell = (UITableViewCell*)[textFieldView superviewOfClassType:[UITableViewCell class]]) &&
                            (indexPath = [tableView indexPathForCell:tableCell]) &&
                            (previousIndexPath = [tableView previousIndexPathOfIndexPath:indexPath]))
                        {
                            CGRect previousCellRect = [tableView rectForRowAtIndexPath:previousIndexPath];
                            if (CGRectIsEmpty(previousCellRect) == NO)
                            {
                                CGRect previousCellRectInRootSuperview = [tableView convertRect:previousCellRect toView:rootController.view.superview];
                                move = MIN(0, CGRectGetMaxY(previousCellRectInRootSuperview) - topLayoutGuide);
                            }
                        }
                    }
                    
                    else if ([superScrollView isKindOfClass:[UICollectionView class]])
                    {
                        shouldContinue = superScrollView.contentOffset.y>0;
                        
                        UICollectionView *collectionView = (UICollectionView*)superScrollView;
                        UICollectionViewCell *collectionCell = nil;
                        NSIndexPath *indexPath = nil;
                        NSIndexPath *previousIndexPath = nil;

                        if (shouldContinue &&
                            (collectionCell = (UICollectionViewCell*)[textFieldView superviewOfClassType:[UICollectionViewCell class]]) &&
                            (indexPath = [collectionView indexPathForCell:collectionCell]) &&
                            (previousIndexPath = [collectionView previousIndexPathOfIndexPath:indexPath]))
                        {
                            UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:previousIndexPath];
                            
                            CGRect previousCellRect = attributes.frame;
                            if (CGRectIsEmpty(previousCellRect) == NO)
                            {
                                CGRect previousCellRectInRootSuperview = [collectionView convertRect:previousCellRect toView:rootController.view.superview];
                                move = MIN(0, CGRectGetMaxY(previousCellRectInRootSuperview) - topLayoutGuide);
                            }
                        }
                    }
                    else
                    {
                        
                        shouldContinue = textFieldViewRectInRootSuperview.origin.y < topLayoutGuide;
                        
                        if (shouldContinue) {
                            move = MIN(0, textFieldViewRectInRootSuperview.origin.y - topLayoutGuide);
                        }
                    }
                }
                
                if (shouldContinue == NO)
                {
                    move = 0;
                    break;
                }

                UIScrollView *nextScrollView = nil;
                UIScrollView *tempScrollView = (UIScrollView*)[superScrollView superviewOfClassType:[UIScrollView class]];
                
                
                while (tempScrollView)
                {
                    if (tempScrollView.isScrollEnabled && tempScrollView.shouldIgnoreScrollingAdjustment == NO)
                    {
                        nextScrollView = tempScrollView;
                        break;
                    }
                    else
                    {
                        
                        tempScrollView = (UIScrollView*)[tempScrollView superviewOfClassType:[UIScrollView class]];
                    }
                }

                
                CGRect lastViewRect = [[lastView superview] convertRect:lastView.frame toView:superScrollView];
                
                
                CGFloat shouldOffsetY = superScrollView.contentOffset.y - MIN(superScrollView.contentOffset.y,-move);
                
                
                shouldOffsetY = MIN(shouldOffsetY, lastViewRect.origin.y);
                
                
                
                
                if ([textFieldView respondsToSelector:@selector(isEditable)]  && [textFieldView isKindOfClass:[UIScrollView class]] &&
                    nextScrollView == nil &&
                    (shouldOffsetY >= 0))
                {
                    
                    CGRect currentTextFieldViewRect = [[textFieldView superview] convertRect:textFieldView.frame toView:keyWindow];
                    
                    
                    CGFloat expectedFixDistance = CGRectGetMinY(currentTextFieldViewRect) - topLayoutGuide;
                    
                    
                    shouldOffsetY = MIN(shouldOffsetY, superScrollView.contentOffset.y + expectedFixDistance);
                    
                    
                    move = 0;
                }
                else
                {
                    
                    move -= (shouldOffsetY-superScrollView.contentOffset.y);
                }

                
                CGPoint newContentOffset = CGPointMake(superScrollView.contentOffset.x, shouldOffsetY);
                
                if (CGPointEqualToPoint(superScrollView.contentOffset, newContentOffset) == NO)
                {
                    __weak __typeof__(self) weakSelf = self;

                    
                    [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                        
                        __strong __typeof__(self) strongSelf = weakSelf;

                        [strongSelf showLog:[NSString stringWithFormat:@"Adjusting %.2f to %@ ContentOffset",(superScrollView.contentOffset.y-shouldOffsetY),[superScrollView _IQDescription]]];
                        [strongSelf showLog:[NSString stringWithFormat:@"Remaining Move: %.2f",move]];
                        
                        BOOL animatedContentOffset = NO;    

                        if (@available(iOS 9.0, *))
                        {
                            animatedContentOffset = ([textFieldView superviewOfClassType:[UIStackView class] belowView:superScrollView] != nil);
                        }

                        if (animatedContentOffset) {
                            [superScrollView setContentOffset:newContentOffset animated:UIView.areAnimationsEnabled];
                        } else {
                            superScrollView.contentOffset = newContentOffset;
                        }
                    } completion:^(BOOL finished){
                        
                        __strong __typeof__(self) strongSelf = weakSelf;

                        if ([superScrollView isKindOfClass:[UITableView class]] || [superScrollView isKindOfClass:[UICollectionView class]])
                        {
                            
                            [strongSelf addToolbarIfRequired];
                        }
                    }];
                }

                
                lastView = superScrollView;
                superScrollView = nextScrollView;
            }
            
            
            {
                CGRect lastScrollViewRect = [[strongLastScrollView superview] convertRect:strongLastScrollView.frame toView:keyWindow];

                CGFloat bottom = (kbSize.height-keyboardDistanceFromTextField)-(CGRectGetHeight(keyWindow.frame)-CGRectGetMaxY(lastScrollViewRect));

                
                CGFloat bottomInset = MAX(_startingContentInsets.bottom, bottom);

                if (@available(iOS 11, *)) {
                    bottomInset -= strongLastScrollView.safeAreaInsets.bottom;
                }

                UIEdgeInsets movedInsets = strongLastScrollView.contentInset;
                movedInsets.bottom = bottomInset;

                if (UIEdgeInsetsEqualToEdgeInsets(strongLastScrollView.contentInset, movedInsets) == NO)
                {
                    [self showLog:[NSString stringWithFormat:@"old ContentInset : %@ new ContentInset : %@", NSStringFromUIEdgeInsets(strongLastScrollView.contentInset), NSStringFromUIEdgeInsets(movedInsets)]];
                    
                    [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                        
                        strongLastScrollView.contentInset = movedInsets;
                        UIEdgeInsets newInset;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
                        if (@available(iOS 11.1, *)) {
                            newInset = strongLastScrollView.verticalScrollIndicatorInsets;
                        } else
#endif
                        {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 130000
                            newInset = strongLastScrollView.scrollIndicatorInsets;
#endif
                        }

                        newInset.bottom = movedInsets.bottom;
                        strongLastScrollView.scrollIndicatorInsets = newInset;
                        
                    } completion:NULL];
                }
            }
        }
        
    }
    
    {
        
        
        
        if ([textFieldView respondsToSelector:@selector(isEditable)] && [textFieldView isKindOfClass:[UIScrollView class]])
        {
            UIScrollView *textView = (UIScrollView*)textFieldView;

            CGFloat keyboardYPosition = CGRectGetHeight(keyWindow.frame)-(kbSize.height-keyboardDistanceFromTextField);

            CGRect rootSuperViewFrameInWindow = [rootController.view.superview convertRect:rootController.view.superview.bounds toView:keyWindow];

            CGFloat keyboardOverlapping = CGRectGetMaxY(rootSuperViewFrameInWindow) - keyboardYPosition;

            CGFloat textViewHeight = MIN(CGRectGetHeight(textFieldView.frame), (CGRectGetHeight(rootSuperViewFrameInWindow)-topLayoutGuide-keyboardOverlapping));
            
            if (textFieldView.frame.size.height-textView.contentInset.bottom>textViewHeight)
            {
                
                if (self.isTextViewContentInsetChanged == NO)
                {
                    self.startingTextViewContentInsets = textView.contentInset;
                    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
                    if (@available(iOS 11.1, *)) {
                        self.startingTextViewScrollIndicatorInsets = textView.verticalScrollIndicatorInsets;
                    } else
#endif
                    {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 130000
                        self.startingTextViewScrollIndicatorInsets = textView.scrollIndicatorInsets;
#endif
                    }
                }

                CGFloat bottomInset = textFieldView.frame.size.height-textViewHeight;

                if (@available(iOS 11, *)) {
                    bottomInset -= textFieldView.safeAreaInsets.bottom;
                }

                UIEdgeInsets newContentInset = textView.contentInset;
                newContentInset.bottom = bottomInset;

                self.isTextViewContentInsetChanged = YES;

                if (UIEdgeInsetsEqualToEdgeInsets(textView.contentInset, newContentInset) == NO)
                {
                    __weak __typeof__(self) weakSelf = self;
                    
                    [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                        
                        __strong __typeof__(self) strongSelf = weakSelf;
                        
                        [strongSelf showLog:[NSString stringWithFormat:@"Old UITextView.contentInset : %@ New UITextView.contentInset : %@", NSStringFromUIEdgeInsets(textView.contentInset), NSStringFromUIEdgeInsets(textView.contentInset)]];
                        
                        textView.contentInset = newContentInset;
                        textView.scrollIndicatorInsets = newContentInset;
                    } completion:NULL];
                }
            }
        }

        {
            __weak __typeof__(self) weakSelf = self;

            
            if (move>=0)
            {
                rootViewOrigin.y -= move;
                
                
                rootViewOrigin.y = MAX(rootViewOrigin.y, MIN(0, -(kbSize.height-keyboardDistanceFromTextField)));

                [self showLog:@"Moving Upward"];
                
                
                
                [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                    
                    __strong __typeof__(self) strongSelf = weakSelf;
                    
                    
                    CGRect rect = rootController.view.frame;
                    rect.origin = rootViewOrigin;
                    rootController.view.frame = rect;
                    
                    
                    if (strongSelf.layoutIfNeededOnUpdate)
                    {
                        
                        [rootController.view setNeedsLayout];
                        [rootController.view layoutIfNeeded];
                    }
                    
                    [strongSelf showLog:[NSString stringWithFormat:@"Set %@ origin to : %@",rootController,NSStringFromCGPoint(rootViewOrigin)]];
                } completion:NULL];

                self.movedDistance = (_topViewBeginOrigin.y-rootViewOrigin.y);
            }
            
            else
            {
                CGFloat disturbDistance = rootController.view.frame.origin.y-_topViewBeginOrigin.y;
                
                
                
                if(disturbDistance<=0)
                {
                    rootViewOrigin.y -= MAX(move, disturbDistance);
                    
                    [self showLog:@"Moving Downward"];
                    
                    
                    
                    [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                        
                        __strong __typeof__(self) strongSelf = weakSelf;
                        
                        
                        CGRect rect = rootController.view.frame;
                        rect.origin = rootViewOrigin;
                        rootController.view.frame = rect;
                        
                        
                        if (strongSelf.layoutIfNeededOnUpdate)
                        {
                            
                            [rootController.view setNeedsLayout];
                            [rootController.view layoutIfNeeded];
                        }
                        
                        [strongSelf showLog:[NSString stringWithFormat:@"Set %@ origin to : %@",rootController,NSStringFromCGPoint(rootViewOrigin)]];
                    } completion:NULL];

                    self.movedDistance = (_topViewBeginOrigin.y-rootController.view.frame.origin.y);
                }
            }
        }
    }
    
    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime] indentation:-1];
}

-(void)restorePosition
{
    _hasPendingAdjustRequest = NO;

    
    if (_rootViewController && CGPointEqualToPoint(_topViewBeginOrigin, kIQCGPointInvalid) == false)
    {
        __weak __typeof__(self) weakSelf = self;
        
        
        [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
            
            __strong __typeof__(self) strongSelf = weakSelf;
            UIViewController *strongRootController = strongSelf.rootViewController;
            
            {
                [strongSelf showLog:[NSString stringWithFormat:@"Restoring %@ origin to : %@",strongRootController,NSStringFromCGPoint(strongSelf.topViewBeginOrigin)]];
                
                
                CGRect rect = strongRootController.view.frame;
                rect.origin = strongSelf.topViewBeginOrigin;
                strongRootController.view.frame = rect;

                strongSelf.movedDistance = 0;
                
                if (strongRootController.navigationController.interactivePopGestureRecognizer.state == UIGestureRecognizerStateBegan) {
                    strongSelf.rootViewControllerWhilePopGestureRecognizerActive = strongRootController;
                    strongSelf.topViewBeginOriginWhilePopGestureRecognizerActive = strongSelf.topViewBeginOrigin;
                }
                
                
                if (strongSelf.layoutIfNeededOnUpdate)
                {
                    
                    [strongRootController.view setNeedsLayout];
                    [strongRootController.view layoutIfNeeded];
                }
            }
            
        } completion:NULL];
        _rootViewController = nil;
    }
}



- (void)reloadLayoutIfNeeded
{
    if ([self privateIsEnabled] == YES)
    {
        UIView *textFieldView = _textFieldView;
        
        if (textFieldView &&
            _keyboardShowing == YES &&
            CGPointEqualToPoint(_topViewBeginOrigin, kIQCGPointInvalid) == false &&
            [textFieldView isAlertViewTextField] == NO)
        {
            [self optimizedAdjustPosition];
        }
    }
}


-(void)keyboardWillShow:(NSNotification*)aNotification
{
    _kbShowNotification = aNotification;
	
    
    _keyboardShowing = YES;
    
    
    NSInteger curve = [[aNotification userInfo][UIKeyboardAnimationCurveUserInfoKey] integerValue];
    _animationCurve = curve<<16;

    
    CGFloat duration = [[aNotification userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    
    if (duration != 0.0)    _animationDuration = duration;
    
    CGRect oldKBFrame = _kbFrame;
    
    
    _kbFrame = [[aNotification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];

    if ([self privateIsEnabled] == NO)
    {
        [self restorePosition];
        _topViewBeginOrigin = kIQCGPointInvalid;
        return;
    }
	
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)] indentation:1];

    UIView *textFieldView = _textFieldView;

    if (textFieldView && CGPointEqualToPoint(_topViewBeginOrigin, kIQCGPointInvalid))    
    {
        
        UIViewController *rootController = [textFieldView parentContainerViewController];
        _rootViewController = rootController;
        
        if (_rootViewControllerWhilePopGestureRecognizerActive == rootController)
        {
            _topViewBeginOrigin = _topViewBeginOriginWhilePopGestureRecognizerActive;
        }
        else
        {
            _topViewBeginOrigin = rootController.view.frame.origin;
        }
        
        _rootViewControllerWhilePopGestureRecognizerActive = nil;
        _topViewBeginOriginWhilePopGestureRecognizerActive = kIQCGPointInvalid;
        
        [self showLog:[NSString stringWithFormat:@"Saving %@ beginning origin: %@",rootController,NSStringFromCGPoint(_topViewBeginOrigin)]];
    }

    
    if (!CGRectEqualToRect(_kbFrame, oldKBFrame))
    {
        
        
        if (_keyboardShowing == YES &&
            textFieldView &&
            [textFieldView isAlertViewTextField] == NO)
        {
            [self optimizedAdjustPosition];
        }
    }

    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime] indentation:-1];
}


- (void)keyboardDidShow:(NSNotification*)aNotification
{
    if ([self privateIsEnabled] == NO)	return;
    
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)] indentation:1];
    
    UIView *textFieldView = _textFieldView;

    
    UIViewController *controller = [textFieldView topMostController];

    
    if (_keyboardShowing == YES &&
        textFieldView &&
        (controller.modalPresentationStyle == UIModalPresentationFormSheet || controller.modalPresentationStyle == UIModalPresentationPageSheet) &&
        [textFieldView isAlertViewTextField] == NO)
    {
        [self optimizedAdjustPosition];
    }
    
    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime] indentation:-1];
}


- (void)keyboardWillHide:(NSNotification*)aNotification
{
    
    if (aNotification)	_kbShowNotification = nil;
    
    
    _keyboardShowing = NO;
    
    
    CGFloat aDuration = [[aNotification userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (aDuration!= 0.0f)
    {
        _animationDuration = aDuration;
    }
    
    
    if ([self privateIsEnabled] == NO)	return;
    
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)] indentation:1];

    
    


    
    __strong __typeof__(UIScrollView) *strongLastScrollView = _lastScrollView;

    if (strongLastScrollView)
    {
        __weak __typeof__(self) weakSelf = self;
        __weak __typeof__(UIView) *weakTextFieldView = self.textFieldView;

        [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
            
            __strong __typeof__(self) strongSelf = weakSelf;
            __strong __typeof__(UIView) *strongTextFieldView = weakTextFieldView;

            if (UIEdgeInsetsEqualToEdgeInsets(strongLastScrollView.contentInset, strongSelf.startingContentInsets) == NO)
            {
                [strongSelf showLog:[NSString stringWithFormat:@"Restoring ScrollView contentInset to : %@",NSStringFromUIEdgeInsets(strongSelf.startingContentInsets)]];

                strongLastScrollView.contentInset = strongSelf.startingContentInsets;
                strongLastScrollView.scrollIndicatorInsets = strongSelf.startingScrollIndicatorInsets;
            }
            
            if (strongLastScrollView.shouldRestoreScrollViewContentOffset && CGPointEqualToPoint(strongLastScrollView.contentOffset, strongSelf.startingContentOffset) == NO)
            {
                [strongSelf showLog:[NSString stringWithFormat:@"Restoring ScrollView contentOffset to : %@",NSStringFromCGPoint(strongSelf.startingContentOffset)]];

                BOOL animatedContentOffset = NO;    

                if (@available(iOS 9.0, *))
                {
                    animatedContentOffset = ([strongTextFieldView superviewOfClassType:[UIStackView class] belowView:strongLastScrollView] != nil);
                }

                if (animatedContentOffset) {
                    [strongLastScrollView setContentOffset:strongSelf.startingContentOffset animated:UIView.areAnimationsEnabled];
                } else {
                    strongLastScrollView.contentOffset = strongSelf.startingContentOffset;
                }
            }
            
            
            
            UIScrollView *superscrollView = strongLastScrollView;
            do
            {
                CGSize contentSize = CGSizeMake(MAX(superscrollView.contentSize.width, CGRectGetWidth(superscrollView.frame)), MAX(superscrollView.contentSize.height, CGRectGetHeight(superscrollView.frame)));
                
                CGFloat minimumY = contentSize.height-CGRectGetHeight(superscrollView.frame);
                
                if (minimumY<superscrollView.contentOffset.y)
                {
                    CGPoint newContentOffset = CGPointMake(superscrollView.contentOffset.x, minimumY);
                    if (CGPointEqualToPoint(superscrollView.contentOffset, newContentOffset) == NO)
                    {
                        [self showLog:[NSString stringWithFormat:@"Restoring contentOffset to : %@",NSStringFromCGPoint(newContentOffset)]];

                        BOOL animatedContentOffset = NO;    

                        if (@available(iOS 9.0, *))
                        {
                            animatedContentOffset = ([strongSelf.textFieldView superviewOfClassType:[UIStackView class] belowView:superscrollView] != nil);
                        }

                        if (animatedContentOffset) {
                            [superscrollView setContentOffset:newContentOffset animated:UIView.areAnimationsEnabled];
                        } else {
                            superscrollView.contentOffset = newContentOffset;
                        }
                    }
                }
            } while ((superscrollView = (UIScrollView*)[superscrollView superviewOfClassType:[UIScrollView class]]));

        } completion:NULL];
    }
    
    [self restorePosition];

    
    _lastScrollView = nil;
    _kbFrame = CGRectZero;
    _startingContentInsets = UIEdgeInsetsZero;
    _startingScrollIndicatorInsets = UIEdgeInsetsZero;
    _startingContentOffset = CGPointZero;

    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime] indentation:-1];
}


- (void)keyboardDidHide:(NSNotification*)aNotification
{
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)] indentation:1];

    _topViewBeginOrigin = kIQCGPointInvalid;

    _kbFrame = CGRectZero;

    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime] indentation:-1];
}


-(void)textFieldViewDidBeginEditing:(NSNotification*)notification
{
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)] indentation:1];

    
    _textFieldView = notification.object;
    
    UIView *textFieldView = _textFieldView;

    if (_overrideKeyboardAppearance == YES)
    {
        UITextField *textField = (UITextField*)textFieldView;
        
        if ([textField respondsToSelector:@selector(keyboardAppearance)])
        {
            
            if (textField.keyboardAppearance != _keyboardAppearance)
            {
                
                textField.keyboardAppearance = _keyboardAppearance;
                [textField reloadInputViews];
            }
        }
    }
    
	
	if ([self privateIsEnableAutoToolbar])
    {
        
        if ([textFieldView respondsToSelector:@selector(isEditable)] && [textFieldView isKindOfClass:[UIScrollView class]] &&
            textFieldView.inputAccessoryView == nil)
        {
            __weak __typeof__(self) weakSelf = self;

            [UIView animateWithDuration:0.00001 delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{

                __strong __typeof__(self) strongSelf = weakSelf;

                [strongSelf addToolbarIfRequired];
            } completion:^(BOOL finished) {

                __strong __typeof__(self) strongSelf = weakSelf;

                
                [strongSelf.textFieldView reloadInputViews];
            }];
        }
        
        else
        {
            [self addToolbarIfRequired];
        }
    }
    else
    {
        [self removeToolbarIfRequired];
    }
    
    
    [_resignFirstResponderGesture setEnabled:[self privateShouldResignOnTouchOutside]];
    [textFieldView.window addGestureRecognizer:_resignFirstResponderGesture];

    if ([self privateIsEnabled] == NO)
    {
        [self restorePosition];
        _topViewBeginOrigin = kIQCGPointInvalid;
    }
    else
    {
        if (CGPointEqualToPoint(_topViewBeginOrigin, kIQCGPointInvalid))    
        {
            
            UIViewController *rootController = [textFieldView parentContainerViewController];
            _rootViewController = rootController;
            
            if (_rootViewControllerWhilePopGestureRecognizerActive == rootController)
            {
                _topViewBeginOrigin = _topViewBeginOriginWhilePopGestureRecognizerActive;
            }
            else
            {
                _topViewBeginOrigin = rootController.view.frame.origin;
            }
            
            _rootViewControllerWhilePopGestureRecognizerActive = nil;
            _topViewBeginOriginWhilePopGestureRecognizerActive = kIQCGPointInvalid;
            
            [self showLog:[NSString stringWithFormat:@"Saving %@ beginning origin: %@",rootController, NSStringFromCGPoint(_topViewBeginOrigin)]];
        }
        
        
        
        if (_keyboardShowing == YES &&
            textFieldView &&
            [textFieldView isAlertViewTextField] == NO)
        {
            
            [self optimizedAdjustPosition];
        }
    }
    





    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime] indentation:-1];
}


-(void)textFieldViewDidEndEditing:(NSNotification*)notification
{
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)] indentation:1];

    UIView *textFieldView = _textFieldView;

    
    [textFieldView.window removeGestureRecognizer:_resignFirstResponderGesture];
    





    
    if(_isTextViewContentInsetChanged == YES &&
       [textFieldView respondsToSelector:@selector(isEditable)] && [textFieldView isKindOfClass:[UIScrollView class]])
    {
        UIScrollView *textView = (UIScrollView*)textFieldView;
        self.isTextViewContentInsetChanged = NO;
        if (UIEdgeInsetsEqualToEdgeInsets(textView.contentInset, self.startingTextViewContentInsets) == NO)
        {
            __weak __typeof__(self) weakSelf = self;
            
            [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                
                __strong __typeof__(self) strongSelf = weakSelf;
                
                [strongSelf showLog:[NSString stringWithFormat:@"Restoring textView.contentInset to : %@",NSStringFromUIEdgeInsets(strongSelf.startingTextViewContentInsets)]];
                
                
                textView.contentInset = strongSelf.startingTextViewContentInsets;
                textView.scrollIndicatorInsets = strongSelf.startingTextViewScrollIndicatorInsets;
                
            } completion:NULL];
        }
    }
    
    
    _textFieldView = nil;

    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime] indentation:-1];
}







- (void)willChangeStatusBarOrientation:(NSNotification*)aNotification
{
    UIInterfaceOrientation currentStatusBarOrientation = UIInterfaceOrientationUnknown;

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
    if (@available(iOS 13.0, *)) {
        currentStatusBarOrientation = [self keyWindow].windowScene.interfaceOrientation;
    } else
#endif
    {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 130000
        currentStatusBarOrientation = UIApplication.sharedApplication.statusBarOrientation;
#endif
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    UIInterfaceOrientation statusBarOrientation = [aNotification.userInfo[UIApplicationStatusBarOrientationUserInfoKey] integerValue];
#pragma clang diagnostic pop
    
    if (statusBarOrientation != currentStatusBarOrientation) {
        return;
    }
    
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)] indentation:1];

    __strong __typeof__(UIView) *strongTextFieldView = _textFieldView;

    
    if (_isTextViewContentInsetChanged == YES &&
        [strongTextFieldView respondsToSelector:@selector(isEditable)] && [strongTextFieldView isKindOfClass:[UIScrollView class]])
    {
        UIScrollView *textView = (UIScrollView*)strongTextFieldView;
        self.isTextViewContentInsetChanged = NO;
        if (UIEdgeInsetsEqualToEdgeInsets(textView.contentInset, self.startingTextViewContentInsets) == NO)
        {
            __weak __typeof__(self) weakSelf = self;
            
            
            [UIView animateWithDuration:_animationDuration delay:0 options:(_animationCurve|UIViewAnimationOptionBeginFromCurrentState) animations:^{
                
                __strong __typeof__(self) strongSelf = weakSelf;
                
                [strongSelf showLog:[NSString stringWithFormat:@"Restoring textView.contentInset to : %@",NSStringFromUIEdgeInsets(strongSelf.startingTextViewContentInsets)]];
                
                
                textView.contentInset = strongSelf.startingTextViewContentInsets;
                textView.scrollIndicatorInsets = strongSelf.startingTextViewScrollIndicatorInsets;
            } completion:NULL];
        }
    }

    [self restorePosition];

    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime] indentation:-1];
}



- (void)tapRecognized:(UITapGestureRecognizer*)gesture  
{
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        
        [self resignFirstResponder];
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    for (Class aClass in self.touchResignedGestureIgnoreClasses)
    {
        if ([[touch view] isKindOfClass:aClass])
        {
            return NO;
        }
    }

    return YES;
}


- (BOOL)resignFirstResponder
{
    UIView *textFieldView = _textFieldView;

    if (textFieldView)
    {
        
        UIView *textFieldRetain = textFieldView;
        
        
        BOOL isResignFirstResponder = [textFieldView resignFirstResponder];
        
        
        if (isResignFirstResponder == NO)
        {
            
            [textFieldRetain becomeFirstResponder];
            
            [self showLog:[NSString stringWithFormat:@"Refuses to Resign first responder: %@",textFieldView]];
        }
        
        return isResignFirstResponder;
    }
    else
    {
        return NO;
    }
}


-(BOOL)canGoPrevious
{
    
    NSArray<UIView*> *textFields = [self responderViews];

    
    NSUInteger index = [textFields indexOfObject:_textFieldView];

    
    if (index != NSNotFound &&
        index > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


-(BOOL)canGoNext
{
    
    NSArray<UIView*> *textFields = [self responderViews];
    
    
    NSUInteger index = [textFields indexOfObject:_textFieldView];
    
    
    if (index != NSNotFound &&
        index < textFields.count-1)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


-(BOOL)goPrevious
{
    
    NSArray<__kindof UIView*> *textFields = [self responderViews];
    
    
    NSUInteger index = [textFields indexOfObject:_textFieldView];
    
    
    if (index != NSNotFound &&
        index > 0)
    {
        UITextField *nextTextField = textFields[index-1];
        
        
        UIView *textFieldRetain = _textFieldView;
        
        BOOL isAcceptAsFirstResponder = [nextTextField becomeFirstResponder];
        
        
        if (isAcceptAsFirstResponder == NO)
        {
            
            [textFieldRetain becomeFirstResponder];
            
            [self showLog:[NSString stringWithFormat:@"Refuses to become first responder: %@",nextTextField]];
        }
        
        return isAcceptAsFirstResponder;
    }
    else
    {
        return NO;
    }
}


-(BOOL)goNext
{
    
    NSArray<__kindof UIView*> *textFields = [self responderViews];
    
    
    NSUInteger index = [textFields indexOfObject:_textFieldView];
    
    
    if (index != NSNotFound &&
        index < textFields.count-1)
    {
        UITextField *nextTextField = textFields[index+1];
        
        
        UIView *textFieldRetain = _textFieldView;
        
        BOOL isAcceptAsFirstResponder = [nextTextField becomeFirstResponder];
        
        
        if (isAcceptAsFirstResponder == NO)
        {
            
            [textFieldRetain becomeFirstResponder];
            
            [self showLog:[NSString stringWithFormat:@"Refuses to become first responder: %@",nextTextField]];
        }
        
        return isAcceptAsFirstResponder;
    }
    else
    {
        return NO;
    }
}



-(NSArray<__kindof UIView*>*)responderViews
{
    UIView *superConsideredView;
    
    UIView *textFieldView = _textFieldView;

    
    for (Class consideredClass in _toolbarPreviousNextAllowedClasses)
    {
        superConsideredView = [textFieldView superviewOfClassType:consideredClass];
        
        if (superConsideredView)
            break;
    }
    
    
    if (superConsideredView)
    {
        return [superConsideredView deepResponderViews];
    }
    
    else
    {
        NSArray<UIView*> *textFields = [textFieldView responderSiblings];
        
        
        switch (_toolbarManageBehaviour)
        {
                
            case IQAutoToolbarBySubviews:
                return textFields;
                break;
                
                
            case IQAutoToolbarByTag:
                return [textFields sortedArrayByTag];
                break;
                
                
            case IQAutoToolbarByPosition:
                return [textFields sortedArrayByPosition];
                break;
            default:
                return nil;
                break;
        }
    }
}


-(void)addToolbarIfRequired
{
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)] indentation:1];
    
    
    NSArray<UIView*> *siblings = [self responderViews];
    
    [self showLog:[NSString stringWithFormat:@"Found %lu responder sibling(s)",(unsigned long)siblings.count]];

    UIView *textFieldView = _textFieldView;

    
    
    if ([textFieldView respondsToSelector:@selector(setInputAccessoryView:)])
    {
        if ([textFieldView inputAccessoryView] == nil ||
            [[textFieldView inputAccessoryView] tag] == kIQPreviousNextButtonToolbarTag ||
            [[textFieldView inputAccessoryView] tag] == kIQDoneButtonToolbarTag)
        {
            UITextField *textField = (UITextField*)textFieldView;

            IQBarButtonItemConfiguration *rightConfiguration = nil;
            
            
            if (_toolbarDoneBarButtonItemImage)
            {
                rightConfiguration = [[IQBarButtonItemConfiguration alloc] initWithImage:_toolbarDoneBarButtonItemImage action:@selector(doneAction:)];
            }
            
            else if (_toolbarDoneBarButtonItemText)
            {
                rightConfiguration = [[IQBarButtonItemConfiguration alloc] initWithTitle:_toolbarDoneBarButtonItemText action:@selector(doneAction:)];
            }
            else
            {
                rightConfiguration = [[IQBarButtonItemConfiguration alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone action:@selector(doneAction:)];
            }
            rightConfiguration.accessibilityLabel = _toolbarDoneBarButtonItemAccessibilityLabel ? : @"Done";

            
            if ((siblings.count <= 1 && self.previousNextDisplayMode == IQPreviousNextDisplayModeDefault) || self.previousNextDisplayMode == IQPreviousNextDisplayModeAlwaysHide)
            {
                [textField addKeyboardToolbarWithTarget:self titleText:(_shouldShowToolbarPlaceholder ? textField.drawingToolbarPlaceholder : nil) rightBarButtonConfiguration:rightConfiguration previousBarButtonConfiguration:nil nextBarButtonConfiguration:nil];

                textField.inputAccessoryView.tag = kIQDoneButtonToolbarTag; 
            }
            
            else if ((self.previousNextDisplayMode == IQPreviousNextDisplayModeDefault) || self.previousNextDisplayMode == IQPreviousNextDisplayModeAlwaysShow)
            {
                IQBarButtonItemConfiguration *prevConfiguration = nil;
                
                
                if (_toolbarPreviousBarButtonItemImage)
                {
                    prevConfiguration = [[IQBarButtonItemConfiguration alloc] initWithImage:_toolbarPreviousBarButtonItemImage action:@selector(previousAction:)];
                }
                
                else if (_toolbarPreviousBarButtonItemText)
                {
                    prevConfiguration = [[IQBarButtonItemConfiguration alloc] initWithTitle:_toolbarPreviousBarButtonItemText action:@selector(previousAction:)];
                }
                else
                {
                    prevConfiguration = [[IQBarButtonItemConfiguration alloc] initWithImage:[UIImage keyboardPreviousImage] action:@selector(previousAction:)];
                }
                prevConfiguration.accessibilityLabel = _toolbarPreviousBarButtonItemAccessibilityLabel ? : @"Previous";
                
                IQBarButtonItemConfiguration *nextConfiguration = nil;
                
                
                if (_toolbarNextBarButtonItemImage)
                {
                    nextConfiguration = [[IQBarButtonItemConfiguration alloc] initWithImage:_toolbarNextBarButtonItemImage action:@selector(nextAction:)];
                }
                
                else if (_toolbarNextBarButtonItemText)
                {
                    nextConfiguration = [[IQBarButtonItemConfiguration alloc] initWithTitle:_toolbarNextBarButtonItemText action:@selector(nextAction:)];
                }
                else
                {
                    nextConfiguration = [[IQBarButtonItemConfiguration alloc] initWithImage:[UIImage keyboardNextImage] action:@selector(nextAction:)];
                }
                nextConfiguration.accessibilityLabel = _toolbarNextBarButtonItemAccessibilityLabel ? : @"Next";

                [textField addKeyboardToolbarWithTarget:self titleText:(_shouldShowToolbarPlaceholder ? textField.drawingToolbarPlaceholder : nil) rightBarButtonConfiguration:rightConfiguration previousBarButtonConfiguration:prevConfiguration nextBarButtonConfiguration:nextConfiguration];

                textField.inputAccessoryView.tag = kIQPreviousNextButtonToolbarTag; 
            }
            
            IQToolbar *toolbar = textField.keyboardToolbar;
            
            
            if ([textField respondsToSelector:@selector(keyboardAppearance)])
            {
                
                if (_shouldToolbarUsesTextFieldTintColor)
                {
                    toolbar.tintColor = [textField tintColor];
                }
                else if (_toolbarTintColor)
                {
                    toolbar.tintColor = _toolbarTintColor;
                }
                else
                {
                    toolbar.tintColor = nil;
                }

                switch ([textField keyboardAppearance])
                {
                    case UIKeyboardAppearanceDark:
                    {
                        toolbar.barStyle = UIBarStyleBlack;
                        [toolbar setBarTintColor:nil];
                    }
                        break;
                    default:
                    {
                        toolbar.barStyle = UIBarStyleDefault;
                        toolbar.barTintColor = _toolbarBarTintColor;
                    }
                        break;
                }
                
                
                if (_shouldShowToolbarPlaceholder &&
                    textField.shouldHideToolbarPlaceholder == NO)
                {
                    
                    if (toolbar.titleBarButton.title == nil ||
                        [toolbar.titleBarButton.title isEqualToString:textField.drawingToolbarPlaceholder] == NO)
                    {
                        [toolbar.titleBarButton setTitle:textField.drawingToolbarPlaceholder];
                    }
                    
                    
                    if (_placeholderFont &&
                        [_placeholderFont isKindOfClass:[UIFont class]])
                    {
                        [toolbar.titleBarButton setTitleFont:_placeholderFont];
                    }

                    
                    if (_placeholderColor)
                    {
                        [toolbar.titleBarButton setTitleColor:_placeholderColor];
                    }

                    
                    if (_placeholderButtonColor)
                    {
                        [toolbar.titleBarButton setSelectableTitleColor:_placeholderButtonColor];
                    }
                }
                else
                {
                    
                    toolbar.titleBarButton.title = nil;
                }
            }

            
            
            if (siblings.firstObject == textField)
            {
                if (siblings.count == 1)
                {
                    textField.keyboardToolbar.previousBarButton.enabled = NO;
                    textField.keyboardToolbar.nextBarButton.enabled = NO;
                }
                else
                {
                    textField.keyboardToolbar.previousBarButton.enabled = NO;
                    textField.keyboardToolbar.nextBarButton.enabled = YES;
                }
            }
            
            else if ([siblings lastObject] == textField)
            {
                textField.keyboardToolbar.previousBarButton.enabled = YES;
                textField.keyboardToolbar.nextBarButton.enabled = NO;
            }
            else
            {
                textField.keyboardToolbar.previousBarButton.enabled = YES;
                textField.keyboardToolbar.nextBarButton.enabled = YES;
            }
        }
    }

    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime] indentation:-1];
}


-(void)removeToolbarIfRequired  
{
    CFTimeInterval startTime = CACurrentMediaTime();
    [self showLog:[NSString stringWithFormat:@"****** %@ started ******",NSStringFromSelector(_cmd)] indentation:1];

    
    NSArray<UIView*> *siblings = [self responderViews];
    
    [self showLog:[NSString stringWithFormat:@"Found %lu responder sibling(s)",(unsigned long)siblings.count]];

    for (UITextField *textField in siblings)
    {
        UIView *toolbar = [textField inputAccessoryView];
        
        
        
        if ([textField respondsToSelector:@selector(setInputAccessoryView:)] &&
            ([toolbar isKindOfClass:[IQToolbar class]] && (toolbar.tag == kIQDoneButtonToolbarTag || toolbar.tag == kIQPreviousNextButtonToolbarTag)))
        {
            textField.inputAccessoryView = nil;
            [textField reloadInputViews];
        }
    }

    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    [self showLog:[NSString stringWithFormat:@"****** %@ ended: %g seconds ******",NSStringFromSelector(_cmd),elapsedTime] indentation:-1];
}


- (void)reloadInputViews
{
    
    if ([self privateIsEnableAutoToolbar] == YES)
    {
        [self addToolbarIfRequired];
    }
    
    else
    {
        [self removeToolbarIfRequired];
    }
}


-(void)previousAction:(IQBarButtonItem*)barButton
{
    
    if (_shouldPlayInputClicks)
    {
        [[UIDevice currentDevice] playInputClick];
    }

    if ([self canGoPrevious])
    {
        UIView *currentTextFieldView = _textFieldView;
        BOOL isAcceptAsFirstResponder = [self goPrevious];
        
        NSInvocation *invocation = barButton.invocation;
        UIView *sender = currentTextFieldView;

        
        {
            UISearchBar *searchBar = currentTextFieldView.textFieldSearchBar;
            
            if (searchBar)
            {
                invocation = searchBar.keyboardToolbar.previousBarButton.invocation;
                sender = searchBar;
            }
        }

        if (isAcceptAsFirstResponder == YES && invocation)
        {
            if (invocation.methodSignature.numberOfArguments > 2)
            {
                [invocation setArgument:&sender atIndex:2];
            }

            [invocation invoke];
        }
    }
}


-(void)nextAction:(IQBarButtonItem*)barButton
{
    
    if (_shouldPlayInputClicks)
    {
        [[UIDevice currentDevice] playInputClick];
    }

    if ([self canGoNext])
    {
        UIView *currentTextFieldView = _textFieldView;
        BOOL isAcceptAsFirstResponder = [self goNext];
        
        NSInvocation *invocation = barButton.invocation;
        UIView *sender = currentTextFieldView;

        
        {
            UISearchBar *searchBar = currentTextFieldView.textFieldSearchBar;
            
            if (searchBar)
            {
                invocation = searchBar.keyboardToolbar.nextBarButton.invocation;
                sender = searchBar;
            }
        }

        if (isAcceptAsFirstResponder == YES && invocation)
        {
            if (invocation.methodSignature.numberOfArguments > 2)
            {
                [invocation setArgument:&sender atIndex:2];
            }

            [invocation invoke];
        }
    }
}


-(void)doneAction:(IQBarButtonItem*)barButton
{
    
    if (_shouldPlayInputClicks)
    {
        [[UIDevice currentDevice] playInputClick];
    }

    UIView *currentTextFieldView = _textFieldView;
    BOOL isResignedFirstResponder = [self resignFirstResponder];
    
    NSInvocation *invocation = barButton.invocation;
    UIView *sender = currentTextFieldView;

    
    {
        UISearchBar *searchBar = currentTextFieldView.textFieldSearchBar;
        
        if (searchBar)
        {
            invocation = searchBar.keyboardToolbar.doneBarButton.invocation;
            sender = searchBar;
        }
    }

    if (isResignedFirstResponder == YES && invocation)
    {
        if (invocation.methodSignature.numberOfArguments > 2)
        {
            [invocation setArgument:&sender atIndex:2];
        }

        [invocation invoke];
    }
}



-(void)registerTextFieldViewClass:(nonnull Class)aClass
  didBeginEditingNotificationName:(nonnull NSString *)didBeginEditingNotificationName
    didEndEditingNotificationName:(nonnull NSString *)didEndEditingNotificationName
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldViewDidBeginEditing:) name:didBeginEditingNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldViewDidEndEditing:) name:didEndEditingNotificationName object:nil];
}


-(void)unregisterTextFieldViewClass:(nonnull Class)aClass
    didBeginEditingNotificationName:(nonnull NSString *)didBeginEditingNotificationName
      didEndEditingNotificationName:(nonnull NSString *)didEndEditingNotificationName
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:didBeginEditingNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:didEndEditingNotificationName object:nil];
}

-(void)registerAllNotifications
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    
    [self registerTextFieldViewClass:[UITextField class]
     didBeginEditingNotificationName:UITextFieldTextDidBeginEditingNotification
       didEndEditingNotificationName:UITextFieldTextDidEndEditingNotification];
    
    
    [self registerTextFieldViewClass:[UITextView class]
     didBeginEditingNotificationName:UITextViewTextDidBeginEditingNotification
       didEndEditingNotificationName:UITextViewTextDidEndEditingNotification];
    
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willChangeStatusBarOrientation:) name:UIApplicationWillChangeStatusBarOrientationNotification object:[UIApplication sharedApplication]];
#pragma clang diagnostic pop
}

-(void)unregisterAllNotifications
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];

    
    [self unregisterTextFieldViewClass:[UITextField class]
     didBeginEditingNotificationName:UITextFieldTextDidBeginEditingNotification
       didEndEditingNotificationName:UITextFieldTextDidEndEditingNotification];
    
    
    [self unregisterTextFieldViewClass:[UITextView class]
     didBeginEditingNotificationName:UITextViewTextDidBeginEditingNotification
       didEndEditingNotificationName:UITextViewTextDidEndEditingNotification];
    
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillChangeStatusBarOrientationNotification object:[UIApplication sharedApplication]];
#pragma clang diagnostic pop
}

-(void)showLog:(NSString*)logString
{
    [self showLog:logString indentation:0];
}

-(void)showLog:(NSString*)logString indentation:(NSInteger)indent
{
    static NSInteger indentation = 0;
    
    if (indent < 0)
    {
        indentation = MAX(0, indentation + indent);
    }
    
    if (_enableDebugging)
    {
        NSMutableString *preLog = [[NSMutableString alloc] init];
        
        for (int i = 0; i<=indentation; i++) {
            [preLog appendString:@"|\t"];
        }

        [preLog appendString:logString];
        
    }
    
    if (indent > 0)
    {
        indentation += indent;
    }
}

@end
