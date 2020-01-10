






















#import "IQUITextFieldView+Additions.h"
#import <objc/runtime.h>

@implementation UIView (Additions)

-(void)setKeyboardDistanceFromTextField:(CGFloat)keyboardDistanceFromTextField
{
    
    keyboardDistanceFromTextField = MAX(keyboardDistanceFromTextField, 0);
    
    objc_setAssociatedObject(self, @selector(keyboardDistanceFromTextField), @(keyboardDistanceFromTextField), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)keyboardDistanceFromTextField
{
    NSNumber *keyboardDistanceFromTextField = objc_getAssociatedObject(self, @selector(keyboardDistanceFromTextField));
    
    return (keyboardDistanceFromTextField != nil)?[keyboardDistanceFromTextField floatValue]:kIQUseDefaultKeyboardDistance;
}

-(void)setIgnoreSwitchingByNextPrevious:(BOOL)ignoreSwitchingByNextPrevious
{
    objc_setAssociatedObject(self, @selector(ignoreSwitchingByNextPrevious), @(ignoreSwitchingByNextPrevious), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)ignoreSwitchingByNextPrevious
{
    NSNumber *ignoreSwitchingByNextPrevious = objc_getAssociatedObject(self, @selector(ignoreSwitchingByNextPrevious));
    
    return [ignoreSwitchingByNextPrevious boolValue];
}

-(void)setEnableMode:(IQEnableMode)enableMode
{
    objc_setAssociatedObject(self, @selector(enableMode), @(enableMode), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(IQEnableMode)enableMode
{
    NSNumber *enableMode = objc_getAssociatedObject(self, @selector(enableMode));
    
    return [enableMode unsignedIntegerValue];
}

-(void)setShouldResignOnTouchOutsideMode:(IQEnableMode)shouldResignOnTouchOutsideMode
{
    objc_setAssociatedObject(self, @selector(shouldResignOnTouchOutsideMode), @(shouldResignOnTouchOutsideMode), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(IQEnableMode)shouldResignOnTouchOutsideMode
{
    NSNumber *shouldResignOnTouchOutsideMode = objc_getAssociatedObject(self, @selector(shouldResignOnTouchOutsideMode));
    
    return [shouldResignOnTouchOutsideMode unsignedIntegerValue];
}

@end






CGFloat const kIQUseDefaultKeyboardDistance = CGFLOAT_MAX;

