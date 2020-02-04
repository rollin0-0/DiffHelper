




#import <Foundation/Foundation.h>

#import "JSONModelError.h"
#import "JSONValueTransformer.h"
#import "JSONKeyMapper.h"


#if TARGET_IPHONE_SIMULATOR
#define JMLog( s, ... ) NSLog( @"[%@:%d] %@", [[NSString stringWithUTF8String:__FILE__] \
lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define JMLog( s, ... )
#endif


DEPRECATED_ATTRIBUTE
@protocol ConvertOnDemand
@end

DEPRECATED_ATTRIBUTE
@protocol Index
@end

#pragma mark - Property Protocols

@protocol Ignore
@end


@protocol Optional
@end


@interface NSObject (JSONModelPropertyCompatibility) <Optional, Ignore>
@end


#pragma mark - JSONModel protocol

@protocol AbstractJSONModelProtocol <NSCopying, NSCoding>

@required

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)err;



- (instancetype)initWithData:(NSData *)data error:(NSError **)error;


- (NSDictionary *)toDictionary;


- (NSDictionary *)toDictionaryWithKeys:(NSArray <NSString *> *)propertyNames;
@end


#pragma mark - JSONModel interface

@interface JSONModel : NSObject <AbstractJSONModelProtocol, NSSecureCoding>


+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray *)array DEPRECATED_MSG_ATTRIBUTE("use arrayOfModelsFromDictionaries:error:");
+ (void)setGlobalKeyMapper:(JSONKeyMapper *)globalKeyMapper DEPRECATED_MSG_ATTRIBUTE("override +keyMapper in a base model class instead");
+ (NSString *)protocolForArrayProperty:(NSString *)propertyName DEPRECATED_MSG_ATTRIBUTE("use classForCollectionProperty:");
- (void)mergeFromDictionary:(NSDictionary *)dict useKeyMapping:(BOOL)useKeyMapping DEPRECATED_MSG_ATTRIBUTE("use mergeFromDictionary:useKeyMapping:error:");
- (NSString *)indexPropertyName DEPRECATED_ATTRIBUTE;
- (NSComparisonResult)compare:(id)object DEPRECATED_ATTRIBUTE;




- (instancetype)initWithString:(NSString *)string error:(JSONModelError **)err;


- (instancetype)initWithString:(NSString *)string usingEncoding:(NSStringEncoding)encoding error:(JSONModelError **)err;




- (NSString *)toJSONString;


- (NSData *)toJSONData;


- (NSString *)toJSONStringWithKeys:(NSArray <NSString *> *)propertyNames;


- (NSData *)toJSONDataWithKeys:(NSArray <NSString *> *)propertyNames;




+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray *)array error:(NSError **)err;
+ (NSMutableArray *)arrayOfModelsFromData:(NSData *)data error:(NSError **)err;
+ (NSMutableArray *)arrayOfModelsFromString:(NSString *)string error:(NSError **)err;
+ (NSMutableDictionary *)dictionaryOfModelsFromDictionary:(NSDictionary *)dictionary error:(NSError **)err;
+ (NSMutableDictionary *)dictionaryOfModelsFromData:(NSData *)data error:(NSError **)err;
+ (NSMutableDictionary *)dictionaryOfModelsFromString:(NSString *)string error:(NSError **)err;


+ (NSMutableArray *)arrayOfDictionariesFromModels:(NSArray *)array;
+ (NSMutableDictionary *)dictionaryOfDictionariesFromModels:(NSDictionary *)dictionary;




- (BOOL)validate:(NSError **)error;



+ (JSONKeyMapper *)keyMapper;


+ (BOOL)propertyIsOptional:(NSString *)propertyName;


+ (BOOL)propertyIsIgnored:(NSString *)propertyName;


+ (Class)classForCollectionProperty:(NSString *)propertyName NS_SWIFT_NAME(classForCollectionProperty(propertyName:));


- (BOOL)mergeFromDictionary:(NSDictionary *)dict useKeyMapping:(BOOL)useKeyMapping error:(NSError **)error;

@end
