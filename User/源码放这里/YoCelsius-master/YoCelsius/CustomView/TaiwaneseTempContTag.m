//
//  MinTempContLabel.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/20.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "TaiwaneseTempContTag.h"

@interface TaiwaneseTempContTag ()<NumberCountDelegate>

@end

@implementation TaiwaneseTempContTag

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.matterJudge               = [[UILabel alloc] initWithFrame:self.bounds];
        self.matterJudge.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.matterJudge];
        self.matterJudge.alpha         = 0;
        
        self.amoyTemporaryNumeration          = [MinTempCount new];
        self.amoyTemporaryNumeration.delegate = self;
    }
    
    return self;
}

- (void)telephoneNumberCounting:(NumberCount *)telephoneNumberCounting streamBite:(NSAttributedString *)string {
    
    self.matterJudge.attributedText = string;
}

- (void)renderContinuance:(CGFloat)duration {
    
    self.amoyTemporaryNumeration.fromValue = self.fromValue;
    self.amoyTemporaryNumeration.toValue   = self.toValue;
    self.amoyTemporaryNumeration.duration  = duration;
    
    [self.amoyTemporaryNumeration startAnimation];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.matterJudge.alpha     = 1.f;
    }];
}

- (void)obscureLength:(CGFloat)duration {
    
    self.amoyTemporaryNumeration.fromValue = self.toValue;
    self.amoyTemporaryNumeration.toValue   = 0;
    self.amoyTemporaryNumeration.duration  = duration;
    
    [self.amoyTemporaryNumeration startAnimation];
    
    [UIView animateWithDuration:duration animations:^{
        
        self.matterJudge.alpha     = 0.f;
    }];
}

@end
