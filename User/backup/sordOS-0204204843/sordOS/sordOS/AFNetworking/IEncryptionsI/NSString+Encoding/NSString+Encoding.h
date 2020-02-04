







#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonHMAC.h>


#define kPaddingMode kCCOptionPKCS7Padding

@interface NSString (Encoding)

#pragma mark - AES加密


- (NSString *)aesEncryptWithHexKey:(NSString *)key hexIv:(NSString *)iv;


- (NSString *)aesEncryptWithKey:(NSString *)key iv:(NSString *)iv;


- (NSData *)aesEncryptWithDataKey:(NSData *)key dataIv:(NSData *)iv;


- (NSString *)aesECBEncryptWithHexKey:(NSString *)key;


- (NSString *)aesECBEncryptWithBase64Key:(NSString *)key;


- (NSString *)aesECBEncryptWithKey:(NSString *)key;


- (NSData *)aesECBEncryptWithDataKey:(NSData *)key;

#pragma mark - AES解密


- (NSString *)aesBase64StringDecryptWithHexKey:(NSString *)key hexIv:(NSString *)iv;


+ (NSData *)aesDecryptWithData:(NSData *)data dataKey:(NSData *)key dataIv:(NSData *)iv;


- (NSString *)aesECBBase64StringDecryptWithHexKey:(NSString *)key;


- (NSString *)aesECBBase64StringDecryptWithBase64Key:(NSString *)key;


+ (NSData *)aesECBDecryptWithData:(NSData *)data withDataKey:(NSData *)key;












#pragma mark - DES加密


- (NSString *)desEncryptWithKey:(NSString *)key;


- (NSData *)desEncryptWithDataKey:(NSData *)key;

#pragma mark - DES解密


- (NSString *)desDecryptWithKey:(NSString *)key;


+ (NSData *)desDecryptWithData:(NSData *)data dataKey:(NSData *)key;

+ (NSString *)desDecryptWithData:(NSData *)data key:(NSString *)key;

- (id)JSONObject;

- (NSString *)md5String;




@end



