







#import <Foundation/Foundation.h>

#define isServiceVerify 1

typedef enum: NSUInteger {
EPaymentTransactionStateNoPaymentPermission,
EPaymentTransactionStateAddPaymentFailed,
EPaymentTransactionStatePurchasing,
EPaymentTransactionStatePurchased,
EPaymentTransactionStateFailed,
EPaymentTransactionStateCancel,
EPaymentTransactionStateRestored,
EPaymentTransactionStateDeferred,
} EPaymentTransactionState;



@class SKProduct;
@class SKPaymentTransaction;

@protocol EInAppPurchasingDelegate <NSObject>

@required

- (BOOL)isProductIdentifierAvailable:(NSString*)productIdentifier;

@optional


- (void)updatedTransactions:(EPaymentTransactionState)state;


- (void)buySuccess:(SKPaymentTransaction*)transaction;


- (void)buyFailed:(NSError*)errorInfo;

@end

@interface YAPBManagerY :NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, weak) id<EInAppPurchasingDelegate> delegate;


- (void)identifyCanMakePayments:(NSArray*)requestArray;

@end



