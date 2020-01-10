






















#import <UIKit/UIView.h>
#import <UIKit/UIViewController.h>
#import "IQKeyboardManagerConstants.h"

@class UICollectionView, UIScrollView, UITableView, UISearchBar, NSArray;


@interface UIView (IQ_UIView_Hierarchy)






@property (nullable, nonatomic, readonly, strong) UIViewController *viewContainingController;


@property (nullable, nonatomic, readonly, strong) UIViewController *topMostController;


@property (nullable, nonatomic, readonly, strong) UIViewController *parentContainerViewController;






-(nullable __kindof UIView*)superviewOfClassType:(nonnull Class)classType belowView:(nullable UIView*)belowView;
-(nullable __kindof UIView*)superviewOfClassType:(nonnull Class)classType;


@property (nonnull, nonatomic, readonly, copy) NSArray<__kindof UIView*> *responderSiblings;


@property (nonnull, nonatomic, readonly, copy) NSArray<__kindof UIView*> *deepResponderViews;






@property (nullable, nonatomic, readonly) UISearchBar *textFieldSearchBar;


@property (nonatomic, getter=isAlertViewTextField, readonly) BOOL alertViewTextField;






-(CGAffineTransform)convertTransformToView:(nullable UIView*)toView;






@property (nonnull, nonatomic, readonly, copy) NSString *subHierarchy;


@property (nonnull, nonatomic, readonly, copy) NSString *superHierarchy;


@property (nonnull, nonatomic, readonly, copy) NSString *debugHierarchy;

@end


@interface UIViewController (IQ_UIView_Hierarchy)

-(nullable UIViewController*)parentIQContainerViewController;

@end


@interface NSObject (IQ_Logging)


@property (nonnull, nonatomic, readonly, copy) NSString *_IQDescription;

@end
