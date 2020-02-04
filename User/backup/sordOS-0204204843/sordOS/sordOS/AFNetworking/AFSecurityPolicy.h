




















#import <Foundation/Foundation.h>
#import <Security/Security.h>

typedef NS_ENUM(NSUInteger, AFSSLPinningMode) {
    AFSSLPinningModeNone,
    AFSSLPinningModePublicKey,
    AFSSLPinningModeCertificate,
};



NS_ASSUME_NONNULL_BEGIN

@interface AFSecurityPolicy : NSObject <NSSecureCoding, NSCopying>


@property (readonly, nonatomic, assign) AFSSLPinningMode SSLPinningMode;


@property (nonatomic, strong, nullable) NSSet <NSData *> *pinnedCertificates;


@property (nonatomic, assign) BOOL allowInvalidCertificates;


@property (nonatomic, assign) BOOL validatesDomainName;






+ (NSSet <NSData *> *)certificatesInBundle:(NSBundle *)bundle;






+ (instancetype)defaultPolicy;






+ (instancetype)policyWithPinningMode:(AFSSLPinningMode)pinningMode;


+ (instancetype)policyWithPinningMode:(AFSSLPinningMode)pinningMode withPinnedCertificates:(NSSet <NSData *> *)pinnedCertificates;






- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust
                  forDomain:(nullable NSString *)domain;

@end

NS_ASSUME_NONNULL_END






