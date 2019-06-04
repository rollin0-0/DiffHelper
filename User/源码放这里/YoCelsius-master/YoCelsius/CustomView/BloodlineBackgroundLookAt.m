//
//  LineBackgroundView.m
//  LineBackgroundView
//
//  Created by XianMingYou on 15/3/4.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "BloodlineBackgroundLookAt.h"

// 将度数转换为弧度
#define   Rad(degrees)  ((M_PI * (degrees))/ 180.f)

@interface BloodlineBackgroundLookAt ()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation BloodlineBackgroundLookAt

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.layer.masksToBounds = YES;
    }
    
    return self;
}

- (void)materialBodyAspect {
    
    if (self.bloodCol <= 0 && self.lineWidth <= 0) {
        
        return;
    }
    
    // 获取长度
    CGFloat width  = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat containerViewWidth = (width + height) * 0.75;
    
    // 初始化containView
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                  containerViewWidth,
                                                                  containerViewWidth)];
    self.containerView.layer.borderWidth = 1.f;
    self.containerView.center            = CGPointMake(self.bounds.size.width / 2.f,
                                                       self.bounds.size.height / 2.f);
    
    NSInteger lineViewCount = containerViewWidth / (self.bloodCol + self.lineWidth);
    
    for (int count = 0; count < lineViewCount + 1; count++) {
        
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(count * (self.bloodCol + self.lineWidth),
                                                                    0,
                                                                    self.lineWidth,
                                                                    containerViewWidth)];
        if (self.bloodLineSemblance) {
            
            tempView.backgroundColor = self.bloodLineSemblance;
            
        } else {
            
            tempView.backgroundColor = [UIColor blackColor];
        }

        [self.containerView addSubview:tempView];
    }
    
    self.containerView.transform = CGAffineTransformRotate(self.containerView.transform, Rad(45));
    [self addSubview:self.containerView];
}

+ (instancetype)makeViewWithFrameIn:(CGRect)frame
                          assemblyLineBreadth:(CGFloat)width
                            bloodCol:(CGFloat)bloodCol
                          bloodLineSemblance:(UIColor *)color {
    
    BloodlineBackgroundLookAt *bgView = [[BloodlineBackgroundLookAt alloc] initWithFrame:frame];
    bgView.lineWidth           = width;
    bgView.bloodCol             = bloodCol;
    bgView.bloodLineSemblance           = color;
    [bgView materialBodyAspect];

    return bgView;
}

@end
