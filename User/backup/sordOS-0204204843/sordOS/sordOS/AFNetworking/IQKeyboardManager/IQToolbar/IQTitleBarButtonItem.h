






















#import "IQKeyboardManagerConstants.h"
#import "IQBarButtonItem.h"

#import <Foundation/NSObjCRuntime.h>


@interface IQTitleBarButtonItem : IQBarButtonItem


@property(nullable, nonatomic, strong) UIFont *titleFont;


@property(nullable, nonatomic, strong) UIColor *titleColor;


@property(nullable, nonatomic, strong) UIColor *selectableTitleColor;


-(nonnull instancetype)initWithTitle:(nullable NSString *)title NS_DESIGNATED_INITIALIZER;


-(nonnull instancetype)init NS_UNAVAILABLE;


-(nonnull instancetype)initWithCoder:(nullable NSCoder *)aDecoder NS_UNAVAILABLE;


+ (nonnull instancetype)new NS_UNAVAILABLE;

@end
