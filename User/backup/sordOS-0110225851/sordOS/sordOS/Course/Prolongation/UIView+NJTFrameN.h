







#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define IPHONEX_SERIES \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define kScreen_Width  [UIScreen mainScreen].bounds.size.width

#define kScreen_Height [UIScreen mainScreen].bounds.size.height

#define kIphoneStatus_Height    (IPHONEX_SERIES? 44:20)
#define kIphoneLandscape_Inset  (IPHONEX_SERIES ? (UIEdgeInsetsMake(32,44,21,44)) : UIEdgeInsetsZero)
#define kIphonePortrait_Inset   (IPHONEX_SERIES ? (UIEdgeInsetsMake(44,0,34,0)) : UIEdgeInsetsZero)

@interface UIView (NJTFrameN)

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGSize size;
@property (nonatomic) CGPoint origin;


@end

NS_ASSUME_NONNULL_END
