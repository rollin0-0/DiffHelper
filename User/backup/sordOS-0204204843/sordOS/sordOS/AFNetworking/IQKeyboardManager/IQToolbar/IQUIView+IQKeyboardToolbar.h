






















#import "IQToolbar.h"

#import <UIKit/UIView.h>
#import <UIKit/UIImage.h>

@interface IQBarButtonItemConfiguration : NSObject

-(nonnull instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)barButtonSystemItem action:(nullable SEL)action;
-(nonnull instancetype)initWithImage:(nonnull UIImage*)image action:(nullable SEL)action;
-(nonnull instancetype)initWithTitle:(nonnull NSString*)title action:(nullable SEL)action;

@property (readonly, nonatomic) UIBarButtonSystemItem barButtonSystemItem; 
@property (readonly, nonatomic, nullable) UIImage *image;    
@property (readonly, nonatomic, nullable) NSString *title; 
@property (readonly, nonatomic, nullable) SEL action;  

@end

@interface UIImage (IQKeyboardToolbarNextPreviousImage)

+(nullable UIImage*)keyboardPreviousiOS9Image;
+(nullable UIImage*)keyboardNextiOS9Image;
+(nullable UIImage*)keyboardPreviousiOS10Image;
+(nullable UIImage*)keyboardNextiOS10Image;

+(nullable UIImage*)keyboardPreviousImage;
+(nullable UIImage*)keyboardNextImage;

@end


@interface UIView (IQToolbarAddition)






@property (readonly, nonatomic, nonnull) IQToolbar *keyboardToolbar;


@property (assign, nonatomic) BOOL shouldHideToolbarPlaceholder;


@property (nullable, strong, nonatomic) NSString* toolbarPlaceholder;


@property (nullable, strong, nonatomic, readonly) NSString* drawingToolbarPlaceholder;





- (void)addKeyboardToolbarWithTarget:(nullable id)target titleText:(nullable NSString*)titleText rightBarButtonConfiguration:(nullable IQBarButtonItemConfiguration*)rightBarButtonConfiguration previousBarButtonConfiguration:(nullable IQBarButtonItemConfiguration*)previousBarButtonConfiguration nextBarButtonConfiguration:(nullable IQBarButtonItemConfiguration*)nextBarButtonConfiguration;





- (void)addDoneOnKeyboardWithTarget:(nullable id)target action:(nullable SEL)action;
- (void)addDoneOnKeyboardWithTarget:(nullable id)target action:(nullable SEL)action shouldShowPlaceholder:(BOOL)shouldShowPlaceholder;
- (void)addDoneOnKeyboardWithTarget:(nullable id)target action:(nullable SEL)action titleText:(nullable NSString*)titleText;





- (void)addRightButtonOnKeyboardWithText:(nullable NSString*)text target:(nullable id)target action:(nullable SEL)action;
- (void)addRightButtonOnKeyboardWithText:(nullable NSString*)text target:(nullable id)target action:(nullable SEL)action shouldShowPlaceholder:(BOOL)shouldShowPlaceholder;
- (void)addRightButtonOnKeyboardWithText:(nullable NSString*)text target:(nullable id)target action:(nullable SEL)action titleText:(nullable NSString*)titleText;

- (void)addRightButtonOnKeyboardWithImage:(nullable UIImage*)image target:(nullable id)target action:(nullable SEL)action;
- (void)addRightButtonOnKeyboardWithImage:(nullable UIImage*)image target:(nullable id)target action:(nullable SEL)action shouldShowPlaceholder:(BOOL)shouldShowPlaceholder;
- (void)addRightButtonOnKeyboardWithImage:(nullable UIImage*)image target:(nullable id)target action:(nullable SEL)action titleText:(nullable NSString*)titleText;





- (void)addCancelDoneOnKeyboardWithTarget:(nullable id)target cancelAction:(nullable SEL)cancelAction doneAction:(nullable SEL)doneAction;
- (void)addCancelDoneOnKeyboardWithTarget:(nullable id)target cancelAction:(nullable SEL)cancelAction doneAction:(nullable SEL)doneAction shouldShowPlaceholder:(BOOL)shouldShowPlaceholder;
- (void)addCancelDoneOnKeyboardWithTarget:(nullable id)target cancelAction:(nullable SEL)cancelAction doneAction:(nullable SEL)doneAction titleText:(nullable NSString*)titleText;





- (void)addLeftRightOnKeyboardWithTarget:(nullable id)target leftButtonTitle:(nullable NSString*)leftButtonTitle rightButtonTitle:(nullable NSString*)rightButtonTitle leftButtonAction:(nullable SEL)leftButtonAction rightButtonAction:(nullable SEL)rightButtonAction;
- (void)addLeftRightOnKeyboardWithTarget:(nullable id)target leftButtonTitle:(nullable NSString*)leftButtonTitle rightButtonTitle:(nullable NSString*)rightButtonTitle leftButtonAction:(nullable SEL)leftButtonAction rightButtonAction:(nullable SEL)rightButtonAction shouldShowPlaceholder:(BOOL)shouldShowPlaceholder;
- (void)addLeftRightOnKeyboardWithTarget:(nullable id)target leftButtonTitle:(nullable NSString*)leftButtonTitle rightButtonTitle:(nullable NSString*)rightButtonTitle leftButtonAction:(nullable SEL)leftButtonAction rightButtonAction:(nullable SEL)rightButtonAction titleText:(nullable NSString*)titleText;





- (void)addPreviousNextDoneOnKeyboardWithTarget:(nullable id)target previousAction:(nullable SEL)previousAction nextAction:(nullable SEL)nextAction doneAction:(nullable SEL)doneAction;
- (void)addPreviousNextDoneOnKeyboardWithTarget:(nullable id)target previousAction:(nullable SEL)previousAction nextAction:(nullable SEL)nextAction doneAction:(nullable SEL)doneAction shouldShowPlaceholder:(BOOL)shouldShowPlaceholder;
- (void)addPreviousNextDoneOnKeyboardWithTarget:(nullable id)target previousAction:(nullable SEL)previousAction nextAction:(nullable SEL)nextAction doneAction:(nullable SEL)doneAction titleText:(nullable NSString*)titleText;





- (void)addPreviousNextRightOnKeyboardWithTarget:(nullable id)target rightButtonTitle:(nullable NSString*)rightButtonTitle previousAction:(nullable SEL)previousAction nextAction:(nullable SEL)nextAction rightButtonAction:(nullable SEL)rightButtonAction;
- (void)addPreviousNextRightOnKeyboardWithTarget:(nullable id)target rightButtonTitle:(nullable NSString*)rightButtonTitle previousAction:(nullable SEL)previousAction nextAction:(nullable SEL)nextAction rightButtonAction:(nullable SEL)rightButtonAction shouldShowPlaceholder:(BOOL)shouldShowPlaceholder;
- (void)addPreviousNextRightOnKeyboardWithTarget:(nullable id)target rightButtonTitle:(nullable NSString*)rightButtonTitle previousAction:(nullable SEL)previousAction nextAction:(nullable SEL)nextAction rightButtonAction:(nullable SEL)rightButtonAction titleText:(nullable NSString*)titleText;

- (void)addPreviousNextRightOnKeyboardWithTarget:(nullable id)target rightButtonImage:(nullable UIImage*)rightButtonImage previousAction:(nullable SEL)previousAction nextAction:(nullable SEL)nextAction rightButtonAction:(nullable SEL)rightButtonAction;
- (void)addPreviousNextRightOnKeyboardWithTarget:(nullable id)target rightButtonImage:(nullable UIImage*)rightButtonImage previousAction:(nullable SEL)previousAction nextAction:(nullable SEL)nextAction rightButtonAction:(nullable SEL)rightButtonAction shouldShowPlaceholder:(BOOL)shouldShowPlaceholder;
- (void)addPreviousNextRightOnKeyboardWithTarget:(nullable id)target rightButtonImage:(nullable UIImage*)rightButtonImage previousAction:(nullable SEL)previousAction nextAction:(nullable SEL)nextAction rightButtonAction:(nullable SEL)rightButtonAction titleText:(nullable NSString*)titleText;

@end


