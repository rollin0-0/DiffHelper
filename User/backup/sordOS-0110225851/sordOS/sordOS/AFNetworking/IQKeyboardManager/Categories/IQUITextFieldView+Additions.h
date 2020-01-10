






















#import <UIKit/UIView.h>
#import "IQKeyboardManagerConstants.h"



@interface UIView (Additions)


@property(nonatomic, assign) CGFloat keyboardDistanceFromTextField;


@property(nonatomic, assign) BOOL ignoreSwitchingByNextPrevious;




@property(nonatomic, assign) IQEnableMode enableMode;


@property(nonatomic, assign) IQEnableMode shouldResignOnTouchOutsideMode;

@end






extern CGFloat const kIQUseDefaultKeyboardDistance;
