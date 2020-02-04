







#import "NSString+Encoding.h"
#import "NSString+CilHash.h"

@implementation NSString (Encoding)



- (NSString *)aesEncryptWithHexKey:(NSString *)key hexIv:(NSString *)iv {
    NSData *aesKey = [key dataFromHexString];
    if (iv == nil) {
        
        iv = @"00000000000000000000000000000000";
    }
    NSData *aesIv = [iv dataFromHexString];
    NSData *resultData = [self aesEncryptWithDataKey:aesKey dataIv:aesIv];
    return [resultData base64EncodedStringWithOptions:0];
}


- (NSString *)aesEncryptWithKey:(NSString *)key iv:(NSString *)iv {
    NSData *aesKey = [key dataUsingEncoding:NSUTF8StringEncoding];
    if (iv == nil) {
        
        iv = @"00000000000000000000000000000000";
    }
    NSData *aesIv = [iv dataUsingEncoding:NSUTF8StringEncoding];
    NSData *resultData = [self aesEncryptWithDataKey:aesKey dataIv:aesIv];
    return [resultData base64EncodedStringWithOptions:0];
}


- (NSData *)aesEncryptWithDataKey:(NSData *)key dataIv:(NSData *)iv {
    return [self aesEncryptOrDecrypt:kCCEncrypt data:[self dataUsingEncoding:NSUTF8StringEncoding] dataKey:key dataIv:iv mode:kPaddingMode];
}


- (NSString *)aesECBEncryptWithHexKey:(NSString *)key {
    NSData *aesKey = [key dataFromHexString];
    NSData *resultData = [self aesECBEncryptWithDataKey:aesKey];
    return [resultData base64EncodedStringWithOptions:0];
}


- (NSString *)aesECBEncryptWithKey:(NSString *)key {
    NSData *aesKey = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *resultData = [self aesECBEncryptWithDataKey:aesKey];
    return [resultData base64EncodedStringWithOptions:0];
}


- (NSString *)aesECBEncryptWithBase64Key:(NSString *)key {
    NSData *aesKey = [[NSData alloc] initWithBase64EncodedString:key options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *resultData = [self aesECBEncryptWithDataKey:aesKey];
    return [resultData base64EncodedStringWithOptions:0];
}


- (NSData *)aesECBEncryptWithDataKey:(NSData *)key {
    NSData *aesIv = [@"00000000000000000000000000000000" dataFromHexString];
    return [self aesEncryptOrDecrypt:kCCEncrypt data:[self dataUsingEncoding:NSUTF8StringEncoding] dataKey:key dataIv:aesIv mode:kPaddingMode | kCCOptionECBMode];
}



- (NSString *)aesBase64StringDecryptWithHexKey:(NSString *)key hexIv:(NSString *)iv {
    NSData *aesKey = [key dataFromHexString];
    if (iv == nil) {
        
        iv = @"00000000000000000000000000000000";
    }
    NSData *aesIv = [iv dataFromHexString];
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSData *resultData = [NSString aesDecryptWithData:data dataKey:aesKey dataIv:aesIv];
    return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
}


+ (NSData *)aesDecryptWithData:(NSData *)data dataKey:(NSData *)key dataIv:(NSData *)iv {
    return [[NSString alloc] aesEncryptOrDecrypt:kCCDecrypt data:data dataKey:key dataIv:iv mode:kPaddingMode];
}


- (NSString *)aesECBBase64StringDecryptWithHexKey:(NSString *)key {
    NSData *aesKey = [key dataFromHexString];
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSData *resultData = [NSString aesECBDecryptWithData:data withDataKey:aesKey];
    return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
}


- (NSString *)aesECBBase64StringDecryptWithBase64Key:(NSString *)key {
    NSData *aesKey = [[NSData alloc] initWithBase64EncodedString:key options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSData *resultData = [NSString aesECBDecryptWithData:data withDataKey:aesKey];
    return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
}


+ (NSData *)aesECBDecryptWithData:(NSData *)data withDataKey:(NSData *)key{
    NSData *aesIv = [@"00000000000000000000000000000000" dataFromHexString];
    return [[NSString alloc] aesEncryptOrDecrypt:kCCDecrypt data:data dataKey:key dataIv:aesIv mode:kPaddingMode | kCCOptionECBMode];
}



















- (NSData *)aesEncryptOrDecrypt:(CCOperation)option data:(NSData *)data dataKey:(NSData *)key dataIv:(NSData *)iv mode:(int)mode{
    
    if ([iv length] != 16) {
        @throw [NSException exceptionWithName:@"Encrypt"
                                       reason:@"Length of iv is wrong. Length of iv should be 16(128bits)"
                                     userInfo:nil];
    }
    if ([key length] != 16 && [key length] != 24 && [key length] != 32 ) {
        @throw [NSException exceptionWithName:@"Encrypt"
                                       reason:@"Length of key is wrong. Length of iv should be 16, 24 or 32(128, 192 or 256bits)"
                                     userInfo:nil];
    }
    
    
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(option,
                                          kCCAlgorithmAES128,
                                          mode,
                                          [key bytes],     
                                          [key length],    
                                          [iv bytes],      
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    NSData *resultData = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytes:buffer length:encryptedSize];        
        free(buffer);
        return resultData;
    } else {
        free(buffer);
        @throw [NSException exceptionWithName:@"Encrypt"
                                       reason:@"Encrypt Error!"
                                     userInfo:nil];
        return resultData;
    }
    return resultData;
}



- (NSString *)desEncryptWithKey:(NSString *)key {
    NSData *desKey = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *resultData = [self desEncryptWithDataKey:desKey];
    return [resultData base64EncodedStringWithOptions:0];
}


- (NSData *)desEncryptWithDataKey:(NSData *)key {
    return [self desEncryptOrDecrypt:kCCEncrypt data:[self dataUsingEncoding:NSUTF8StringEncoding] dataKey:key mode:kPaddingMode | kCCOptionECBMode];
}


- (NSString *)desDecryptWithKey:(NSString *)key {
    NSData *desKey = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSData *resultData = [NSString desDecryptWithData:data dataKey:desKey];
    return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
}

+ (NSString *)desDecryptWithData:(NSData *)data key:(NSString *)key{
    NSData *desKey = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *resultData = [self desDecryptWithData:data dataKey:desKey];
    return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
}

+ (NSData *)desDecryptWithData:(NSData *)data dataKey:(NSData *)key {
    return [[NSString alloc] desEncryptOrDecrypt:kCCDecrypt data:data dataKey:key mode:kPaddingMode | kCCOptionECBMode];
}

- (NSData *)desEncryptOrDecrypt:(CCOperation)option data:(NSData *)data dataKey:(NSData *)key mode:(int)mode{





    
    
    size_t bufferSize = [data length] + kCCBlockSizeDES;
    void *buffer = malloc(bufferSize);
    
    
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(option,
                                          kCCAlgorithmDES,
                                          mode,
                                          [key bytes],     
                                          kCCKeySizeDES,    
                                          NULL,            
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    NSData *resultData = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytes:buffer length:encryptedSize];
        free(buffer);
        return resultData;
    } else {
        free(buffer);
        @throw [NSException exceptionWithName:@"Encrypt"
                                       reason:@"Encrypt Error!"
                                     userInfo:nil];
        return resultData;
    }
    return resultData;
}


- (NSData *)dataFromHexString {
    
    if (self.length == 0) {
        return nil;
    }
    
    static const unsigned char HexDecodeChars[] = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 
        2, 3, 4, 5, 6, 7, 8, 9, 0, 0, 
        0, 0, 0, 0, 0, 10, 11, 12, 13, 14,
        15, 0, 0, 0, 0, 0, 0, 0, 0, 0,  
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 10, 11, 12,   
        13, 14, 15
    };
    
    
    const char *source = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char *buffer;
    NSUInteger length = strlen(source) / 2;
    buffer = malloc(length);
    for (NSUInteger index = 0; index < length; index++) {
        buffer[index] = (HexDecodeChars[source[index * 2]] << 4) + (HexDecodeChars[source[index * 2 + 1]]);
    }
    
    NSData *result = [NSData dataWithBytes:buffer length:length];
    free(buffer);
    source = nil;
    
    return  result;
}

- (id)JSONObject
{
    if ([self isKindOfClass:[NSString class]]) {
        return [NSJSONSerialization JSONObjectWithData:[((NSString *)self) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    } else if ([self isKindOfClass:[NSData class]]) {
        return [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:nil];
    }
    
    return nil;
}

- (NSString *)md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5String];
}

@end


