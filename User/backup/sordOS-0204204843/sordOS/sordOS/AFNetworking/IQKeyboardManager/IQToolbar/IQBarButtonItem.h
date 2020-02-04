






















#import <UIKit/UIBarButtonItem.h>

@class NSInvocation;


@interface IQBarButtonItem : UIBarButtonItem


@property (nonatomic, readonly) BOOL isSystemItem;


-(void)setTarget:(nullable id)target action:(nullable SEL)action;


@property (nullable, strong, nonatomic) NSInvocation *invocation;

@end
