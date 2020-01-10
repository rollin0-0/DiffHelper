






















#import <UIKit/UIViewController.h>

@class NSLayoutConstraint;

@interface UIViewController (Additions)


@property(nullable, nonatomic, strong) IBOutlet NSLayoutConstraint *IQLayoutGuideConstraint __attribute__((deprecated("Due to change in core-logic of handling distance between textField and keyboard distance, this layout contraint tweak is no longer needed and things will just work out of the box regardless of constraint pinned with safeArea/layoutGuide/superview.")));

@end
