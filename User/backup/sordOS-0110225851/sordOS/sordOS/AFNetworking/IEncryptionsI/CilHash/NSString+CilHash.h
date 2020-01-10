







#import <Foundation/Foundation.h>

@interface NSString (Hash)


- (NSString *)md5Hash;


- (NSString *)sha1Hash;


- (NSString *)sha224Hash;


- (NSString *)sha256Hash;


- (NSString *)sha384Hash;


- (NSString *)sha512Hash;

#pragma mark - HMAC


- (NSString *)hmacMD5WithKey:(NSString *)key;


- (NSString *)hmacSHA1WithKey:(NSString *)key;
- (NSString *)hmacSHA224WithKey:(NSString *)key;
- (NSString *)hmacSHA256WithKey:(NSString *)key;
- (NSString *)hmacSHA384WithKey:(NSString *)key;
- (NSString *)hmacSHA512WithKey:(NSString *)key;
@end
