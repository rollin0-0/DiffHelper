




















#import "UIActivityIndicatorView+AFNetworking.h"
#import <objc/runtime.h>

#if TARGET_OS_IOS || TARGET_OS_TV

#import "AFURLSessionManager.h"

@interface AFActivityIndicatorViewNotificationObserver : NSObject
@property (readonly, nonatomic, weak) UIActivityIndicatorView *activityIndicatorView;
- (instancetype)initWithActivityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView;

- (void)setAnimatingWithStateOfTask:(NSURLSessionTask *)task;

@end

@implementation UIActivityIndicatorView (AFNetworking)

- (AFActivityIndicatorViewNotificationObserver *)af_notificationObserver {
    AFActivityIndicatorViewNotificationObserver *notificationObserver = objc_getAssociatedObject(self, @selector(af_notificationObserver));
    if (notificationObserver == nil) {
        notificationObserver = [[AFActivityIndicatorViewNotificationObserver alloc] initWithActivityIndicatorView:self];
        objc_setAssociatedObject(self, @selector(af_notificationObserver), notificationObserver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return notificationObserver;
}

- (void)setAnimatingWithStateOfTask:(NSURLSessionTask *)task {
    [[self af_notificationObserver] setAnimatingWithStateOfTask:task];
}

@end

@implementation AFActivityIndicatorViewNotificationObserver

- (instancetype)initWithActivityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView
{
    self = [super init];
    if (self) {
        _activityIndicatorView = activityIndicatorView;
    }
    return self;
}

- (void)setAnimatingWithStateOfTask:(NSURLSessionTask *)task {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];

    [notificationCenter removeObserver:self name:AFNetworkingTaskDidResumeNotification object:nil];
    [notificationCenter removeObserver:self name:AFNetworkingTaskDidSuspendNotification object:nil];
    [notificationCenter removeObserver:self name:AFNetworkingTaskDidCompleteNotification object:nil];
    
    if (task) {
        if (task.state != NSURLSessionTaskStateCompleted) {
            UIActivityIndicatorView *activityIndicatorView = self.activityIndicatorView;
            if (task.state == NSURLSessionTaskStateRunning) {
                [activityIndicatorView startAnimating];
            } else {
                [activityIndicatorView stopAnimating];
            }

            [notificationCenter addObserver:self selector:@selector(af_startAnimating) name:AFNetworkingTaskDidResumeNotification object:task];
            [notificationCenter addObserver:self selector:@selector(af_stopAnimating) name:AFNetworkingTaskDidCompleteNotification object:task];
            [notificationCenter addObserver:self selector:@selector(af_stopAnimating) name:AFNetworkingTaskDidSuspendNotification object:task];
        }
    }
}


- (void)af_startAnimating {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicatorView startAnimating];
    });
}

- (void)af_stopAnimating {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicatorView stopAnimating];
    });
}


- (void)dealloc {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter removeObserver:self name:AFNetworkingTaskDidCompleteNotification object:nil];
    [notificationCenter removeObserver:self name:AFNetworkingTaskDidResumeNotification object:nil];
    [notificationCenter removeObserver:self name:AFNetworkingTaskDidSuspendNotification object:nil];
}

@end

#endif
