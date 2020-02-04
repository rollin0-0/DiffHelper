






















#import "IQUIViewController+Additions.h"
#import <UIKit/NSLayoutConstraint.h>
#import <objc/runtime.h>

@implementation UIViewController (Additions)

-(void)setIQLayoutGuideConstraint:(NSLayoutConstraint *)IQLayoutGuideConstraint
{
    objc_setAssociatedObject(self, @selector(IQLayoutGuideConstraint), IQLayoutGuideConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSLayoutConstraint *)IQLayoutGuideConstraint
{
    return objc_getAssociatedObject(self, @selector(IQLayoutGuideConstraint));
}

@end
