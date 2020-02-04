






















#import "IQUIScrollView+Additions.h"
#import <objc/runtime.h>

@implementation UIScrollView (Additions)

-(void)setShouldIgnoreScrollingAdjustment:(BOOL)shouldIgnoreScrollingAdjustment
{
    objc_setAssociatedObject(self, @selector(shouldIgnoreScrollingAdjustment), @(shouldIgnoreScrollingAdjustment), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)shouldIgnoreScrollingAdjustment
{
    NSNumber *shouldIgnoreScrollingAdjustment = objc_getAssociatedObject(self, @selector(shouldIgnoreScrollingAdjustment));
    
    return [shouldIgnoreScrollingAdjustment boolValue];
}

-(void)setShouldRestoreScrollViewContentOffset:(BOOL)shouldRestoreScrollViewContentOffset
{
    objc_setAssociatedObject(self, @selector(shouldRestoreScrollViewContentOffset), @(shouldRestoreScrollViewContentOffset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)shouldRestoreScrollViewContentOffset
{
    NSNumber *shouldRestoreScrollViewContentOffset = objc_getAssociatedObject(self, @selector(shouldRestoreScrollViewContentOffset));
    
    return [shouldRestoreScrollViewContentOffset boolValue];
}

@end

@implementation UITableView (PreviousNextIndexPath)

-(nullable NSIndexPath*)previousIndexPathOfIndexPath:(nonnull NSIndexPath*)indexPath
{
    NSInteger previousRow = indexPath.row - 1;
    NSInteger previousSection = indexPath.section;
    
    
    if (previousRow < 0)
    {
        previousSection -= 1;
        
        if (previousSection >= 0)
        {
            previousRow = [self numberOfRowsInSection:previousSection]-1;
        }
    }
    
    if (previousRow >= 0 && previousSection >= 0)
    {
        return [NSIndexPath indexPathForRow:previousRow inSection:previousSection];
    }
    
    return nil;
}





















@end

@implementation UICollectionView (PreviousNextIndexPath)

-(nullable NSIndexPath*)previousIndexPathOfIndexPath:(nonnull NSIndexPath*)indexPath
{
    NSInteger previousRow = indexPath.row - 1;
    NSInteger previousSection = indexPath.section;
    
    
    if (previousRow < 0)
    {
        previousSection -= 1;
        
        if (previousSection >= 0)
        {
            previousRow = [self numberOfItemsInSection:previousSection]-1;
        }
    }
    
    if (previousRow >= 0 && previousSection >= 0)
    {
        return [NSIndexPath indexPathForItem:previousRow inSection:previousSection];
    }
    
    return nil;
}





















@end
