






















#import "IQKeyboardManagerConstants.h"
#import "IQUIView+IQKeyboardToolbar.h"
#import "IQPreviousNextView.h"
#import "IQUIViewController+Additions.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "IQTextView.h"
#import "IQToolbar.h"
#import "IQUIScrollView+Additions.h"
#import "IQUITextFieldView+Additions.h"
#import "IQBarButtonItem.h"
#import "IQTitleBarButtonItem.h"
#import "IQUIView+Hierarchy.h"

#import <CoreGraphics/CGBase.h>

#import <Foundation/NSObject.h>
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSSet.h>

#import <UIKit/UITextInputTraits.h>

@class UIFont, UIColor, UITapGestureRecognizer, UIView, UIImage;

@class NSString;






extern NSInteger const kIQDoneButtonToolbarTag;


extern NSInteger const kIQPreviousNextButtonToolbarTag;




@interface IQKeyboardManager : NSObject






+ (nonnull instancetype)sharedManager;


@property(nonatomic, assign, getter = isEnabled) BOOL enable;


@property(nonatomic, assign) CGFloat keyboardDistanceFromTextField;


- (void)reloadLayoutIfNeeded;


@property(nonatomic, assign, readonly, getter = isKeyboardShowing) BOOL  keyboardShowing;


@property(nonatomic, assign, readonly) CGFloat movedDistance;


@property(nullable, nonatomic, copy) void (^movedDistanceChanged)(CGFloat movedDistance);






@property(nonatomic, assign, getter = isEnableAutoToolbar) BOOL enableAutoToolbar;


@property(nonatomic, assign) IQAutoToolbarManageBehaviour toolbarManageBehaviour;


@property(nonatomic, assign) BOOL shouldToolbarUsesTextFieldTintColor;


@property(nullable, nonatomic, strong) UIColor *toolbarTintColor;


@property(nullable, nonatomic, strong) UIColor *toolbarBarTintColor;


@property(nonatomic, assign) IQPreviousNextDisplayMode previousNextDisplayMode;


@property(nullable, nonatomic, strong) UIImage *toolbarPreviousBarButtonItemImage;
@property(nullable, nonatomic, strong) UIImage *toolbarNextBarButtonItemImage;
@property(nullable, nonatomic, strong) UIImage *toolbarDoneBarButtonItemImage;


@property(nullable, nonatomic, strong) NSString *toolbarPreviousBarButtonItemText;
@property(nullable, nonatomic, strong) NSString *toolbarPreviousBarButtonItemAccessibilityLabel;
@property(nullable, nonatomic, strong) NSString *toolbarNextBarButtonItemText;
@property(nullable, nonatomic, strong) NSString *toolbarNextBarButtonItemAccessibilityLabel;
@property(nullable, nonatomic, strong) NSString *toolbarDoneBarButtonItemText;
@property(nullable, nonatomic, strong) NSString *toolbarDoneBarButtonItemAccessibilityLabel;


@property(nonatomic, assign) BOOL shouldShowToolbarPlaceholder;


@property(nullable, nonatomic, strong) UIFont *placeholderFont;


@property(nullable, nonatomic, strong) UIColor *placeholderColor;


@property(nullable, nonatomic, strong) UIColor *placeholderButtonColor;


- (void)reloadInputViews;






@property(nonatomic, assign) BOOL overrideKeyboardAppearance;


@property(nonatomic, assign) UIKeyboardAppearance keyboardAppearance;






@property(nonatomic, assign) BOOL shouldResignOnTouchOutside;


@property(nonnull, nonatomic, strong, readonly) UITapGestureRecognizer  *resignFirstResponderGesture;


- (BOOL)resignFirstResponder;


@property (nonatomic, readonly) BOOL canGoPrevious;


@property (nonatomic, readonly) BOOL canGoNext;


- (BOOL)goPrevious;


- (BOOL)goNext;






@property(nonatomic, assign) BOOL shouldPlayInputClicks;






@property(nonatomic, assign) BOOL layoutIfNeededOnUpdate;






@property(nonatomic, strong, nonnull, readonly) NSMutableSet<Class> *disabledDistanceHandlingClasses;


@property(nonatomic, strong, nonnull, readonly) NSMutableSet<Class> *enabledDistanceHandlingClasses;


@property(nonatomic, strong, nonnull, readonly) NSMutableSet<Class> *disabledToolbarClasses;


@property(nonatomic, strong, nonnull, readonly) NSMutableSet<Class> *enabledToolbarClasses;


@property(nonatomic, strong, nonnull, readonly) NSMutableSet<Class> *toolbarPreviousNextAllowedClasses;


@property(nonatomic, strong, nonnull, readonly) NSMutableSet<Class> *disabledTouchResignedClasses;


@property(nonatomic, strong, nonnull, readonly) NSMutableSet<Class> *enabledTouchResignedClasses;


@property(nonatomic, strong, nonnull, readonly) NSMutableSet<Class> *touchResignedGestureIgnoreClasses;







-(void)registerTextFieldViewClass:(nonnull Class)aClass
  didBeginEditingNotificationName:(nonnull NSString *)didBeginEditingNotificationName
    didEndEditingNotificationName:(nonnull NSString *)didEndEditingNotificationName;
-(void)unregisterTextFieldViewClass:(nonnull Class)aClass
    didBeginEditingNotificationName:(nonnull NSString *)didBeginEditingNotificationName
      didEndEditingNotificationName:(nonnull NSString *)didEndEditingNotificationName;





@property(nonatomic, assign) BOOL enableDebugging;


-(void)registerAllNotifications;
-(void)unregisterAllNotifications;






-(nonnull instancetype)init NS_UNAVAILABLE;


+ (nonnull instancetype)new NS_UNAVAILABLE;

@end
