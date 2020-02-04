







#import "YAPBManagerY.h"
#import  <StoreKit/StoreKit.h>

#if TARGET_IPHONE_SIMULATOR


#define ITMS_VERIFY_RECEIPT_URL    @""
#elif TARGET_OS_IPHONE

#define ITMS_VERIFY_RECEIPT_URL @""
#endif

@interface YAPBManagerY ()<SKProductsRequestDelegate,SKPaymentTransactionObserver>

@property (nonatomic, strong) SKProductsRequest *request;
@property (nonatomic, strong) NSString *keyString;

@end


@implementation YAPBManagerY

+ (instancetype)sharedInstance{
    static YAPBManagerY *_YAPBManagerY = nil;
          static dispatch_once_t onceToken;
          dispatch_once(&onceToken, ^{
              _YAPBManagerY = [[super allocWithZone:NULL] init];
          });
          return _YAPBManagerY;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [YAPBManagerY sharedInstance];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [YAPBManagerY sharedInstance];
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [YAPBManagerY sharedInstance];
}

- (instancetype)init
{
    self= [super init];
    if(self) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;

}

- (void)dealloc
{
    [self releaseRequest];
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (void)releaseRequest
{
    if(_request) {
        [_request cancel];
        _request.delegate=nil;
        _request=nil;
        
    }
}

- (void)identifyCanMakePayments:(NSArray*)requestArray
{
    if(requestArray.count==0) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(updatedTransactions:)]) {
            [self.delegate updatedTransactions:EPaymentTransactionStateAddPaymentFailed];
        }
        return;
    }

    if ([SKPaymentQueue canMakePayments]) {
        OnceModel *model = [OnceModel defaultModel];
        WeakObject(self)
        [[BespeakManager defaultManager] newsRequsetWithExtensionBody:model successBlock:^(NSDictionary *repsonse) {
            StrongObject(self)
            strongObject.keyString = [[repsonse objectForKey:@"data"]  objectForKey:@"syntax"];
            if (strongObject.keyString==nil) {
                if(strongObject.delegate&& [strongObject.delegate respondsToSelector:@selector(updatedTransactions:)]) {
                    [strongObject.delegate updatedTransactions:EPaymentTransactionStateAddPaymentFailed];
                }
            }else{
                [strongObject releaseRequest];
                strongObject.request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithArray:requestArray]];
                strongObject.request.delegate=self;
                [strongObject.request start];
            }
            
        } failure:^(NSError *error) {
            
        }];
        
    }
    else
    {
        if(self.delegate&& [self.delegate respondsToSelector:@selector(updatedTransactions:)]) {
            [self.delegate updatedTransactions:EPaymentTransactionStateNoPaymentPermission];
        }
    }
}




- (void)productsRequest:(SKProductsRequest*)request didReceiveResponse:(SKProductsResponse*)response

{

    

    NSArray * myProducts = response.products;
    for(SKProduct*product in myProducts){
        
        
        
        
        
    }
    
    if(myProducts && myProducts.count>0) {
        SKProduct*product = [myProducts objectAtIndex:0];
        if(self.delegate && [self.delegate respondsToSelector:@selector(isProductIdentifierAvailable:)]) {
            if ([self.delegate isProductIdentifierAvailable:product.productIdentifier]) {
                SKPayment*payment = [SKPayment paymentWithProduct:product];
                [[SKPaymentQueue defaultQueue] addPayment:payment];
                return;
            }
        }
    }

    if(self.delegate && [self.delegate respondsToSelector:@selector(updatedTransactions:)]) {
        [self.delegate updatedTransactions:EPaymentTransactionStateAddPaymentFailed];
    }
}



- (void)request:(SKRequest*)request didFailWithError:(NSError*)error{
    
}



- (void)paymentQueue:(SKPaymentQueue*)queue updatedTransactions:(NSArray *)transactions
{
    for(SKPaymentTransaction *transaction in transactions)
    {
        EPaymentTransactionState state;
        switch(transaction.transactionState){
            case SKPaymentTransactionStatePurchasing:
            {
                
                state =EPaymentTransactionStatePurchasing;
            }
                break;
            case SKPaymentTransactionStatePurchased:
            {
                state =EPaymentTransactionStatePurchased;
                
                if(isServiceVerify) {
                    [self completeTransaction:transaction];
                }else{
                    
                    [self verifyPurchase:transaction];
                }
            }
                break;
            case SKPaymentTransactionStateFailed:
                {
                
                if(transaction.error.code!=SKErrorPaymentCancelled)
                {
                    state =EPaymentTransactionStateFailed;
                }else{
                    state =EPaymentTransactionStateCancel;
                }
                [self finshTransaction:transaction];
            }
                break;
                case SKPaymentTransactionStateRestored:
            {
                state =EPaymentTransactionStateRestored;
                
                [self finshTransaction:transaction];
            }
                break;

            case SKPaymentTransactionStateDeferred:
            {
                state =EPaymentTransactionStateDeferred;
            }
                break;

            default:

            break;

        }

        if(self.delegate&& [self.delegate respondsToSelector:@selector(updatedTransactions:)]) {
            [self.delegate updatedTransactions:state];
        }
    }

}



- (void)paymentQueue:(SKPaymentQueue*)queue removedTransactions:(NSArray *)transactions
{
    
}



- (void)paymentQueue:(SKPaymentQueue*)queue restoreCompletedTransactionsFailedWithError:(NSError*)error
{
    

}


- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue*)queue

{
    
}



- (void)paymentQueue:(SKPaymentQueue*)queue updatedDownloads:(NSArray *)downloads
{
    

}







- (void)verifyPurchase:(SKPaymentTransaction*)transaction
{
    
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData*receiptData = [NSData dataWithContentsOfURL:receiptURL];
    NSString *encodeStr = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSURL *url = [NSURL URLWithString:ITMS_VERIFY_RECEIPT_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];

    NSString *payload = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", encodeStr];

    NSData *payloadData = [payload dataUsingEncoding:NSUTF8StringEncoding];

    [request setHTTPBody:payloadData];

    [request setHTTPMethod:@"POST"];

    NSURLResponse*response =nil;

    

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    if(data ==nil) {
        return;
    }
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if(jsonResponse !=nil) {
        if([[jsonResponse objectForKey:@"status"]intValue] ==0)
        {
            
        }
        else
        {
            
        }
    }
    
    [self finshTransaction:transaction];
}

- (void)completeTransaction:(SKPaymentTransaction*)transaction
{
    [self finshTransaction:transaction];
    
    OnceModel *model = [OnceModel defaultModel];
    WeakObject(self)
    [[BespeakManager defaultManager] recheckEveryDayCardWithInfoDic:model str:self.keyString successBlock:^(NSDictionary *repsonse) {
        
         StrongObject(self)
        
        if(strongObject.delegate&& [strongObject.delegate respondsToSelector:@selector(buySuccess:)]) {
            [strongObject.delegate buySuccess:transaction];
        }
    
    } failure:^(NSError *error) {
        
        StrongObject(self)
        if(strongObject.delegate&& [strongObject.delegate respondsToSelector:@selector(updatedTransactions:)]) {
             [strongObject.delegate updatedTransactions:EPaymentTransactionStateFailed];
        }
        
    }];
    
}


- (void)finshTransaction:(SKPaymentTransaction*)transaction
{
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];

}


@end
