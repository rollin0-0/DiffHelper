




#import <Foundation/Foundation.h>



#pragma mark - extern definitions

extern BOOL isNull(id value);



#pragma mark - JSONValueTransformer interface

@interface JSONValueTransformer : NSObject

@property (strong, nonatomic, readonly) NSDictionary *primitivesNames;



+ (Class)classByResolvingClusterClasses:(Class)sourceClass;

#pragma mark - NSMutableString <-> NSString


- (NSMutableString *)NSMutableStringFromNSString:(NSString *)string;

#pragma mark - NSMutableArray <-> NSArray

- (NSMutableArray *)NSMutableArrayFromNSArray:(NSArray *)array;

#pragma mark - NSMutableDictionary <-> NSDictionary

- (NSMutableDictionary *)NSMutableDictionaryFromNSDictionary:(NSDictionary *)dict;

#pragma mark - NSSet <-> NSArray


- (NSSet *)NSSetFromNSArray:(NSArray *)array;


- (NSMutableSet *)NSMutableSetFromNSArray:(NSArray *)array;


- (NSArray *)JSONObjectFromNSSet:(NSSet *)set;


- (NSArray *)JSONObjectFromNSMutableSet:(NSMutableSet *)set;

#pragma mark - BOOL <-> number/string


- (NSNumber *)BOOLFromNSNumber:(NSNumber *)number;


- (NSNumber *)BOOLFromNSString:(NSString *)string;


- (NSNumber *)JSONObjectFromBOOL:(NSNumber *)number;

#pragma mark - string <-> number

- (NSNumber *)NSNumberFromNSString:(NSString *)string;


- (NSString *)NSStringFromNSNumber:(NSNumber *)number;


- (NSDecimalNumber *)NSDecimalNumberFromNSString:(NSString *)string;


- (NSString *)NSStringFromNSDecimalNumber:(NSDecimalNumber *)number;


#pragma mark - string <-> url


- (NSURL *)NSURLFromNSString:(NSString *)string;


- (NSString *)JSONObjectFromNSURL:(NSURL *)url;

#pragma mark - string <-> time zone



- (NSTimeZone *)NSTimeZoneFromNSString:(NSString *)string;


- (NSString *)JSONObjectFromNSTimeZone:(NSTimeZone *)timeZone;

#pragma mark - string <-> date






#pragma mark - number <-> date


- (NSDate *)NSDateFromNSNumber:(NSNumber *)number;

@end
