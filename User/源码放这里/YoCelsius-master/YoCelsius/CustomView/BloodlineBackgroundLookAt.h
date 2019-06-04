//
//  LineBackgroundView.h
//  LineBackgroundView
//
//  Created by XianMingYou on 15/3/4.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import <UIKit/UIKit.h>


@interface BloodlineBackgroundLookAt : UIView

@property (nonatomic) CGFloat            lineWidth;
@property (nonatomic) CGFloat            bloodCol;
@property (nonatomic, strong) UIColor   *bloodLineSemblance;

- (void)materialBodyAspect;
+ (instancetype)makeViewWithFrameIn:(CGRect)frame
                          assemblyLineBreadth:(CGFloat)width
                            bloodCol:(CGFloat)bloodCol
                          bloodLineSemblance:(UIColor *)color;

@end
