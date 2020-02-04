






















#import "IQTitleBarButtonItem.h"

#import <UIKit/UIToolbar.h>
#import <UIKit/UIDevice.h>


@interface IQToolbar : UIToolbar <UIInputViewAudioFeedback>


@property(nonnull, nonatomic, strong) IQBarButtonItem *previousBarButton;


@property(nonnull, nonatomic, strong) IQBarButtonItem *nextBarButton;


@property(nonnull, nonatomic, strong, readonly) IQTitleBarButtonItem *titleBarButton;


@property(nonnull, nonatomic, strong) IQBarButtonItem *doneBarButton;


@property(nonnull, nonatomic, strong) IQBarButtonItem *fixedSpaceBarButton;

@end

