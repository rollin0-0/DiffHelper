






















#import "IQKeyboardManagerConstants.h"

#import <Foundation/NSObject.h>
#import <Foundation/NSObjCRuntime.h>

#import <UIKit/UITextInputTraits.h>

@class UITextField, UIView, UIViewController;
@protocol UITextFieldDelegate, UITextViewDelegate;


@interface IQKeyboardReturnKeyHandler : NSObject






-(nonnull instancetype)initWithViewController:(nullable UIViewController*)controller NS_DESIGNATED_INITIALIZER;


-(nonnull instancetype)initWithCoder:(nullable NSCoder *)aDecoder NS_UNAVAILABLE;






@property(nullable, nonatomic, weak) id<UITextFieldDelegate,UITextViewDelegate> delegate;


@property(nonatomic, assign) UIReturnKeyType lastTextFieldReturnKeyType;






-(void)addTextFieldView:(nonnull UIView*)textFieldView;


-(void)removeTextFieldView:(nonnull UIView*)textFieldView;


-(void)addResponderFromView:(nonnull UIView*)view;


-(void)removeResponderFromView:(nonnull UIView*)view;

@end
