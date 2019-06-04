//
//  ShowDownView.m
//  Path
//
//  Created by XianMingYou on 15/2/27.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "PresentDownwardsSee.h"

@interface PresentDownwardsSee ()

@property (nonatomic, strong) PathDirectionView *leftView;
@property (nonatomic, strong) PathDirectionView *rightView;

@end

@implementation PresentDownwardsSee

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        CGFloat width  = frame.size.width / 2.f;
        CGFloat height = frame.size.height;
        
        CGRect leftRect  = CGRectMake(0, 0, width, height);
        CGRect rightRect = CGRectMake(width, 0, width, height);
        
        self.leftView  = [[PathDirectionView alloc] initWithFrame:leftRect];
        self.rightView = [[PathDirectionView alloc] initWithFrame:rightRect];
        self.rightView.startPointAtRight = YES;
        [self addSubview:self.leftView];
        [self addSubview:self.rightView];
    }
    
    return self;
}

- (void)evidencePct:(CGFloat)perCentum {
    
    [self.leftView evidencePct:perCentum];
    [self.rightView evidencePct:perCentum];
}

@end
