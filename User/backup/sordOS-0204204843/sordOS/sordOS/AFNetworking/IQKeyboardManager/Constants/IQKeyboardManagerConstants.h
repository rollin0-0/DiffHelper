






















#ifndef IQKeyboardManagerConstants_h
#define IQKeyboardManagerConstants_h

#import <Foundation/NSObjCRuntime.h>






typedef NS_ENUM(NSInteger, IQAutoToolbarManageBehaviour) {
    IQAutoToolbarBySubviews,
    IQAutoToolbarByTag,
    IQAutoToolbarByPosition,
};


typedef NS_ENUM(NSUInteger, IQPreviousNextDisplayMode) {
    IQPreviousNextDisplayModeDefault,
    IQPreviousNextDisplayModeAlwaysHide,
    IQPreviousNextDisplayModeAlwaysShow,
};


typedef NS_ENUM(NSUInteger, IQEnableMode) {
    IQEnableModeDefault,
    IQEnableModeEnabled,
    IQEnableModeDisabled,
};

#endif


