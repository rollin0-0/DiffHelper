//
//  YXEasing.m
//  Prize
//
//  Copyright (c) 2014年 Y.X. All rights reserved.
//

#import "YXEasing.h"

@implementation YXEasing

+ (NSArray *)aimShapeFromTreasure:(CGFloat)fromValue
                             toValue:(CGFloat)toValue
                                Func:(AHEasingFunction)Func
                          skeletonReckoning:(size_t)skeletonReckoning
{
    // 设置帧数量
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:skeletonReckoning];
    
    // 计算并存储
	CGFloat t  = 0.0;
	CGFloat dt = 1.0 / (skeletonReckoning - 1);
	for(size_t frame = 0; frame < skeletonReckoning; ++frame, t += dt)
	{
        // 此处就会根据不同的函数计算出不同的值达到不同的效果
		CGFloat value = fromValue + Func(t) * (toValue - fromValue);
        
        // 将计算结果存储进数组中
		[values addObject:[NSNumber numberWithFloat:(float)value]];
	}
    
    // 数组中存储的数据为 NSNumber float 型
    return values;
}

+ (NSArray *)calculateFrameFromPoint:(CGPoint)fromPoint
                             toPoint:(CGPoint)toPoint
                                Func:(AHEasingFunction)Func
                          skeletonReckoning:(size_t)skeletonReckoning
{
    // 设置帧数量
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:skeletonReckoning];
	
    // 计算并存储
	CGFloat t  = 0.0;
	CGFloat dt = 1.0 / (skeletonReckoning - 1);
	for(size_t frame = 0; frame < skeletonReckoning; ++frame, t += dt)
	{
        // 此处就会根据不同的函数计算出不同的值达到不同的效果
		CGFloat x = fromPoint.x + Func(t) * (toPoint.x - fromPoint.x);
		CGFloat y = fromPoint.y + Func(t) * (toPoint.y - fromPoint.y);
        
        // 将计算结果存储进数组中
		[values addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
	}
    
    // 数组中存储的数据为 NSValue CGPoint 型
    return values;
}

+ (NSArray *)calculateFrameFromSize:(CGSize)fromSize
                             toSize:(CGSize)toSize
                               Func:(AHEasingFunction)Func
                         skeletonReckoning:(size_t)skeletonReckoning
{
    // 设置帧数量
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:skeletonReckoning];
	
    // 计算并存储
	CGFloat t  = 0.0;
	CGFloat dt = 1.0 / (skeletonReckoning - 1);
	for(size_t frame = 0; frame < skeletonReckoning; ++frame, t += dt)
	{
        // 此处就会根据不同的函数计算出不同的值达到不同的效果
		CGFloat w = fromSize.width + Func(t) * (toSize.width - fromSize.width);
		CGFloat h = fromSize.height + Func(t) * (toSize.height - fromSize.height);

        // 将计算结果存储进数组中
		[values addObject:[NSValue valueWithCGSize:CGSizeMake(w, h)]];
    }
    
    // 数组中存储的数据为 NSValue CGSize 型
    return values;
}

@end
