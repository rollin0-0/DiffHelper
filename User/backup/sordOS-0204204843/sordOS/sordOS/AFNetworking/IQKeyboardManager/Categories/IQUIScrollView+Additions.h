






















#import <UIKit/UITableView.h>
#import <UIKit/UICollectionView.h>


@interface UIScrollView (Additions)


@property(nonatomic, assign) BOOL shouldIgnoreScrollingAdjustment;


@property(nonatomic, assign) BOOL shouldRestoreScrollViewContentOffset;


@end

@interface UITableView (PreviousNextIndexPath)

-(nullable NSIndexPath*)previousIndexPathOfIndexPath:(nonnull NSIndexPath*)indexPath;


@end

@interface UICollectionView (PreviousNextIndexPath)

-(nullable NSIndexPath*)previousIndexPathOfIndexPath:(nonnull NSIndexPath*)indexPath;


@end
