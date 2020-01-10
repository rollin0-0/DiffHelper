







#import "NSString+CilHash.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (CilHash)

- (NSString *)md5Hash {
    const char *plain = self.UTF8String;
    unsigned char *digest;
    digest = malloc(CC_MD5_DIGEST_LENGTH);
    
    CC_MD5(plain, (CC_LONG)strlen(plain), digest);
    
    NSString *encode = [self stringFromBytes:digest length:CC_MD5_DIGEST_LENGTH];
    free(digest);
    return encode;
}

- (NSString *)sha1Hash {
    const char *plain = self.UTF8String;
    unsigned char *digest;
    digest = malloc(CC_SHA1_DIGEST_LENGTH);
    
    CC_SHA1(plain, (CC_LONG)strlen(plain), digest);
    
    NSString *encode = [self stringFromBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    free(digest);
    return encode;
}

- (NSString *)sha224Hash {
    const char *str = self.UTF8String;
    unsigned char *digest;
    digest = malloc(CC_SHA224_DIGEST_LENGTH);
    
    CC_SHA224(str, (CC_LONG)strlen(str), digest);
    
    NSString *encode = [self stringFromBytes:digest length:CC_SHA224_DIGEST_LENGTH];
    free(digest);
    return encode;
}

- (NSString *)sha256Hash {
    const char *str = self.UTF8String;
    unsigned char *digest;
    digest = malloc(CC_SHA256_DIGEST_LENGTH);
    
    CC_SHA256(str, (CC_LONG)strlen(str), digest);
    
    NSString *encode = [self stringFromBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    free(digest);
    return encode;
}

- (NSString *)sha384Hash {
    const char *str = self.UTF8String;
    unsigned char *digest;
    digest = malloc(CC_SHA384_DIGEST_LENGTH);
    
    CC_SHA384(str, (CC_LONG)strlen(str), digest);
    
    NSString *encode = [self stringFromBytes:digest length:CC_SHA384_DIGEST_LENGTH];
    free(digest);
    return encode;
}

- (NSString *)sha512Hash {
    const char *str = self.UTF8String;
    unsigned char *digest;
    digest = malloc(CC_SHA512_DIGEST_LENGTH);
    
    CC_SHA512(str, (CC_LONG)strlen(str), digest);
    
    NSString *encode = [self stringFromBytes:digest length:CC_SHA512_DIGEST_LENGTH];
    free(digest);
    return encode;
}

- (NSString *)hmacMD5WithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgMD5, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)hmacSHA1WithKey:(NSString *)key {
    NSData *hashData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char *digest;
    digest = malloc(CC_SHA1_DIGEST_LENGTH);
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), [hashData bytes], [hashData length], digest);

    NSString *encode = [self stringFromBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    free(digest);
    cKey = nil;
    return encode;
}

- (NSString *)hmacSHA224WithKey:(NSString *)key {
    NSData *hashData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char *digest;
    digest = malloc(CC_SHA224_DIGEST_LENGTH);
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(kCCHmacAlgSHA224, cKey, strlen(cKey), [hashData bytes], [hashData length], digest);
    
    NSString *encode = [self stringFromBytes:digest length:CC_SHA224_DIGEST_LENGTH];
    free(digest);
    cKey = nil;
    return encode;
}

- (NSString *)hmacSHA256WithKey:(NSString *)key {
    NSData *hashData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char *digest;
    digest = malloc(CC_SHA256_DIGEST_LENGTH);
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), [hashData bytes], [hashData length], digest);
    
    NSString *encode = [self stringFromBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    free(digest);
    cKey = nil;
    return encode;
}

- (NSString *)hmacSHA384WithKey:(NSString *)key {
    NSData *hashData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char *digest;
    digest = malloc(CC_SHA384_DIGEST_LENGTH);
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), [hashData bytes], [hashData length], digest);
    
    NSString *encode = [self stringFromBytes:digest length:CC_SHA384_DIGEST_LENGTH];
    free(digest);
    cKey = nil;
    return encode;
}

- (NSString *)hmacSHA512WithKey:(NSString *)key {
    NSData *hashData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char *digest;
    digest = malloc(CC_SHA512_DIGEST_LENGTH);
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(kCCHmacAlgSHA512, cKey, strlen(cKey), [hashData bytes], [hashData length], digest);
    
    NSString *encode = [self stringFromBytes:digest length:CC_SHA512_DIGEST_LENGTH];
    free(digest);
    cKey = nil;
    return encode;
}


- (NSString *)stringFromBytes:(uint8_t *)bytes length:(int)length {
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02X", bytes[i]];
    }
    
    return [strM copy];
}


@end
