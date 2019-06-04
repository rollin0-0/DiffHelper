//
//  UpdatingView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/28.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "UpdateRegard.h"

#define UpdatingHeighy  20.f

@interface UpdatingViewStoreValue : NSObject

@property (nonatomic) CGRect startOutRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect finishRect;

@end

@implementation UpdatingViewStoreValue

@end

@interface UpdateRegard ()
@property (nonatomic, strong) UILabel                 *label;           // 标题
@property (nonatomic, strong) UpdatingViewStoreValue  *labelStoreValue; // 标题存储值

@property (nonatomic, strong) UILabel                 *failRecordingLabel;           // 失败
@property (nonatomic, strong) UpdatingViewStoreValue  *bombLabelStackAwayPrize; // 失败存储值

@property (nonatomic, strong) SnowView                *snow;            // 下雪
@property (nonatomic, strong) UpdatingViewStoreValue  *snowStoreValue;  // 下雪存储值
@end

@implementation UpdateRegard

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(0, 0, Width / 2.f, Width / 2.f + UpdatingHeighy)];
    if (self) {
        
        [self initTag];
        [self initSnow];
        
        // 关闭用户交互
        self.userInteractionEnabled = NO;
    }
    
    return self;
}

- (void)initTag {
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, Width / 2.f, Width / 2.f, UpdatingHeighy)];
    [self addSubview:self.label];
    self.label.textColor        = [UIColor whiteColor];
    self.label.textAlignment    = NSTextAlignmentCenter;
    self.label.font             = [UIFont fontWithName:LATO_LIGHT size:18.f];
    self.label.text             = @"Updating . . .";
    self.label.GCDTimerInterval = @(0.8f);
    self.label.glowDuration     = @(0.7f);
    self.label.glowLayerOpacity = @(1.f);
    [self.label createGlowLayerWithColor:[UIColor whiteColor]
                              glowRadius:2.f];
    [self.label startGlow];
    
    self.labelStoreValue           = [UpdatingViewStoreValue new];
    self.labelStoreValue.midRect   = self.label.frame;
    self.label.x                  -= 30.f;
    self.labelStoreValue.startOutRect = self.label.frame;
    self.label.x                  += 60.f;
    self.labelStoreValue.finishRect   = self.label.frame;
    self.label.frame               = self.labelStoreValue.startOutRect;
    self.label.alpha               = 0.f;
    
    self.failRecordingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Width / 2.f, Width / 2.f, UpdatingHeighy)];
    [self addSubview:self.failRecordingLabel];
    self.failRecordingLabel.textColor        = [UIColor whiteColor];
    self.failRecordingLabel.textAlignment    = NSTextAlignmentCenter;
    self.failRecordingLabel.font             = [UIFont fontWithName:LATO_LIGHT size:24.f];
    self.failRecordingLabel.text             = @"Failed";
    self.failRecordingLabel.GCDTimerInterval = @(0.8f);
    self.failRecordingLabel.glowDuration     = @(0.7f);
    self.failRecordingLabel.glowLayerOpacity = @(1.f);
    [self.failRecordingLabel createGlowLayerWithColor:[UIColor redColor]
                              glowRadius:2.f];
    [self.failRecordingLabel startGlow];
    
    self.bombLabelStackAwayPrize           = [UpdatingViewStoreValue new];
    self.bombLabelStackAwayPrize.midRect   = self.failRecordingLabel.frame;
    self.failRecordingLabel.x                  -= 30.f;
    self.bombLabelStackAwayPrize.startOutRect = self.failRecordingLabel.frame;
    self.failRecordingLabel.x                  += 60.f;
    self.bombLabelStackAwayPrize.finishRect   = self.failRecordingLabel.frame;
    self.failRecordingLabel.frame               = self.bombLabelStackAwayPrize.startOutRect;
    self.failRecordingLabel.alpha               = 0.f;
}

- (void)initSnow {
    
    self.snow = [[SnowView alloc] initWithFrame:CGRectMake(0, 0, Width / 2.f, Width / 2.f)];
    [self addSubview:self.snow];
    self.snow.blowSee  = [UIImage imageNamed:@"snow"];
    self.snow.birthRate  = 20.f;
    self.snow.gravity    = 5.f;
    self.snow.snowColor  = [UIColor whiteColor];
    self.snow.layer.mask = [CALayer createMaskLayerWithSize:CGSizeMake(Width / 2.f, Width / 2.f)
                                               maskPNGImage:[UIImage imageNamed:@"alpha"]];
    [self.snow establishC];
    self.snow.transform  = CGAffineTransformMake(1.4, 0, 0, 1.4, 0, 0);
    self.snow.alpha      = 0.f;
}

- (void)show {
    
    [UIView animateWithDuration:1.f animations:^{
        
        self.snow.alpha      = 1.f;
        self.snow.transform  = CGAffineTransformMake(1.f, 0, 0, 1.f, 0, 0);
        
        self.label.frame     = self.labelStoreValue.midRect;
        self.label.alpha     = 1.f;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:0.75f animations:^{
        
        self.snow.alpha     = 0.f;
        self.snow.transform = CGAffineTransformMake(0.7f, 0, 0, 0.7f, 0, 0);
        
        self.label.frame    = self.labelStoreValue.finishRect;
        self.label.alpha    = 0.f;
        
        self.failRecordingLabel.frame = self.bombLabelStackAwayPrize.finishRect;
        self.failRecordingLabel.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        self.label.frame       = self.labelStoreValue.startOutRect;
        self.snow.transform    = CGAffineTransformMake(1.4, 0, 0, 1.4f, 0, 0);
        self.failRecordingLabel.frame = self.self.bombLabelStackAwayPrize.startOutRect;
    }];
}

- (void)insertIntoView:(UIView *)view {
    
}

- (void)showFailed {
    
    [UIView animateWithDuration:1.5f animations:^{
        
        // 隐藏label标签
        self.label.frame = self.labelStoreValue.finishRect;
        self.label.alpha = 0.f;
        
    } completion:^(BOOL finished) {

        [UIView animateWithDuration:1.f animations:^{
            // 显示failed标签
            self.failRecordingLabel.frame = self.bombLabelStackAwayPrize.midRect;
            self.failRecordingLabel.alpha = 1.f;
            
        } completion:^(BOOL finished) {
            
        }];
    }];
}

@end
